## Xcode block autocomplete is broken when blocks are annotated with nullability

http://openradar.appspot.com/

Summary:

The code editor autocompletion feature in Xcode 6.3 incorrectly auto-completes method parameter blocks that have been annotated for nullability (say defined inside a NS_ASSUME_NONNULL_BEGIN / NS_ASSUME_NONNULL_END block). For the autocompleted blocks, method parameters are missing and extra nullability specifiers (e.g.,  __nonnull) are added. 

Steps to Reproduce:

Open the provided example project in Xcode 6.3.1. Follow the instructions in the comment of -[AppDelegate application:didFinishLaunchingWithOptions:]. 

Expected Results:

The code completion for the example should be like this: [self myBlockMethod:^id (NSObject *object) {}];

Actual Results:

The code completion ends up looking like this: [self myBlockMethod:^id  __nonnull(NSObject * __nonnull) {}];
