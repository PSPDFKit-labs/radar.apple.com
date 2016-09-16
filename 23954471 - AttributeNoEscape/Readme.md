## Support __attribute__((noescape)) for blocks within Objective-C

http://openradar.appspot.com/23954471

Summary:
Attribute __attribute__((noescape)) should be supported from Objective-C. It’s useful from an API side to know if a block is retained or executed immediately, and as Swift proofs this can also enable additional compiler optimizations.

While we can add this attribute to ObjC projects, it’s not recognized, neither at compile nor analyze time. It’s still useful for things that are bridge to Swift - I assume - but it could be much more useful if properly supported.

Steps to Reproduce:
See attached sample. It should produce a compile error or at least a warning because we use dispatch_async on a block that is marked as noescape, but no such warning/error is produced.

Tested on iOS 10 GM, not fixed.
