# Host apps can interfere with the tint color of extensions they are invoking

Summary:
When a host app configures a views tintColor by setting it through `UIAppearance`, this also populates in to any extensions this app invokes. With this you can change the look of the UI of out of process views, both for system extensions and 3rd party extensions.

Steps to Reproduce:
- Open the attached sample project and run it either on device or simulator
- Note the `UIAppearance` call in `-[AppDelegate init]`
- Tap the share button
- Choose an extension to share the content with. E.g. Messages, Twitter, Add To iCloud Drive or any other extension. This works with almost all extensions.

Expected Results:
- The extension looks like it would without setting the app delegate. So e.g. Messages or iCloud Drive would have it’s usual blue tint color set on buttons.

Actual Results:
- The tint color in the extensions also is green like the one in the host app.

Regression:
This seems to work mit almost all extensions. The only extensions I tried that didn’t suffer from this bug are Microsoft OneNote and Notes. Mail seems to work at first, as the buttons in the bar are blue, but as soon as you tap on ‘Cancel’, the presented action sheet picks up the wrong tint color as well.
Another important thing here is: Setting a custom tintColor in the action extension does not fix this issue. I haven’t found any way to override the tint color set from the host app inside my own action extension.

Notes:
I am reporting that not because I want to set my tint color like this and than have the extensions look okay, but its more like the other way around. I am working on an Action Extension and I want my tintColor to look okay. With this bug, an Action Extension would basically need to be build in a way that it works with any tint color, even with colors like white.