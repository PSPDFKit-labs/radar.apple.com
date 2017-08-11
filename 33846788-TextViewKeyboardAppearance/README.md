## Assertion failure when setting keyboardAppearance on UITextView using UIAppearance

http://openradar.appspot.com/33846788

Summary:
2017-08-11 13:03:35.872676+0200 TextViewKeyboardAppearance[8866:2782839] *** Assertion failure in void PushNextClassForSettingIMP(id, SEL)(), /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit/UIKit-3694.3.4/UIAppearance.m:760
2017-08-11 13:03:50.953630+0200 TextViewKeyboardAppearance[8866:2782839] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Please file a radar on UIKit with this log if you see this assertion. selectorString = setKeyboardAppearance:, exercisedImplementations = {
    "setKeyboardAppearance:" =     (
    );

Setting the keyboardAppearance on UITextView using UIAppearance using the following code triggers the above assertion:

let textView = UITextView.appearance()
textView.keyboardAppearance = .dark

Setting any other property (e.g. tintColor) works fine. Setting keyboardAppearance on UITextField via UIAppearance works fine as well. The assertion only happens with UITextView. Setting keyboardAppearance directly, without using UIAppearance, on UITextView works fine as well.

This apparently also only happens if there is a text view in the view hierarchy. When not adding the text view in ViewController.swift in the attached sample project, the assertion is not triggered.

Tested on Xcode 8.3.3 + 9b5 / iOS 9, 10, 11b5 on Simulator and device.

Steps to Reproduce:
- Open the attached sample project in Xcode 8 or 9.
- Run it on any device or Simulator


Expected Results:
No assertion is triggered.

Actual Results:
Assertion in UIAppearance.m is triggered.

Version:
iOS 9/10/11

Notes:
See AppDelegate.swift/ViewController.swift for the UIAppearance/UITextView setup.