## Summary:

When creating a monochrome bitmap context with `kCGImageAlphaPremultipliedLast`, generating a UIImage out of that and then encoding and decoding that image with `NSKeyedArchiver` and `NSKeyedUnarchiver`, the resulting image (or rather its backing CGImage) has an alpha info of `kCGImageAlphaLast`.

The problem here is that this is not supported by CoreGraphics when using a monochrome color space. Therefore when trying to create a core graphics context, it will log an error message complaining about this when doing so and no image context will be created.

## Steps to Reproduce:

0. Open the attached sample
1. Run the sample
2. Notice both images are drawn on screen without any issue
3. Check the console logs

## Expected Results:

The console should state that the original image and the redrawn image both should have an alpha info of 1 before and after archiving & unarchiving.

## Actual Results:

The original image has an alpha info of 1 before and after the archiving-unarchiving roundtrip. However the image that has been redrawn before has an alpha info of 1 before archiving and an alpha info of 3 after redrawing.

Furthermore core graphics logs a detailed error about the parameter combination being unsupported. (I added the environment variable for that).

## Version:

10.3 + 11b3

## Notes:

I also added a shared breakpoint for the cg error log for your convenience which currently is disabled.

I am not really sure if this is a bug or an enhancement request, as I guess technically there is nothing saying that you should only ever get `CGImage`s with parameters that are supported by bitmap contexts, however it at least seems like a bug to me that `UIImage`s are altered when being archived / unarchived.