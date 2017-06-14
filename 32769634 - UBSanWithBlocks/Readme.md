32769634

Created on June 14 2017, 7:30 PM for Developer Tools
Close Bug
Hide Description
Summary:
Not every undefined behavior is bad or really undefined, sometimes __attribute__((no_sanitize("integer"))) is required. This works great for C functions and ObjC methods, but we get in trouble when methods use blocks to calculate data, as the attribute doesn’t apply there and there’s also no way to add such attribute to a block.	

Steps to Reproduce:
Run sample, see UBSan assertion.

Expected Results:
Some way to prevent that UBSan assertion	

Actual Results:
I can’t find any way. Not even with manual exclusion lists

Version:
Xcode 9b1

Notes:
I suggest that inline blocks automatically get this attribute OR that at least there’s a way to apply the attribute to them - includig blocks created for method calls like in the sample.

Configuration:
Xcode 9b1