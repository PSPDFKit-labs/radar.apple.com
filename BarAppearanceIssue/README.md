## Local set values of UIBarAppearance are overridden by values set via appearance proxy

FB7300841

Please provide a descriptive title for your feedback:
Local set values of UIBarAppearance are overridden by values set via appearance proxy

Which area are you seeing an issue with?
UIKit

What type of feedback are you reporting?
Incorrect/Unexpected Behavior

Description
Please describe the issue and what steps we can take to reproduce it:
The values set to the UINavigationBar (and UIToolbar) properties of type UIBarAppearance using the Appearance Proxy API override the locally set values of the same properties of these object types.

Steps to Reproduce:
- Open the attached sample project: BarAppearanceIssue
- Open the SceneDelegate.swift and CustomNavigationController.swift file side by side.
- Run the application without any changes.
- Note that the background color of the navigation bar is green.
- The green background color to the navigation bar is set using the Appearance Proxy API in SceneDelegate.scene(_:willConnectTo:options:).
- However obsertve that the local value of red background color is set to the navigation bar in CustomNavigationController.viewDidLoad.

Since the local set values should be overriding the values set using appearance proxy api, the colour of the navigation bar background
should have been red.

Comment out the assignments in SceneDelegate for the values set in CustomNavigationController.viewDidLoad to take effect.

Note: Other properties of the navigation bar which support values being set by appearance proxy are not overridden.