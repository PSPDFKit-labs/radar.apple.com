FB7631144 - Uanble to compile Catalyst project when C++ modules are enabled: Definition of 'NSLayoutYAxisAnchor' must be imported from module 'AppKit.NSLayoutGuide' before it is required

Uanble to compile Catalyst project when C++ modules are enabled: Definition of 'NSLayoutYAxisAnchor' must be imported from module 'AppKit.NSLayoutGuide' before it is required

We have a mixed Swift/ObjC project with some ObjC++ files. We compile for iOS and Mac Catalyst.
Certain files do not compile after enabling -fmodules -fcxx-modules because AppKit declares some of the same classes as UIKit, and files are being imported in Catalyst via #import <UIKit/NSToolbar+UIKitAdditions.h>

Error:
/Users/steipete/Projects/radar.apple.com/CppModulesCatalyst/CppModulesCatalystIssue/CppModulesCatalystIssue/ViewController.mm:33:10: Definition of 'NSLayoutYAxisAnchor' must be imported from module 'AppKit.NSLayoutGuide' before it is required

The fix is Convert file to ObjC, remove C++ (not always an option)

Ideally the Compiler should be smarter. See attached sample.
