### Title
The WKWebView file upload flow is incorrectly dismissing the UIDocumentMenuViewController and its  presentingViewController.

### Description
When a view controller with a WKWebView view is presented from another view controller and we try to upload a file with an html form, we get prompted with UIDocumentMenuViewController's options. After selecting any of the options, the WKWebView view controller is being dismissed and a UIImagePickerViewController is never presented.
This is because the WKWebView view controller receives two "dismissViewController:animated:"" calls instead of just one which causes our WKWebView to be incorrectly dismissed.

### Steps to Reproduce
1. Create custom view controller with WKWebView view instance.
2. Create simple HTML file with input form of type "file" that accepts images and display it from WKWebView.
3. Present this custom view controller from the parent view controller.
4. Select "Choose File" button. You will see UIDocumentMenuViewController with options to choose.
5. Choose "Photo Library" to upload the image.
6. ViewController is being dismissed and UIImagePickerController is never presented

### Expected Results
UIImagePickerController should be presented

### Actual Results
My ViewController that contains WKWebView is being dismissed

Configuration:
iPhone 6s Plus 64GB

Version & Build:
iOS 10.1

### Additional Notes
I have noticed that WKFileUploadPanel controller sends dismiss message from within the completion block of [UIDocumentMenuViewController dismissViewControllerAnimated:completion:] method.
