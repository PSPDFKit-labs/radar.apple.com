The default UITabBar of UIDocumentBrowserViewController can't be disabled
Originator:	steipete	
Number:	rdar://33003809	Date Originated:	27-Jun-2017 03:43 PM
Status:	Open	Resolved:	
Product:	iOS + SDK	Product Version:	iOS 11b2
Classification:	UI/Usability	Reproducible:	Always
 
Summary:
By default, UIDocumentBrowserViewController shows a UITabBar at the bottom with 2 options: "Recents" and "Browse". There is no option to disable the "Recents" Tab, which has several drawbacks:
 1. The TabBar takes up a lot of space
 2. Since there's a TabBar, there's no way to show a UIToolbar at the bottom
 3. Since there is no Toolbar at the bottom, the NavigationBar at the top gets very crowded quickly (on iPhone), as this is the only place where we can add additional global actions
 
 It would be very easy to integrate the "Recents" into the "Browse" Tab, leaving space for a UIToolbar at the bottom. UIDocumentBrowserViewController is the only sane option for document-based apps going forward, so it's very important that it can be better customized to the different Apps' needs.

Steps to Reproduce:
1. Open the attached DocumentBrowser-based app on iPhone
2. Observe the TabBar at the bottom
3. Open the Browse Tab and drill down into a folder
4. Observe the crowded NavigationBar

Expected Results:
Everything looks neat and tidy, even when custom actions and additional bar button items are configured.

Actual Results:
Since the UITabBar takes up the space at the bottom, the only way to show additional bar button items is in the NavigationBar - which gets crowded very quickly, especially on iPhone.

Version:
iOS 11b2

Notes:
 Updated samples are - as always - available at https://github.com/PSPDFKit-labs/radar.apple.com