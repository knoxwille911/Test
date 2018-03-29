//
//  UIViewController+Banners.m
//  WorkTest
//
//  Created by Dmtech on 29.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "UIViewController+Banners.h"

#import "WTBanner.h"
#import <objc/runtime.h>

static void *WTViewControllerBannerKey = &WTViewControllerBannerKey;
static void *WTViewControllerBannerTopConstraintKey = &WTViewControllerBannerTopConstraintKey;

@implementation UIViewController (Banners)

- (WTBanner *)banner {
    return objc_getAssociatedObject(self, WTViewControllerBannerKey);
}

- (void)setBanner:(WTBanner *)banner {
    objc_setAssociatedObject(self, WTViewControllerBannerKey, banner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSLayoutConstraint *)topBannerConstraint {
    return objc_getAssociatedObject(self, WTViewControllerBannerTopConstraintKey);
}

-(void)setTopBannerConstraint:(NSLayoutConstraint *)topBannerConstraint {
    objc_setAssociatedObject(self, WTViewControllerBannerTopConstraintKey, topBannerConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(void)showBanner:(WTBanner *)banner autoHiding:(BOOL)autoHiding {
    if (self.banner) {
        return;
    }
    self.banner = banner;
    self.banner.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:banner];
    NSLayoutAnchor *topSaveAnchor;
    if (@available(iOS 11, *)) {
        topSaveAnchor = self.view.safeAreaLayoutGuide.topAnchor;
    } else {
        topSaveAnchor = self.topLayoutGuide.bottomAnchor;
    }
    self.topBannerConstraint = [self.banner.topAnchor constraintEqualToAnchor:topSaveAnchor constant:-kWPBannerHeight];
    self.topBannerConstraint.active = YES;
    [self.banner.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0.f].active = YES;
    [self.banner.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0.f].active = YES;
    [self.banner.heightAnchor constraintEqualToConstant:kWPBannerHeight].active = YES;
    
    
    [self.view layoutIfNeeded];
    
    self.topBannerConstraint.constant = 0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (autoHiding) {
            [self hideBanner];
        }
    }];
}


-(void)hideBanner {
    if (!self.banner) {
        return;
    }
    self.topBannerConstraint.constant = -kWPBannerHeight;
    [UIView animateWithDuration:0.5 delay:2.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.banner removeFromSuperview];
        self.banner = nil;
    }];
}

@end

