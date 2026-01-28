# Navigation bar items appear in light mode in dark appearance until scrolling

## Basic Information

### Please provide a descriptive title for your feedback:
Navigation bar items appear in light mode in dark appearance until scrolling

### Which platform is most relevant for your report?
iOS

### Which technology does your report involve?
UIKit

### What type of feedback are you reporting?
Incorrect/Unexpected Behavior

### What build does the issue occur on?
iOS 26.2 (23C55)

### Where does the issue occur?
On device / Simulator

## Description

### Please describe the issue and what steps we can take to reproduce it:
The project hosts a UIKit `UINavigationController` inside a SwiftUI app via `UIViewControllerRepresentable`. The root view controller (`ScrollViewController`) presents a `UICollectionView`, configures scroll edge effects, and adds a `UIScrollEdgeElementContainerInteraction`.

Steps to reproduce:
1. Build and run the `NavBarItemsLightInDarkModeUntilScroll` target so the app is visible on screen.
2. Switch the system appearance while the app is running using one of the following:
   - Toggle Dark Appearance from Control Center (long-press Brightness).
   - In Xcode, use **Environment Overrides** to enable Dark Appearance.
3. Observe the navigation bar items (Info, Add, Refresh) at the initial scroll position.
4. Scroll the collection view slightly while the navigation bar remains visible and observe the items again.

Expected Behavior:
In Dark Appearance, navigation bar items should use the dark-mode tint (light/white) immediately, including at the initial scroll position.

Actual Behavior:
After switching to Dark Appearance, the navigation bar items render with a light-mode tint (dark/black) at the initial scroll position. After scrolling a bit, the items update and render correctly. The navigation bar remains visible while content scrolls underneath it. The rest of the UI (title, status bar, background) updates to the selected appearance.

Additional observation:
If you switch to Dark Appearance at the initial scroll position (items wrong), then switch back to Light Appearance without scrolling, the navigation bar items flip and render with a dark-appearance tint (light/white), which is incorrect for Light Appearance. Scrolling fixes the tint there as well.

Attachments:
- `NavBarItemsLightInDarkModeUntilScroll.zip` (full sample project)
