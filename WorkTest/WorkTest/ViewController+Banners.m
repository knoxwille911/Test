//
//  ViewController+Banners.m
//  WorkTest
//
//  Created by Dmtech on 29.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "ViewController+Banners.h"
#import "WTRedBanner.h"
#import "WTLoadingBanner.h"
#import "UIViewController+Banners.h"

@implementation ViewController (Banners)

-(void)showLoadingBanner {
    if ([self.banner isKindOfClass:[WTLoadingBanner class]]) {
        return;
    }
    WTLoadingBanner *loadingBanner = [[WTLoadingBanner alloc] initWithFrame:CGRectZero text:NSLocalizedString(@"Parsing in progress", @"Parsing in progress")];
    [self showBanner:loadingBanner autoHiding:NO];
}


-(void)hideLoadingBanner {
    [self hideBanner];
}


-(void)showErrorBanner {
    WTRedBanner *errorBanner = [[WTRedBanner alloc] initWithFrame:CGRectZero text:NSLocalizedString(@"Parsing in progress", @"Parsing in progress")];
    [self showBanner:errorBanner autoHiding:YES];
}


-(void)hideErrorBanner {
    if (![self.banner isKindOfClass:[WTRedBanner class]]) {
        return;
    }
    [self hideBanner];
}

@end
