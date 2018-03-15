//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

enum ControlerType {
    case normal, documentBrowser
}

// Change controller type to observe different isBeingPresented values
let type = ControlerType.documentBrowser

let presentingViewController: UIViewController = {
    switch type {
    case .normal:
        return UIViewController()
    case .documentBrowser:
        return UIDocumentBrowserViewController()
    }
}()

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = presentingViewController

DispatchQueue.main.async {
    let vc = UINavigationController()
    vc.view.backgroundColor = .gray

    presentingViewController.present(vc, animated: true)

    vc.isBeingPresented
}
