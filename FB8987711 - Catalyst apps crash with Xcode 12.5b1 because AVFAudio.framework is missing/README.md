# FB8987711: Apps crash with Xcode 12.5b1 because AVFAudio.framework is missing

Catalyst and iOS apps crash with Xcode 12.5b1 because AVFAudio.framework is missing.

https://twitter.com/steipete/status/1356660520376553473?s=21

Looks like this was added in iOS 14.5 but older OSes don't know about it. I do not see a way to workaround this, this must be fixed before the GM.

We use AVAudioPlayer which has been moved to AVFAudio.framework from AVFoundation.framework.

Run example. It works on IOS 14.5. On any older OS including Big Sur 11.2, it instead fails to load with this:

dyld: Library not loaded: /System/Library/Frameworks/AVFAudio.framework/Versions/A/AVFAudio
  Referenced from: /Users/steipete/Builds/TestApp-ehhozwvcfgkjiwcgjbyvcgqpvrrr/Build/Products/Debug-maccatalyst/MagicKit.framework/Versions/A/MagicKit
  Reason: image not found
