# UIDocumentInteractionController presentOptionsMenuFromRect: results in minute-long log statement "Unknown activity items supplied:"

http://openradar.appspot.com/18568591

Summary:
Using these three lines of code (example attached as well)

```
    NSURL *fileURL = [[[NSBundle mainBundle] bundleURL] URLByAppendingPathComponent:@"12985EN.pdf"];
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    [self.documentInteractionController presentOptionsMenuFromRect:CGRectZero inView:self.view animated:animated];
```

Results in a UIDocumentInteractionController being presented, but also a crazy long log statement:

2014-10-07 14:07:27.366 PSPDFCatalog[2013:1291717] Unknown activity items supplied: (
        {
        "com.adobe.pdf" = <25504446 2d312e35 0d25e2e3 cfd30d0a 31313120 30206f62 6a0d3c3c 2f452037 32303939 302f4820 5b203134 32382032 3634205d 2f4c2034 34353338 35322f4c 696e6561 72697a65 6420312f 4e20342f 4f203131 342f5420 34343533 3130393e 3e0d656e 646f626a 0d202020 20202020 20202020 20202020 20202020 20202020 20200d0d 31393520 30206f62 6a0d3c3c 2f456e63 72797074 20313133 20302052 2f46696c 74657220 2f466c61 74654465 636f6465 2f494420 5b28525c 3337325c 3232347c 76685c33 37375c33 36305c33 33375c33 33325c30 31365c33 33335c30 32375c33 3131335c 33343229 2028525c 3337325c 3232347c 76685c33 37375c33 36305c33 33375c33 33325c30 31365c33 33335c30 32375c33 3131335c 33343229 5d2f496e 64657820 5b313131 2038355d 2f496e66 6f203130 39203020 522f4c65 6e677468 20323333 2f507265 76203434 35333131 302f526f 6f742031 31322030 20522f53 697a6520 3139362f 54797065 202f5852 65662f57 205b3120 3320315d 3e3e0d73 74726561 6d0a789c 1dd0b932 43711c47 f1df3fb9 d9ae2c37 895d9085 10124be8 a8a4a1e2 05c89b28 0ca3d09a 3193d151 283c4246 9126c56d 34293c40 0aad82d1 f91ecda7 3cc57166 81398b36 85f720e2 8f22f929 fc27911e 894c5f64 7b227729 8273913f 1285065c 88e2a968 df88c392 e87c8be3 1771d235 e7bdaa92 b84a99f3 07676278 2bc203f1 fe2c3ede c43814bf a145ccee fe711081 28781083 38242009 29f06102 d290812c e420803c 14a00893 3005d330 03b33007 f3b00025 58842558 863254a0 0a355881 55a8c31a ac430336 60139ad0 822dd886 1dd88536 ecc1beb3 d8bdb9ce d78f26da b5fd016a f73de50a 656e6473 74726561 6d0d656e 646f626a 0d737461 72747872 65660d20 300d2525 454f460d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d0d0d0d 0d (.........)



This is a regression from iOS 7. Only happens when we use presentOptionsMenuFromRect:, not with presentOpenInMenuFromRect:

Steps to Reproduce:
Open Example.
Run on iPad iOS 8.
Watch console.

Expected Results:
No large logs or Unknown activity items supplied message.

Actual Results:
Logs like crazy.

Version:
iOS 8

Notes:


Configuration:
Resizable iPad
