Summary:
ARC doesn't automatically deduct strong when using  __attribute__((NSObject))

Steps to Reproduce:
Open example, see that it crashes. Changes the line:
@property (nonatomic) __attribute__((NSObject)) CGGradientRef maskGradientRef;
to
@property (nonatomic, strong) __attribute__((NSObject)) CGGradientRef maskGradientRef;

for the fix.

Also observe that strong is automatically inferred from any other object type.

Expected Results:
__attribute__((NSObject)) should imply strong ownership by default, unless set otherwise.

Actual Results:
assign is implied, thus crashing.

Notes:
We shipped crashing UI code because of this unexpected behavior.