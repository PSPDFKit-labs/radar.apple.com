# FB11991537: UINavigationItem button setters not updating toolbar buttons in Catalyst apps optimized for macOS

## Which area are you seeing an issue with?

UIKit

## What type of feedback are you reporting?

Incorrect/Unexpected Behavior

## Description

Starting from Ventura (13+), macOS automatically transforms UINavigationItem buttons into NSToolbar buttons for Catalyst applications that are optimized for macOS

UINavigationItem button setters (e.g. setLeftItems/setRightItems) not updating an application's toolbar after its shown on the screen
To add or remove UINavigationItem, one require to first reset the entire buttons array and then set a new one in the next run loop. Otherwise, the old buttons will persist and the new buttons won't be visible

Instead of doing this:

        navigationItem.rightBarButtonItems = newItems

One needs to do this:

        navigationItem.rightBarButtonItems = []
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItems = newItems
        }

## Steps to reproduce

Requirements: macOS 13+

- Open the sample project
- Set the destination to Mac Catalyst
- Build & Run the project
- Clicking on the Replace Button won't do anything
- Clicking on the Hack Replace Button should change the button in the toolbar

The Replace Button invokes the following code:

    private func plainReplaceButton() {
        navigationItem.rightBarButtonItems = [makeTimestampButton()]
    }

While the Hack Replace Button applies the hack:

    private func hackReplaceButton() {
        navigationItem.rightBarButtonItems = []
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItems = [self.makeTimestampButton()]
        }
