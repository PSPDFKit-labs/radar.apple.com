## Creating a new PDF via UIGraphicsBeginPDFContextToFile and CGContextDrawPDFPage results in partial data loss

http://openradar.appspot.com/19901736

Summary:
Recreating a PDF via UIGraphicsBeginPDFContextToFile and CGContextDrawPDFPage results in a PDF where the majority of text is missing. The PDF renders correctly but re-saving it fails.

Steps to Reproduce:
See DocumentRenderSample. Run and open the output PDF (path is in the log).

Compare with original PDF. See that most content is missing

Expected Results:
File should look the same.

Actual Results:
content is missing

Version:
iOS 8.1.3

Notes:
Related to rdar://18406222 but with a different PDF.
