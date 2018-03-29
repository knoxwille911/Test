//
//  UIViewController+Banners.h
//  WorkTest
//
//  Created by Dmtech on 29.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTBanner;

@interface UIViewController (Banners)

@property (nonatomic, strong) WTBanner *banner;
@property (nonatomic, strong) NSLayoutConstraint *topBannerConstraint;

-(void)showBanner:(WTBanner *)banner autoHiding:(BOOL)autoHiding;
-(void)hideBanner;

@end
