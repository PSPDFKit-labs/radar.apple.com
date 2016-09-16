#import "DRSViewController.h"

@implementation DRSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *originalPath = [[NSBundle mainBundle] pathForResource:@"prince7" ofType:@"pdf"];
    NSString *outputPath = [[originalPath stringByDeletingLastPathComponent] stringByAppendingString:@"/prince7-output.pdf"];
    NSLog(@"Inout: %@", originalPath);
    NSLog(@"Output: %@", outputPath);
    
    NSURL *URL = [NSURL fileURLWithPath:originalPath];
    CGPDFDocumentRef document = CGPDFDocumentCreateWithURL ((__bridge CFURLRef)URL);
    
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(document, 1);
    CGRect paperSize = CGPDFPageGetBoxRect(pageRef, kCGPDFCropBox);
    
    UIGraphicsBeginPDFContextToFile(outputPath, paperSize, nil);
    UIGraphicsBeginPDFPageWithInfo(paperSize, nil);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, paperSize.size.height));
    CGContextDrawPDFPage(context, pageRef); // draw page 1 into graphics context
    UIGraphicsEndPDFContext();
    CGPDFDocumentRelease(document);
}

@end
