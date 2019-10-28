# FB7414880: UINavigationBarAppearance is not applied after navigation bar is already visible

Customizing `UINavigationBar` appearance via the new `UINavigationBarAppearance` has no effect after such `UINavigationBar` is already added to the view hierarchy.

In other words, the below code has no effect for a `navigationBar` that is already in the view hierarchy:

```
let appearance = UINavigationBarAppearance()
appearance.backgroundColor = .systemRed

navigationBar.standardAppearance = appearance
navigationBar.compactAppearance = appearance
navigationBar.scrollEdgeAppearance = appearance
```

STEPS TO REPRODUCE

1. Open the attached Demo project and run it.
2. Tap “Change color" button.

EXPECTED RESULT

The navigation bar changes its background color.

ACTUAL RESULT

No effect.

KNOWN WORKAROUND

Asking navigation bar to lay out via `setNeedsLayout()` makes it work. Uncomment the last line in `ViewController.changeColor()` in the Demo project to see this in action.
