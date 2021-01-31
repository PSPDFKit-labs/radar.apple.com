//
//  SwiftUIView.swift
//  SwiftUIKeyboard
//
//  Created by Peter Steinberger on 30.01.21.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)

        if #available(iOS 14.0, *) {
        Button(action: {
            print("back!")
        }) {
            Text("BACK")
        }.keyboardShortcut("a") // leftArrow , modifiers: [.command]

        Button(action: {
              print("Button Tapped!!")
          }) {
              Text("Button")
          }.keyboardShortcut("s")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
