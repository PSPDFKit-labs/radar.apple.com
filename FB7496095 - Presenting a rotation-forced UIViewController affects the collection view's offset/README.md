FB7496095 - Presenting a rotation-forced UIViewController affects the collection view's offset

How to Reproduce:

- Open the attached and modified version the ImageFeed sample project. The original sample project can be found here: https://developer.apple.com/documentation/uikit/uicollectionview/customizing_collection_view_layouts
- Launch the app on an iPhone simulator. This also happens on iPad devices.
- Scroll down a bit to any specific offset. 
- Please observe the top most visible image in the collection view.
- Tap on the the "Present" right bar button item to present the rotation-forced UIViewController.
- Tap on the big red button in the center of the rotation-forced UIViewController to dismiss it.

Expected:

The collection view's offset should remain unchanged after dismissing the rotation-forced UIViewController.

Actual:

The collection view's offset changed after dismissing the rotation-forced UIViewController.

Additional information:

If we comment out the code which forces the rotation in the UIViewController, the offset is unchanged, as expected.

```swift
    // Comment out these two methods and notice that the issue is gone.
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
```

Please refer to the attached `with-forced-rotation.gif` and `without-forced-rotation.gif` animated gifs to see the the behaviours.