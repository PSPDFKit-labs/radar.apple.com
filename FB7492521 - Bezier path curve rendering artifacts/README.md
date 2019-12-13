# Basic Information

## Please provide a descriptive title for your feedback:

Bezier path curve rendering artifacts

## Which area are you seeing an issue with?

Core Graphics API

## What type of feedback are you reporting?

Incorrect/Unexpected Behavior

# Description

## Please describe the issue and what steps we can take to reproduce it:

When rendering a UIBezierPath with CoreGraphics or using a CAShapeLayer, certain configurations of endpoints and control points result in ugly rendering artifacts near the end points and joining points of the curve. This is especially noticeable when the line width of the path is large.

Reproducible in the latest stable Xcode (11.3) + latest stable iOS (13.3) (simulator or device). We tested on an iOS 11 device as well with identical results.

The attached example project showcases a simple bezier path with 4 points. There is a button to cycle through some buggy configurations, which cause unnatural artifacts in the path drawing. The red and black points and the lines are useful as a debug tool to see the control points and the shape of the bezier path but are unrelated to the bug. The points can also be dragged around and the artifacts also occur when two points are close together. We also included some screenshots that illustrate the issue.

Those issues could also be found occasionally when using the "ink" tool in our shipping app PDF Viewer. This is however much harder to reproduce, so we recommend using the example project.
