# FB7827311: objc_direct does not recognize super calls from subclasses when they are declared in one file

objc_direct does not recognize super calls from subclasses when they are declared in one file. This was a tricky one to find.

Repro:
Run the app and press the button; observe that block action is not called.
PSPDFToolbarTickerButton is annotated with PSPDF_OBJC_DIRECT_MEMBERS. 
Remove annotation to fix issue.

Problem: Code calls super on touchDown/touchUp methods, but they are made direct.
The compiler could be smart enough to detect this and keep them dynamic, as they call super.

This only works because things are declared in the same file. Move the whole implementation block to PSPDFToolbarButton and see that things no longer compile because “/Users/steipete/Projects/Test/ObjcDirectBug/ObjcDirectBug/ToolbarButton.m:122:12: No visible @interface for 'PSPDFToolbarButton' declares the selector 'touchDown’”. If these are declared in the header, they are also marked dynamic, fixing the bug.
