## NSCoding does not preserve the full UIIMage information for images loaded with imageNamed:

http://openradar.appspot.com/20256585

Summary:

Serializing an image using NSKeyedArchiver produces different results depending on how the image was loaded. 

- For images loaded with imageNamed: the image data is not serialized (which prohibits us from deserializing the image in full later on). 
- Images loaded with imageWithContentsOfFile: get completely preserved. 

Steps to Reproduce:

Open the attached project and run it. Follow the onscreen instructions and compare the different displayed results. 

Expected Results:

The image would be fully preserved even when loading it using imageNamed:.

Actual Results:

Images loaded with imageNamed: do not get fully serialized when using NSKeyedArchiver. 

Regression:

Occurs on iOS 8.2. Also happens on iOS 7. 

Notes:

Using imageWithContentsOfFile: works. Drawing images loaded with imageNamed: into a new bitmap context and obtaining a new image from it also works.
