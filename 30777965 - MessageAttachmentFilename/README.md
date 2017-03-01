# Attachments can't be renamed in Messages extension

Area:
Messages Framework

Summary:
This is a duplicate of rdar://28278392

Files shared using MSConversation's insertAttachment(_:withAlternateFilename:completionHandler:) doesn't honor the file name of the attachment nor the passed in alternateFilename.

Steps to Reproduce:
1) Run attached sample project 
2) Tap `Insert Attachment` in Messages extension
3) See that the attached file has a random generated filename (like `ms-jzerXK.pdf`)

Expected Results:
Attachment has specified alternate filename (or file name if no alternate filename was specified)

Actual Results:
Attachment has random generated filename (like `ms-jzerXK.pdf`)

Version:
iOS 10.2.1 & iOS 10.3 beta 4 [14E5260b]

Notes:
Please find the sample project attached.
The only button `Insert Attachment` inserts the file `Document.pdf` using insertAttachment(_:withAlternateFilename:completionHandler:) with an alternateFilename set to `AlternateDocument.pdf`.

The attached file gets a name like `ms-jzerXK.pdf`.

Configuration:
iPhone 7 Plus, iPad mini 2, iOS Simulator

Attachments:
'MessageAttachmentFilename.zip' and 'Screen Shot 2017-03-01 at 08.58.56.png' were successfully uploaded.
