## Summary:
Setting up subviews of a UITableViewCell’s contentView with constraints to the cell’s layoutMarginsGuide produces unexpected results. The layout constraints fail to specify a height.

It is desirable to use the cell’s margins, not the contentView’s margins in order to match the appearance of UITableViewCell’s built-in layout of its built-in subviews (e.g. textLabel).

The difference between these margins is that the top and bottom margins on the cell increase as the system content size category increases, while the contentView’s margins remain constant. Using the contentView margins results in content looking cramped at large text sizes.

## Steps to Reproduce:
1. Set up a UITableViewCell with custom subviews and layout.
2. Specify layout constraints to specify a height for self-sizing cells that keeps the content within the cells’s layoutMarginsGuide.

You can see this in action in the attached sample project. It sets up a table view that alternates between a cell with standard layout and a custom cell. The interesting code is in CustomCell.m

## Expected Results:
The custom cells should look identical to the standard cells.

## Actual Results:
The custom cells do no use multiple lines of text and all use a standard fixed height, so text gets truncated or even disappears entirely at large content size categories. From the debugger, the constrains added involving the cell’s layoutMarginsGuide don’t seem to exist at all when the cell appears.

This message is logged in the console:

```
[Warning] Warning once only: Detected a case where constraints ambiguously suggest a height of zero for a tableview cell's content view. We're considering the collapse unintentional and using standard height instead.
```

Additionally at very large accessibility content size categories, this is logged in the console:

```
[LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want. 
	Try this: 
		(1) look at each constraint and try to figure out which you don't expect; 
		(2) find the code that added the unwanted constraint or constraints and fix it. 
(
    "<NSLayoutConstraint:0x6000024d2ad0 UILabel:0x7fc6ffd19f20'twelve million three hund...'.top == UILayoutGuide:0x600003ebaa00'UIViewLayoutMarginsGuide'.top   (active)>",
    "<NSLayoutConstraint:0x6000024d3a70 UILayoutGuide:0x600003ebaa00'UIViewLayoutMarginsGuide'.bottom == UILabel:0x7fc6ffd19f20'twelve million three hund...'.bottom   (active)>",
    "<NSLayoutConstraint:0x6000024d2710 'UIView-bottomMargin-guide-constraint' V:[UILayoutGuide:0x600003ebaa00'UIViewLayoutMarginsGuide']-(32)-|   (active, names: '|':CustomCell:0x7fc701046600'custom' )>",
    "<NSLayoutConstraint:0x6000024c8780 'UIView-Encapsulated-Layout-Height' CustomCell:0x7fc701046600'custom'.height == 44   (active)>",
    "<NSLayoutConstraint:0x6000024d2530 'UIView-topMargin-guide-constraint' V:|-(32)-[UILayoutGuide:0x600003ebaa00'UIViewLayoutMarginsGuide']   (active, names: '|':CustomCell:0x7fc701046600'custom' )>"
)
```

It appears UITableView forces the cell to layout with a height of 44, but the margins alone are already 32 + 32 which is greater than 44.

## Version:
12.0 dev beta 5

## Notes:
This is not a new problem. It happens on iOS 11 too.

This problem can be worked around by sizing the cell using sizeThatFits and layoutSubviews instead of constraints. You can see this in action by changing this line in CustomCell.m

```
#define USE_CONSTRAINTS 1
```

to

```
#define USE_CONSTRAINTS 0
```

When doing this, there are no warnings in the console and the custom cells perfectly mimic the built-in cells.

An alternative for implementations already using constraints is to accept sub-optimal margins that don’t match the built-in cell layout, by using the contentView layout margins instead. You can see this by changing

```
let container = self.layoutMarginsGuide;
```

to

```
let container = self.contentView.layoutMarginsGuide;
```

Note that the vertical margins on the custom cell then differ from the standard cells.