//
//  ContentView.swift
//  NavBarItemsLightInDarkModeUntilScroll
//
//  Created by Nishant Desai on 28/01/26.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        UIKitNavigationControllerWrapper()
            .ignoresSafeArea()
    }
}

struct UIKitNavigationControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let scrollViewController = ScrollViewController()
        let navigationController = UINavigationController(rootViewController: scrollViewController)
        navigationController.navigationBar.prefersLargeTitles = false
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
}

#Preview {
    ContentView()
}
