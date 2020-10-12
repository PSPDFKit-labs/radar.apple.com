# FB8795412: Catalyst: Selecting documents in the Open Recent menu results in no action

Selecting documents in the Open Recent menu, available for document-based Catalyst apps since macOS Big Sur, results in no action. It’s missing the document icons as well.

STEPS TO REPRODUCE

Open the attached Demo project or:

1. Create a new iOS document-based project and check the Mac checkbox.
2. Add “Read/Write” entitlement for “User-Selected Files” sandbox capability.
3. Set the supported document UTI to “public.plain-text” so that the app can open TXT files.

Then, with either the the attached project or the new project:

4. Choose “My Mac (Mac Catalyst)” destination and run the app.
5. Create an empty TXT document on Desktop and open it in the app.
6. Close the document, go to File → Open Recent, and select it from the list.

EXPECTED BEHAVIOR

The recent document is opened.

ACTUAL BEHAVIOR

Nothing happens. Also, the menu item of the document is missing the icon.

VERSION

Xcode 12.2 Beta 2 (12B5025f)
macOS 11.0 Beta 9 (20A5384c)
MacBook Pro (15-inch, 2018)

DETAILS

I discovered that attempting to open a recent document actually fails silently with the following error:

Error Domain=NSCocoaErrorDomain Code=260 "The file “PSPDFKit 10 QuickStart Guide.pdf” couldn’t be opened because there is no such file." UserInfo={NSURL=file:///Users/Adrian/Documents/PSPDFKit%2010%20QuickStart%20Guide.pdf/}

The error isn’t logged or displayed to the user. I discovered it by putting a breakpoint for the following symbol and printing $arg3:

__52-[UINSRecentItemsMenuController _openRecentItemURL:]_block_invoke

Asking NSFileManager if the file exists at the URL included in the error’s user info dictionary results in a YES:

(BOOL)[[NSFileManager defaultManager] fileExistsAtPath:[(NSURL *)[[$arg3 userInfo] objectForKey:@"NSURL"] path]]
