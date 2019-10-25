# Mac Catalyst: action sheet has a broken hover implementation for Cancel button + resizes when app goes into background

Please provide a descriptive title for your feedback:
Mac Catalyst: action sheet has a broken hover implementation for Cancel button + resizes when app goes into background
Which area are you seeing an issue with?
UIKit
What type of issue are you reporting?
Incorrect/Unexpected Behavior
Description
Please describe the issue and what steps we can take to reproduce it:
The action sheet uses a hover effect on Catalyst. However this is broken for the Cancel button, there is an area where neither hover nor tap works.
This is kinda hard to explain - see the attached video.

When the app enters background, it “fixes” itself by weirdly resizing, but then the hover effect works as expected. 🤷‍♂️

Using macOS Catalina b9 + Xcode 11.1 GM.

Video is from PDF Viewer for Mac.

Example to reproduce is attached as well.

Note: We want to alert sheet on purpose with dedicated cancel button, in the spirit of https://pspdfkit.com/blog/2016/popovers-on-popovers/ (just suboptimal example)
