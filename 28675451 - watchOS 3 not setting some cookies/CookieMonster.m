//
//  CookieMonster.m
//  Cookies
//
//  Created by Will Lisac on 10/6/16.
//  Copyright © 2016 Lisac. All rights reserved.
//

#import "CookieMonster.h"
#import "HTTPCookieStorageShim.h"

#if TARGET_OS_WATCH
#import <WatchKit/WatchKit.h>
#endif


/**
 Here are example cookies I expect from https://demonightlyistanbul.service-now.com
 
 Set-Cookie: JSESSIONID=AA35A8445B3219B08C9CE7A886B36D5F;Secure; Path=/; HttpOnly
 Set-Cookie: glide_user_route=glide.8a57b87d8ce6c627acc034036b2a81da;Secure; Expires=Wed, 25-Oct-2084 21:51:40 GMT; Path=/; HttpOnly
 Set-Cookie: BIGipServerpool_demonightlyistanbul=2357199882.52030.0000; path=/
 
 watchOS 3 ignores all cookies without the workaround. iOS and watchOS 2 always save all cookies.
  */
NSString * const ServiceNowURLString = @"https://demonightlyistanbul.service-now.com";
NSInteger const ServiceNowURLExpectedCookieCount = 3;


/**
 Here are example cookies I expect from https://www.apple.com/shop/bag
 
 Set-Cookie: as_dc=nc; version="1"; max-age=1800; expires=Fri, 07-Oct-2016 18:43:53 GMT; path=/; domain=.apple.com
 Set-Cookie: dssid2=12da0199-2f10-4cfa-b31a-b589d4f6f7f6; version="1"; max-age=315360000; expires=Mon, 05-Oct-2026 18:13:53 GMT; path=/; domain=.apple.com
 Set-Cookie: dssf=1; version="1"; max-age=315360000; expires=Mon, 05-Oct-2026 18:13:53 GMT; path=/; domain=.apple.com
 
 watchOS 3 only sets the first cookie without workaround. iOS and watchOS 2 always save all cookies.
 */
NSString * const AppleURLString = @"https://www.apple.com/shop/bag";
NSInteger const AppleURLExpectedCookieCount = 3;



@interface CookieMonster ()
@property (nonatomic, strong) NSURLSession *currentSession;
@end

@implementation CookieMonster

+ (instancetype)sharedMonster
{
    static dispatch_once_t pred;
    static CookieMonster *sharedMonster;
    
    dispatch_once(&pred, ^{
        sharedMonster = [[self alloc] init];
    });
    
    return sharedMonster;
}

#pragma mark - Issue

- (void)demoCookieIssueWithAppleWebsite
{
    [self demoCookieIssueWithURLString:AppleURLString expectedCookieCount:AppleURLExpectedCookieCount];
}

- (void)demoCookieIssueWithServiceNow
{
    [self demoCookieIssueWithURLString:ServiceNowURLString expectedCookieCount:ServiceNowURLExpectedCookieCount];
}

- (void)demoCookieIssueWithURLString:(NSString *)urlString
           expectedCookieCount:(NSInteger)expectedCookieCount
{
    // NSURLSession's sharedSession (or a custom session with a default configuration) fails on watchOS 3, but works fine on iOS and watchOS 2.
    NSURLSession *session = [NSURLSession sharedSession];
    
#if TARGET_OS_WATCH
    BOOL isWatchOS3OrLater = ([[WKInterfaceDevice currentDevice].systemVersion floatValue] >= 3.0);
    BOOL expectingFailure = isWatchOS3OrLater;
#else
    BOOL expectingFailure = NO;
#endif
    
    [self demoWithSession:session urlString:urlString expectedCookieCount:expectedCookieCount expectingFailure:expectingFailure];
}

#pragma mark - Workaround

- (void)demoCookieWorkaroundWithAppleWebsite
{
    [self demoCookieWorkaroundWithURLString:AppleURLString expectedCookieCount:AppleURLExpectedCookieCount];
}

- (void)demoCookieWorkaroundWithServiceNow
{
    [self demoCookieWorkaroundWithURLString:ServiceNowURLString expectedCookieCount:ServiceNowURLExpectedCookieCount];
}

- (void)demoCookieWorkaroundWithURLString:(NSString *)urlString
                expectedCookieCount:(NSInteger)expectedCookieCount
{
    // Custom session with default configuration and "custom" cookie storage works on iOS and watchOS.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // This "shim" is a total hack. I don't really understand why it works around the issue.
    configuration.HTTPCookieStorage = [[HTTPCookieStorageShim alloc] init];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    // This workaround appears to work on all platforms/versions (note: the issue is only present on watchOS 3 as noted above).
    BOOL expectingFailure = NO;
    
    [self demoWithSession:session urlString:urlString expectedCookieCount:expectedCookieCount expectingFailure:expectingFailure];
}

#pragma mark - Main Demo Method

- (void)demoWithSession:(NSURLSession *)session
                    urlString:(NSString *)urlString
    expectedCookieCount:(NSInteger)expectedCookieCount
       expectingFailure:(BOOL)expectingFailure
{
    // Only allow one demo at a time.
    if (self.currentSession) {
        NSLog(@"WARNING: Ignoring demo request. Must wait for current demo to finish.");
        return;
    }
    
    NSLog(@"\n\n\n\n===================================");
    
    self.currentSession = session;

    // Delete all cookies to try and get to a clean state.
    [self deleteCookies];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Ignore cache to ensure we always get a fresh result for demo.
    NSMutableURLRequest *request = [[NSURLRequest requestWithURL:url] mutableCopy];
    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    
    NSLog(@"Making request to %@", urlString);
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                if (error) {
                                                    NSLog(@"Network request failed: %@", error);
                                                    NSLog(@"Demo failed to finish. Please try again.");
                                                } else {
                                                    NSLog(@"Network request finished.");
                                                    [self logCookiesWithExpectedCookieCount:expectedCookieCount expectingFailure:expectingFailure];
                                                }
                                                
                                                // Reset session to allow another demo.
                                                self.currentSession = nil;
                                                
                                                NSLog(@"\n===================================");
                                            }];
    [task resume];
}

#pragma mark - Helpers

- (void)deleteCookies
{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [storage cookies];
    for (NSHTTPCookie *cookie in cookies) {
        [storage deleteCookie:cookie];
    }
    
    NSLog(@"Deleted all cookies: %@", storage);
}

- (void)logCookiesWithExpectedCookieCount:(NSInteger)expectedCookieCount
                         expectingFailure:(BOOL)expectingFailure
{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [storage cookies];
    
    if (expectedCookieCount == cookies.count) {
        NSLog(@"Cookie count is correct.\n%@\n%@", storage, cookies);
        if (expectingFailure) {
            NSLog(@"The demo did not work as expected. I expected the cookie count to be wrong in this demo.");
        } else {
            NSLog(@"Demo worked as expected.");
        }
    } else {
        NSLog(@"Cookie count is wrong. Expected %ld.\n%@\n%@", (long)expectedCookieCount, storage, cookies);
        if (expectingFailure) {
            NSLog(@"Demo worked as expected.");
        } else {
            NSLog(@"The demo did not work as expected. I expected the cookie count to be correct in this demo.");
        }
    }
}

@end
