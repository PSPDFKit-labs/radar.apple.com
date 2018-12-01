//
//  UndoManagerRecursiveCallTests.swift
//  UndoManagerRecursiveCallTests
//
//  Created by Peter Steinberger on 01.12.18.
//  Copyright © 2018 Peter Steinberger. All rights reserved.
//

import XCTest
@testable import UndoManagerRecursiveCall

class UndoManagerRecursiveCallTests: XCTestCase {

    let undoMan = UndoManager.init()

    func testExample() {
        registerUndoAction()
        print("canUndo: \(undoMan.canUndo) canRedo: \(undoMan.canRedo)")
        undoMan.undo()
    }

    func registerUndoAction() {
        undoMan.beginUndoGrouping()
        undoMan.registerUndo(withTarget: self, selector: #selector(undoHandler), object: "test")
        undoMan.endUndoGrouping()
    }

    @objc func undoHandler() {
        print("undo handler called")

        // This throws "NSInternalInconsistencyException", "_endUndoGroupRemovingIfEmpty:: NSUndoManager 0x600001026620 is in invalid state, endUndoGrouping called with no matching begin
        // _endUndoGroupRemovingIfEmpty checks if a group needs to be closed, but does that before invoking the undoHandler, and then not checking again.
        // This is an example where you might quickly say "API misuse". In a real-world application with 20 layers and user-facing API, it is MUCH harder to prevent calls from various model change callbacks that don't affect the undo manager or might trigger a call to removeAllActions. It's an extremely hard to reproduce case, we took weeks with a customer to track it down to exactly this trivial case.
        // NSUndoManager could add an additional check for the groupingCount before trying to close a group after invoking the undo handler to fix this.
        undoMan.removeAllActions()
    }

}
