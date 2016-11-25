## Summary:

When the app goes into the background in certain scenarios it captures screenshots for various resolutions and thus changes the size class. If you react to this size class changes by adopting your navigation items, and if you have custom bar button items in your navigation bar, these items get their user interaction disabled and stay that way.

## Steps to Reproduce:

0. Watch the video for easy reproduction steps
1. Open the sample app and run it on an iPad (Simulator)
2. Open any app in the foreground, e.g. Safari
3. Open the sample app in the slide over view
4. Note that the button in the navigation bar can be tapped
5. Swipe from the top screen edge down on the side view to toggle the task switcher in the slide over view
6. Choose another app
7. Repeat step 5 and open the sample app again
8. Tap the top button again

## Expected Results:

The same happens as in step 4: An alert view is shown that tells you that you tapped the button.

## Actual Results:

Nothing happens. The button does not respond to any touch events anymore. It also doesn’t show any highlight when touching it.
If you check the `userInteractionEnabled` property of the button it returns `NO`.

## Regression:

## Notes:

After looking through the disassembly I _think_ I know what’s going on but my analysis may be wrong. Anyway, maybe it helps to find the issue faster:
My understanding is that when changing navigation bar items, the navigation bar disables the user interaction for all the views in it. To do this it first calls `isUserInteractionEnabled`, stores that value as associated object to the view, calls `setUserInteractionEnabled:NO` and then does its animation. Once that animation completes, it reads the stored value from the associated object again and passes this on to `setUserInteractionEnabled:`.
Now when the app enters the background, there are two changes in the size class happen very quickly. Each time we adjust the amount of items in the navigation bar. These changes happen pretty quick, so that the first animation didn’t complete when the second one starts. So for the second one, the navigation bar again reads `isUserInteractionEnabled`, which now returns `NO` because it was set to that by the navigation bar in the first pass. It now stores this in the associated object, overriding the original (correct) value. So now when the animation finishes, it ‘restores’ the state of the `userInteractionEnabled` property to `NO`, which is incorrect. Instead, in the second pass, it would need to check if there already is a value stored (or just do a `newAssociatedValue = currentValue || oldAssociatedValue`).