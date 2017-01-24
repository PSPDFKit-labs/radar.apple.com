## Safaridriver appends private use unicode to text inputs

Summary:
The WebDriver spec defines a list of keyboard actions that are transmitted using private use unicode characters [1].

When now an `\uE007` is sent to to a text input, the Javascript's event `.keyCode` will be 13 which is the key code for the enter key. However, the input field will also have the private use unicode character in it, which should not be the case.

I've added a simple HTML page that attaches an event listener to an input field and alert() when the value contains the private use unicode character on a `keydown`. If you have to tool `jq`[2] installed to parse JSON, you can use the supplied shell script to automate the reproduction steps.

[1] https://www.w3.org/TR/webdriver/#keyboard-actions
[2] https://stedolan.github.io/jq/

Steps to Reproduce:
1. Start a simple HTTP server within the supplied archive. (e.g. python -m SimpleHTTPServer 8000)
2. Start safaridriver
3. Create a session like this: curl -s -d '{"desiredCapabilities":{}}' http://localhost:8910/session
4. Navigate to the test HTML file like this: curl -s -d '{"url":"http://localhost:8000/test.html"}' http://localhost:8910/session/$SESSION/url
5. Find the element like this: curl -s -d '{"using":"id", "value": "input"}' http://localhost:8910/session/$SESSION/element
6. Send the private use unicode that should be interpreted as enter like this: curl -s -d '{"value":["\uE007"]}' http://localhost:8910/session/$SESSION/element/$ELEMENT/value

Expected Results:
Nothing. The test will alert() when the text field contains the `\uE007` character which should not happen.

Actual Results:
The test will alert() because the text field contains the `\uE007` character.

Version:
macOS 10.12.2 (16C67)
Safari Version 10.0.2 (12602.3.12.0.1)

Notes:


Configuration:
This occurs on my MacBook Pro (15-inch, Late 2016)

Attachments:
'safaridriver-private-use-unicode.zip' was successfully uploaded.
