# Summary:
When Xcode encounters a recursive path like `$(SRCROOT)/some_dir/**` in `HEADER_SEARCH_PATHS` or `USER_HEADER_SEARCH_PATHS`, the recursion is translated into relative paths — as can be verified by looking at the actual compiler invocations:

Assuming `HEADER_SEARCH_PATHS = "$(SRCROOT)/some_dir"/** $(inherited)` and `some_dir` containing the subdirectories `foo`, `bar`, and `baz`, the list of include directives for any compiler invocation would contain `-Isome_dir -Isome_dir/bar -Isome_dir/baz -Isome_dir/foo` engulfed by any other includes.

This would not be a problem, if Xcode 10’s autocompletion code wouldn’t assert that include paths be absolute. But since it does, typing `#include <` or `#import <`, and invoking auto-completion to help you type the correct file path crashes Xcode in any source file that belongs to any target with such a search path.

Interestingly, `#include "` and `#import "` seem to be more resilient: here, auto completion does not seem to consider the search paths at all.

# Steps to Reproduce:
1. Open the attached sample project
2. in `RecursiveInclusion.m`, add an `#import <` or `#include <` directive and invoke auto-completion to fill in the file name.

# Expected Results:
Auto completion suggests the filename `really.h` as well as the directories `foo`, `bar`, and `baz`.

# Actual Results:
Xcode crashes with

```
ASSERTION FAILURE in /Library/Caches/com.apple.xbs/Sources/DVTFrameworks/DVTFrameworks-14317.13.3/DVTFoundation/FilePaths/DVTFilePath.m:908
Details:  Path must be absolute but is not: some_dir
Object:   <DVTFilePath>
Method:   +filePathForPathString:
```

# Version/Build:
10.0 (14320.12.2)

# Configuration:
n/a
