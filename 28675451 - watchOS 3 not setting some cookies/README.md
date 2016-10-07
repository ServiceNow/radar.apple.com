# watchOS 3 ignores some cookies when using NSURLSession.

[rdar://28675451](rdar://28675451)

### Description
watchOS 3 does not set some cookies when using `NSURLSession`'s `sharedSession` or a custom `NSURLSession` with a default configuration. 

This issue is specific to watchOS 3 and is not a problem on iOS or watchOS 2.

### Steps to Reproduce
- Run the sample project on watchOS 3.
- Use the buttons in the app to reproduce the issue and watch the console for cookie logs.
- Run the sample project on iOS to see that all of the cookies are set correctly.

### Expected Results
I would expect watchOS 3 to set all of the cookies provided in the response to `NSHTTPCookieStorage`'s `sharedHTTPCookieStorage`.

### Actual Results
Some cookies are not set in `NSHTTPCookieStorage`'s `sharedHTTPCookieStorage`. 1 of 3 cookies are set for the apple.com test. 0 of the 3 cookies are set for the service-now.com test. 

### Additional Notes
I was able to reproduce this issue with several different hosts/cookies. I've only observed a maximum of 1 cookie being set in the response on watchOS 3. watchOS 3 appears to also completely ignore cookies that don't provide an explicit domain. This behavior is inconsistent with iOS and watchOS 2.

My current workaround is to provide a custom cookie storage class that forwards all public methods to `NSHTTPCookieStorage`'s `sharedHTTPCookieStorage`.

### Version
watchOS 3, Xcode 8.0 (8A218a)
