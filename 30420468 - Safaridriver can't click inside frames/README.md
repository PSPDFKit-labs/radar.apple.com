## Safaridriver can't click inside frames

Summary:
When we use the `/frame` WebDriver end point to switch to an iframe, click events will no be
triggered although the `/click` endpoint does not error.

I've added a simple HTML page that attaches an event listener to an input field and alert() when the
value contains the private use unicode character on a `keydown`. If you have to tool `jq`[1]
installed to parse JSON, you can use the supplied shell script to automate the reproduction steps.

[1] https://stedolan.github.io/jq/

Steps to Reproduce:
1. Start a simple HTTP server within the supplied archive. (e.g. python -m SimpleHTTPServer 8000)
2. Start `safaridriver -p 8910`
3. Create a session like this: `curl -d '{"desiredCapabilities":{}}' http://localhost:8910/session`
4. Navigate to the test HTML file: `curl -d '{"url":"http://localhost:8000/test.html"}' http://localhost:8910/session/$SESSION/url`
5. Switch to the `iframe`: `curl -d '{"id": 0}' http://localhost:8910/session/$SESSION/frame`
6. Find the button inside the iframe: `curl -d '{"using":"id", "value": "button"}' http://localhost:8910/session/$SESSION/element`
7. Click the button: `curl -d '{}' http://localhost:8910/session/$SESSION/element/$ELEMENT/click`
8. You should now see that the button is gone, but it is still there.

Expected Results:
The button should be gone since it's `onclick` is `this.destroy()`

Actual Results:
Nothing happens

Version:
macOS 10.12.3 (16D32)
Safari Version 10.0.3 (12602.4.8)

Notes:


Configuration:
This occurs on my MacBook Pro (15-inch, Late 2016)
