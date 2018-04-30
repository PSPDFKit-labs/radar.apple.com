CALayer/UIView should officially support blend modes via layer.compositingFilter
Originator:	steipete	
Number:	rdar://39832806	Date Originated:	30-Apr-2018 01:23 PM
Status:	Open	Resolved:	
Product:	iOS + SDK	Product Version:	11.3.1
Classification:	Enhancement	Reproducible:	Always
 
Summary:
We are trying to build code for fast drawing which multiplies the color into the PDF.

This is something other major platforms support, including Android and the Web via CSS: https://css-tricks.com/basics-css-blend-modes/

On Android this can be set via an optional Paint property on setLayerType n the view:
https://developer.android.com/reference/android/view/View#setLayerType(int,%20android.graphics.Paint)

On iOS this can be set via layer.compositingFilter using “multiplyBlendMode”. This works, but the documentation states “This property is not supported on layers in iOS.” as per https://developer.apple.com/documentation/quartzcore/calayer/1410748-compositingfilter

Steps to Reproduce:
Documentation bug or missing feature/no sample project required.
I still attach one for completeness, and found https://github.com/arthurschiller/CompositingFilters as open source project

Expected Results:
iOS should have official support for blend modes in views/layers.

Actual Results:
iOS supports layer.compositingFilter, but documentation states that it does not, so we’re unsure if this can be used.

Version:
11.3.1

Notes: