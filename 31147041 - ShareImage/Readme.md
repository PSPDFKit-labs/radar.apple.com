# saving a shared image to the camera roll crashes the app

## Summary:
When sharing a `UIImage` through `UIActivityViewController` the view controller offers the option to save the image to the Photos app / camera roll. When selecting this, the app crashes because it does not provide a `NSPhotoLibraryUsageDescription` key in the Info.plist. The fact that this option is not available is known before presenting the activity view controller so it should simply not provide the option.

## Steps to Reproduce:
- Open the attached sample
- Run it on iPhone or iPad
- Tap the action bar button item in the top right corner
- Select ‘Save Image’

## Expected Results:
- Either this works or the ‘Save Image’ option isn’t shown in the list of available actions.

## Actual Results:
- The app crashes with this message in the console: “[access] This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSPhotoLibraryUsageDescription key with a string value explaining to the user how the app uses this data.”

## Regression:


## Notes:
UIKit should never present something that is known to crash once the user taps it. This can easily be overlooked in testing. So if Apple wants to enforce developers to provide that key in the Info.plit when sharing images, this should either crash or produce a log message when entering the activity view controller, but it should not crash only after the user taps the action, especially as it would be easy to detect up front if this key is there and simply hide the action in that case.
