## Improve UITextView rendering when zoomed in

http://openradar.appspot.com/21443666

Summary:

If a UITextView is placed inside a scroll view that is zoomed in, the rendered text doesn’t get re-rednered at a higher resolution for crisp display. The same is true for UITextField. 

One workaround is to set UIView.contentScaleFactor / CALayer.contentScale. This works well for UITextField, however UITextView requires more work. We need to recursively walk the UIView and CALayer hierarchies and apply the content scale to every view and layer. Walking the layer hierarchy separately is important here since we otherwise can’t reach all CATiledLayers that are used for text rendering. 

I would like to request that this process would be simplified and better documented. 

Steps to Reproduce:

See the attached sample project. Try running the project on an iPad and zooming the text. The process will only work correctly if the “recursive” switch in the navigation bar is set. The project shows how contentScaleFactor and contentScale can be used to achieve sharp text rendering. 

Expected Results:

The text would automatically be rendered sharply. 

Actual Results:

A workaround is needed to achieve the desired effect. I was only able to figure out all details after some consulting at WWDC labs. 

Regression:

All iOS versions all devices.
