//
//  ViewController+Banners.m
//  WorkTest
//
//  Created by Dmtech on 29.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTViewController+Banners.h"
#import "WTRedBanner.h"
#import "WTLoadingBanner.h"
#import "UIViewController+Banners.h"

@implementation WTViewController (Banners)

-(void)showLoading {
    if ([self.banner isKindOfClass:[WTLoadingBanner class]]) {
        return;
    }
    WTLoadingBanner *loadingBanner = [[[WTLoadingBanner alloc] initWithFrame:CGRectZero text:NSLocalizedString(@"Parsing in progress", @"Parsing in progress")] autorelease];
    [self showBanner:loadingBanner autoHiding:NO];
}


-(void)hideLoading {
    [self hideBanner];
}


-(void)showError {
    WTRedBanner *errorBanner = [[[WTRedBanner alloc] initWithFrame:CGRectZero text:NSLocalizedString(@"Somethink went wrong", @"Somethink went wrong")] autorelease];
    [self showBanner:errorBanner autoHiding:YES];
}


-(void)hideError {
    if (![self.banner isKindOfClass:[WTRedBanner class]]) {
        return;
    }
    [self hideBanner];
}

@end
