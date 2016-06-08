Summary:
UITableViewController calls [super init] inside initWithStyle:. This breaks the designated initializer chain and prevents subclasses from blocking e.g. initWithNibName:bundle: from being called.

Expected Results:
UITableViewController should call [super initWithNibName:bundle:] inside initWithStyle:.

Actual Results:
UITableViewController calls [super init] inside initWithStyle:, which then calls [self initWithNibName:bundle:]. This results in the overridden [self initWithNibName:bundle:] being called, which might be overridden to prevent direct calls to it, resulting in a crash/assertion.

Regression:
This has always been a bug but with the SDK 8.3 changes has become more visible.

Notes:
See http://petersteinberger.com/blog/2015/uitableviewcontroller-designated-initializer-woes/ for details.

No sample project necessary, but since I know that there are people pushing back if there is no code attached to a radar, I’ve added a simple Sample project that asserts when running - but should work correctly if thus bug is fixed.




Fixed in iOS 9