//
//  ViewController.m
//  CookieMonster
//
//  Created by Will Lisac on 10/6/16.
//  Copyright © 2016 Lisac. All rights reserved.
//

#import "ViewController.h"
#import "CookieMonster.h"

@implementation ViewController

- (IBAction)demoIssueUsingApple:(id)sender {
    [[CookieMonster sharedMonster] demoCookieIssueWithAppleWebsite];
}

- (IBAction)demoIssueUsingServiceNow:(id)sender {
    [[CookieMonster sharedMonster] demoCookieIssueWithServiceNow];
}

- (IBAction)demoWorkaroundUsingApple:(id)sender {
    [[CookieMonster sharedMonster] demoCookieWorkaroundWithAppleWebsite];
}

- (IBAction)demoWorkaroundUsingServiceNow:(id)sender {
    [[CookieMonster sharedMonster] demoCookieWorkaroundWithServiceNow];
}

@end
