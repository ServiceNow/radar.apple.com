//
//  ViewController.m
//  WebViewFileUpload
//
//  Created by Michael Borowiec on 10/21/16.
//  Copyright © 2016 Michael Borowiec. All rights reserved.
//

#import "ViewController.h"
#import "SampleWebViewController.h"


#pragma mark -

@implementation ViewController


- (IBAction)showWebview:(id)sender
{
    SampleWebViewController *webVC = [[SampleWebViewController alloc] init];    
    [self presentViewController:webVC animated:YES completion:nil];
}

@end
