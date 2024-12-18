//
//  SwiftUITabViewIssueApp.swift
//  SwiftUITabViewIssue
//
//  Created by Stefan Kieleithner on 18.12.24.
//

import SwiftUI

@main
struct SwiftUITabViewIssueApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ViewControllerRepresentable()
                Color.gray
            }
            // - Using tabViewStyle(.page) causes the view controller containment and view lifecycle methods in ViewController to not be called.
            //   See that in the console only "viewDidLoad() called" and "viewDidLayoutSubviews() called" is printed.
            // - When commenting out the following line, the methods are called as expected.
            //   See that in the console all view lifecycle methods are printed.
            .tabViewStyle(.page)
        }
    }
}
