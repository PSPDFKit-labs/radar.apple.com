#  UIKit shims yield warnings when compiling Swift code

When compiling Swift code in Xcode 11 beta 1, 2, or 3, the UIKit shims will yield warnings like the following:

```
<unknown>:0: warning: imported declaration 'UITableViewDiffableDataSourceCellProvider' could not be mapped to 'UITableViewDiffableDataSourceReference.CellProvider'
```

In a CI environment that treats warnings as errors, this will cause builds to fail for no wrongdoing of the developer at all.
This reduced sample project exposes the described behavior on every entirely clean build — that is, after nuking the derived data directory for the project.

## Steps to Reproduce

1. Open the sample project in Xcode 11
2. In the `File > Project Settings...` dialog, ensure that the `Per-User Project Settings` have `Derived Data` set to `Project-relative Location` with `DerivedData`  as the name
3. Build and run the `Shim Shady` scheme — **Note:** this scheme has a Pre-action for the “Build” action, that deletes the derived data directory

## Expected Behavior

The project builds without issues and the app is started on the selected iOS Simulator displaying the text “Nothing to see here…” centered on the screen.

## Actual Behavior

The project never builds because it treats Swift warnings as errors, and performs an actual clean build every time. The build command for `SomeSwiftCode.swift` yields:

```
CompileSwift normal x86_64 "${PROJECT_DIR}/Shim Shady/SomeSwiftCode.swift" (in target: Shim Shady)
cd "${PROJECT_DIR}"
"${DEVELOPER_DIR}/Toolchains/XcodeDefault.xctoolchain/usr/bin/swift" -frontend -c -primary-file "${PROJECT_DIR}/Shim Shady/SomeSwiftCode.swift" … tons of other parameters

<unknown>:0: error: imported declaration 'UITableViewDiffableDataSourceCellProvider' could not be mapped to 'UITableViewDiffableDataSourceReference.CellProvider'
<unknown>:0: error: imported declaration 'UICollectionViewDiffableDataSourceCellProvider' could not be mapped to 'UICollectionViewDiffableDataSourceReference.CellProvider'
```
