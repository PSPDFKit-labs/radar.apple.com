NSUndoManager throws NSInternalInconsistencyException in endUndoGroupRemovingIfEmpty if removeAllActions is called inside handler
Originator:    steipete    Modify My Radar
Number:    rdar://46395110    Date Originated:    01-Dec-2018 11:46 AM
Status:    Open    Resolved:    
Product:    iOS + SDK    Product Version:    12.1
Classification:    Crash/Hang/Data Loss    Reproducible:    Always

Summary:
Please see attached test case. When removeAllActions is called inside an undo handler and a group is open, NSUndoManager throws "NSInternalInconsistencyException", "_endUndoGroupRemovingIfEmpty:: NSUndoManager 0x600001026620 is in invalid state, endUndoGrouping called with no matching begin

_endUndoGroupRemovingIfEmpty checks if a group needs to be closed, but does that before invoking the undoHandler, and then not checking again.

This is an example where you might quickly say "API misuse". In a real-world application with 20 layers and user-facing API, it is MUCH harder to prevent calls from various model change callbacks that don't affect the undo manager or might trigger a call to removeAllActions. It's an extremely hard to reproduce case, we took weeks with a customer to track it down to exactly this trivial case.

NSUndoManager could add an additional check for the groupingCount before trying to close a group after invoking the undo handler to fix this.

Steps to Reproduce:
Run test case, observe exception.

Expected Results:
No exception. NSUndoManager should be robust enough to deal with the call order we throw at it.

Actual Results:
NSUndoManager’s redo logic gets confused and subsequently throws.

Version:
12.1

Notes:
We currently work around it with a custom NSUndoManager subclass that includes additional checks in endUndoGrouping, however this seems suboptimal.
