## Summary:

Xcode 9 has been awesome. The new source editor is so great and everything is much snappier and faster. Thanks for all the new things! There is one easily reproducible freeze though:

When currently having a placeholder in your code in the source code editor (the ones that show up for the parameter if you autocomplete a method name), and then right click on the class name > refactor > rename, Xcode freezes.

## Steps to Reproduce:

- Inside a class, add a method with a parameter through autocompletion
- Don’t fill out the parameters but leave the placeholders untouched
- Right click the class name
- refactor > rename

## Expected Results:

The new awesome refactoring UI opens.

## Actual Results:

Xcode freezes.

## Version:

9b4

## Notes:

In the attached zip is a sample project and a screencast showing the issue.