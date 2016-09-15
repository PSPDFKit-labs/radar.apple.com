## Presentation controllers do not know their future container traits

http://openradar.appspot.com/23273355

Summary:
There are two trait collections relevant to a presentation controller: the container traits and the presented traits. The presented traits can be found by applying the presentation controller’s overrideTraitCollection on top of the container traits. No reverse operation is possible: the container traits can not be found from the presented traits.

Presentation controllers are notified of changes to size and the trait collection via viewWillTransitionToSize:withTransitionCoordinator: and willTransitionToTraitCollection:withTransitionCoordinator:. The size in question is the size of the container, but the traits are the presented traits.

This means that if a presentation controller implements overrideTraitCollection, willTransitionToTraitCollection:withTransitionCoordinator: is of limited use, and isn’t called at all in transitions where the presented traits do not change.

Steps to Reproduce:
A sample project is attached which uses a custom presentation controller, CentralPresentationController, which shows the presented view in a small square. It implements overrideTraitCollection so the presented view controller is always compact × compact.

CentralPresentationController logs a message if willTransitionToTraitCollection:withTransitionCoordinator: is called.

Change the container size class (e.g. on iPad Air 2 in Split View) and notice that willTransitionToTraitCollection:withTransitionCoordinator: is never called.

Expected Results:
For presentation controllers to be able to know about their future container traits just before a transition. They can easily find their future presented traits from this if they want.

Equivalence between the size used by viewWillTransitionToSize:withTransitionCoordinator: and the traits used by willTransitionToTraitCollection:withTransitionCoordinator:. Or since this isn’t the case, for this to be clearly documented.

Actual Results:
Presentation controllers do not know their future container traits.

Version:
iOS 9, Xcode 7.1 (7B91b)

Notes:
The specific use-case that led to finding this problem is dismissing and re-presented a view controller on trait changes in order to support arbitrary adaptivity. See rdar://22394182.

Workaround: ensure presentation controllers return nil from overrideTraitCollection.

Configuration:
iPad Air 2 simulator
