//
//  HTTPCookieStorageShim.m
//  Cookies
//
//  Created by Will Lisac on 10/6/16.
//  Copyright © 2016 Lisac. All rights reserved.
//

#import "HTTPCookieStorageShim.h"

// This class just forwards all public methods to the sharedHTTPCookieStorage to workaround the issue.

@implementation HTTPCookieStorageShim

- (NSArray<NSHTTPCookie *> *)cookies
{
    return [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
}

- (void)deleteCookie:(NSHTTPCookie *)cookie
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
}

- (void)removeCookiesSinceDate:(NSDate *)date
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] removeCookiesSinceDate:date];
}

- (NSArray<NSHTTPCookie *> *)cookiesForURL:(NSURL *)URL
{
    return [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:URL];
}

- (void)setCookies:(NSArray<NSHTTPCookie *> *)cookies forURL:(NSURL *)URL mainDocumentURL:(NSURL *)mainDocumentURL
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookies forURL:URL mainDocumentURL:mainDocumentURL];
}

- (NSHTTPCookieAcceptPolicy)cookieAcceptPolicy
{
    return [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookieAcceptPolicy];
}

- (void)setCookieAcceptPolicy:(NSHTTPCookieAcceptPolicy)cookieAcceptPolicy
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:cookieAcceptPolicy];
}

- (NSArray<NSHTTPCookie *> *)sortedCookiesUsingDescriptors:(NSArray<NSSortDescriptor *> *)sortOrder
{
    return [[NSHTTPCookieStorage sharedHTTPCookieStorage] sortedCookiesUsingDescriptors:sortOrder];
}

- (void)storeCookies:(NSArray<NSHTTPCookie *> *)cookies forTask:(NSURLSessionTask *)task
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] storeCookies:cookies forTask:task];
}

- (void)getCookiesForTask:(NSURLSessionTask *)task completionHandler:(void (^)(NSArray<NSHTTPCookie *> * _Nullable))completionHandler
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] getCookiesForTask:task completionHandler:completionHandler];
}

@end
