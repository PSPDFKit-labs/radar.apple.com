UIDocumentBrowserViewController does not work in the iPhone Simulator
Originator:	steipete	
Number:	rdar://36129851	Date Originated:	19-Dec-2017 02:31 PM
Status:	Open	Resolved:	
Product:	iOS + SDK	Product Version:	11.2
Classification:	Serious Bug	Reproducible:	Always
 
Summary:
Using UIDocumentBrowserViewController does not work in the iPhone Simulator. It shows content, however doesn’t load PDF thumbnails (this seems to work for regular images). Tapping files does not lead to any action as the sent documentURLs property is empty. We are unable to test and debug our app in the Simulator.

Steps to Reproduce:
I used the default Xcode template to test the document browser, see https://developer.apple.com/documentation/uikit/view_controllers/adding_a_document_browser_to_your_app/setting_up_a_document_browser_app. See also attached sample (it is exactly the sample app)

Expected Results:
Tapping a file should pass this:

func documentBrowser(_ controller: UIDocumentBrowserViewController, didPickDocumentURLs documentURLs: [URL]) {
        guard let sourceURL = documentURLs.first else { return } 

However documentURLs is empty on the Simulator, so nothing happens.

Actual Results:
documentURLs should be populated. This works as expected on an actual device but is empty on the Simulator.

Version:
11.2

Notes:
I was not signed into iCloud, so I selected the location to sign in, which caused the app to crash, a subsequent start came back with no locations listed.

I looked to find the crash report, however there is none. I listed simulator: xcrun simctl list | egrep '(Booted)' and looked into the empty CrashReporter/DiagnosticLogs folder

After manually logging into iCloud and rebooting the Simulator, I was able to access iCloud files. (There is no iCloud loading indicator, you just stare at an empty folder until it slowly fetches files)