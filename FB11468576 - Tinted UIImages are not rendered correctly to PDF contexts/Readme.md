# Basic Information

Please provide a descriptive title for your feedback:
Tinted UIImages are not rendered correctly to PDF contexts

Which area are you seeing an issue with?
UIKit

What type of feedback are you reporting?
Incorrect/Unexpected Behavior

# Description

Please describe the issue and what steps we can take to reproduce it:
When drawing tinted UIImage objects to PDF contexts they appear as colored rectangles in the output PDF.
Instead of the shape contained in the image being tinted but retaining it's original shape a tinted rectangle will be rendered.

Steps to reproduce:
- Please see the attached example project to reproduce the problem
- The example project demonstrates the rendering of multiple combinations of asset images (Default / Template rendering) and modifications (tinted / untinted)

Expected result:
- The image should be rendered as a comment bubble with a red tint color

Actual result:
- The image is rendered as a red rectangle

