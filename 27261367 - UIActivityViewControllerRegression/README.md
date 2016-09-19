## Breaking changing on UIActivityViewController when checking modalPresentationStyle leads to crash

http://openradar.appspot.com/27261367

Area:
UIKit

Summary:
In PSPDFKit, we check the modalPresentationStyle before accessing the popoverPresentationController. There have been bugs in the past where merely accessing the popoverPresentationController property caused behavior changes and/or retain cycles, so we added extra checks to ensure we only try to access it when modalPresentationStyle is set to UIModalPresentationPopover.

This is now causing crashes on all PSPDFKit installs before today’s 5.4.1 release. And since it will take our customers a while to update, this is very very bad.

In iOS 9, [UIActivityViewController setModalPresentationStyle:] was implemented as a simple check to prevent form/page sheet styles and then set the style. This is fine. In iOS 10, there’s an added check for -[UIActivityViewController allowsEmbedding] under certain conditions (_UIAppUseModernRotationAndPresentationBehaviors, which of course is true for most modern apps)

If this is all the case, then the value is set to 100. Our code expects UIModalPresentationPopover which has value 7. Value 100 seems to be an internal value and is not defined in the enum.

I stopped digging what value 100 does, but it seems to be used in other (internal) view controllers as well.

Steps to Reproduce:
Run the attached sample on an iPad with iOS 9: works. iOS 10: throws an exception.

Expected Results:
I’m fine with this behavior change (even if I believe that internal implementation details should not be leaked like this) but if you do that, please add a UIApplicationLinkedOnVersion check to keep behavior for < SDK 10 linked apps.


Actual Results:
Behavior changes. All PSPDFKit-using apps crash when the activity button is pressed and this is really bad since the public beta is now out.

This is an unexpected, undocumented behavior change. It’s not documented (please correct me if I’m wrong) that checking for modalPresentationStyle is forbidden.

Version:
iOS 10.0b2

Notes:
You’ll find the most up-to-date sample code for all our radars on https://github.com/PSPDFKit-labs/radar.apple.com

Configuration:
Xcode 10.0b2

Fixed on iOS 10 GM.
