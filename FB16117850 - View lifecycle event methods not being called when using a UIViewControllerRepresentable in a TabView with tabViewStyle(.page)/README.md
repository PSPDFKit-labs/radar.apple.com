# View lifecycle event methods not being called when using a UIViewControllerRepresentable in a TabView with tabViewStyle(.page)

## Basic Information

### Please provide a descriptive title for your feedback:
View lifecycle event methods not being called when using a UIViewControllerRepresentable in a TabView with tabViewStyle(.page)

### Which platform is most relevant for your report?
iOS

### Which technology does your report involve?
SwiftUI

### What type of feedback are you reporting?
Incorrect/Unexpected Behavior

### What build does the issue occur on?
iOS 18.1 Seed 6 (22B5069a)

### Where does the issue occur?
In Xcode

## Description

### Please describe the issue and what steps we can take to reproduce it:
When wrapping a UIViewController subclass, that overrides view containment and view lifecycle events like `viewWillAppear(_:)`, `viewIsAppearing(_:)`, or `willMove(toParent:)`, in a UIViewControllerRepresentable that is then used in a SwiftUI TabView with the  tabViewStyle(.page) modifier, none of the view lifecycle event methods are being called.
It looks like the view controller containment is not setup correctly in this specific case.

When removing the tabViewStyle(.page) modifier, all methods are being called as expected.

Please see that attached sample project where this can be seen.

Expected Behavior:
View controller containment and view lifecycle events should always be called no matter which SwiftUI view a UIViewControllerRepresentable is contained in.

Actual Behavior:
View controller containment and view lifecycle events are not called when in a TabView with tabViewStyle(.page).

I observed at least the following methods are not being called (this might be an incomplete list):
- viewWillAppear(_ animated: Bool)
- viewIsAppearing(_ animated: Bool)
- viewDidAppear(_ animated: Bool)
- viewLayoutMarginsDidChange()
- willMove(toParent parent: UIViewController?)
- didMove(toParent parent: UIViewController?)
- viewWillDisappear(_ animated: Bool)
- viewDidDisappear(_ animated: Bool)

This can be reproduced with iOS 18.2 and Xcode 16.2.