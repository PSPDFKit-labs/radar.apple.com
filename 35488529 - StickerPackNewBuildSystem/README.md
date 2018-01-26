## Unexpected mutating node for New Build System

http://openradar.appspot.com/35488529

Summary:
We cannot use the new build system as it emits a warning for the Messages Stickers.

Steps to Reproduce:
Have app with Messages stickers. Observe warning.

Expected Results:
No warning.

Actual Results:

Showing Recent Issues
:-1: unexpected mutating task ('CodeSign /Users/steipete/Builds/Viewer-bfkysqxtllvridggpcyephecpdwy/Build/Products/Debug-iphonesimulator/PDF\ Stickers.appex') with no relation to prior mutator ('Ditto /Users/steipete/Builds/Viewer-bfkysqxtllvridggpcyephecpdwy/Build/Products/Debug-iphonesimulator/PDF\ Stickers.appex/PDF\ Stickers /Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Library/Application\ Support/MessagesApplicationExtensionStub/MessagesApplicationExtensionStub') (in target 'PDF Stickers')

Version:
9.2b2 (9C34b)

Notes:
Last thing next to rdar://35488519 so we can switch and enjoy the performance gains.

Update: Still happens on Xcode 9.3b1.
