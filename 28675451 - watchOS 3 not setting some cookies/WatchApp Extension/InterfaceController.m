//
//  InterfaceController.m
//  WatchApp Extension
//
//  Created by Will Lisac on 10/6/16.
//  Copyright © 2016 Lisac. All rights reserved.
//

#import "InterfaceController.h"
#import "CookieMonster.h"

@implementation InterfaceController

- (IBAction)demoIssueUsingApple {
    [[CookieMonster sharedMonster] demoCookieIssueWithAppleWebsite];
}

- (IBAction)demoIssueUsingServiceNow {
    [[CookieMonster sharedMonster] demoCookieIssueWithServiceNow];
}

- (IBAction)demoWorkaroundUsingApple {
    [[CookieMonster sharedMonster] demoCookieWorkaroundWithAppleWebsite];
}

- (IBAction)demoWorkaroundUsingServiceNow {
    [[CookieMonster sharedMonster] demoCookieWorkaroundWithServiceNow];
}

@end
