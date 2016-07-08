Summary:
Using AirPlay to mirror an iPad’s screen on a TV creates a UIScreen instance with a resolution of 1280x720 even though the Apple TV is connected to a fullHD TV, the Apple TV is a 4th gen device and the iPad is an iPad Pro 12.9”. There should really be enough power to drive that.

Steps to Reproduce:
0. Open the sample app
1. Build and run on an iPad
2. Once the app runs, connect to an Apple TV 4th gen with mirroring enabled
3. Look at the UIScreen that is advertised to the app.

Expected Results:
When connected to a fullHD display, the UIScreen should be of size 1920x1080@1x

Actual Results:
The UIScreen is of size 1280x720@1x even though a fullHD display is connected to the Apple TV

Regression:


Notes:

