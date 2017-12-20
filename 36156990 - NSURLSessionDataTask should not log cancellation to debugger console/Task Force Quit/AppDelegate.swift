//
//  AppDelegate.swift
//  Task Force Swift
//
//  Copyright © 2017 PSPDFKit GmbH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, URLSessionTaskDelegate {

    var window: UIWindow?
    var session: URLSession?
    var currentTask: URLSessionTask?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
        return true
    }

    /// Kicks off a new request that will be cancelled while running
    @IBAction
    func makeRequest(_ sender: Any) {
        if (currentTask != nil) {
            print("Not making request: still got one")
            return
        }

        // PSPDFKit always upgrades to HTTPS, so we use this to cancel the request after it has started, but before it has finished
        let GETHome = URLRequest(url: URL(string: "http://pspdfkit.com")!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 3600)
        currentTask = session?.dataTask(with: GETHome)
        currentTask?.resume()
    }

    // :MARK - URLSession(Task)Delegate
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        // cancel the task before we would allow it to proceed
        task.cancel()
        OperationQueue.main.addOperation {
            completionHandler(request)
        }
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            switch error {
            case CocoaError.userCancelled, URLError.cancelled:
                // we really don’t care about cancellation
                break
            default:
                print("Uh oh: \(error)")
            }
        } else {
            print("completed successfully — should **NEVER** be printed")
        }
        currentTask = nil
    }
}

