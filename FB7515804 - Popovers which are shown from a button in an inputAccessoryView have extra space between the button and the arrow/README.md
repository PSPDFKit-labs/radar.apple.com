# Basic Information

## Please provide a descriptive title for your feedback:

Popovers which are shown from a button in a UITextField / UITextView's inputAccessoryView have extra space between the button and the arrow.

## Which area are you seeing an issue with?

UIKit

## What type of feedback are you reporting?

Incorrect/Unexpected Behavior

# Description

## Please describe the issue and what steps we can take to reproduce it:

Popovers which are shown from a button in a UITextField / UITextView's inputAccessoryView have extra space between the button and the arrow. Whether or not there is any extra space is dependant on the device type: devices which have a non-zero bottom safe area inset (iPad Pro, iPhone 11 Pro Max, etc.) show extra space. Please see attached screenshots. 

Note: Devices with a bottom safe area inset of 0 (iPad Air 2, iPhone 8 Plus, etc.) do not show this extra space.

Steps to reproduce:

* Run the attached project PopoverPlayground on an iPad Pro simulator and iPhone 11 Pro Max simulator.
* Select the UITextField, and tap on the button in the accessory view.

Expected result:

* The arrow of the popover should be aligned right on top of the button without any extra space.

Actual result:

* There is extra space between the popover arrow and the top of the button.