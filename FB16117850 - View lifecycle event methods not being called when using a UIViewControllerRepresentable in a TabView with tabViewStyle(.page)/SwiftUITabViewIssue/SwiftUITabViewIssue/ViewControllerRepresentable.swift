//
//  ViewControllerRepresentable.swift
//  SwiftUITabViewIssue
//
//  Created by Stefan Kieleithner on 18.12.24.
//

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        ViewController()
    }
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
