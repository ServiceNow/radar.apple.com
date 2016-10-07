//
//  CookieMonster.h
//  Cookies
//
//  Created by Will Lisac on 10/6/16.
//  Copyright © 2016 Lisac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookieMonster : NSObject

+ (instancetype)sharedMonster;

// Demo Issue
- (void)demoCookieIssueWithAppleWebsite;
- (void)demoCookieIssueWithServiceNow;

// Demo Workaround
- (void)demoCookieWorkaroundWithAppleWebsite;
- (void)demoCookieWorkaroundWithServiceNow;

@end
