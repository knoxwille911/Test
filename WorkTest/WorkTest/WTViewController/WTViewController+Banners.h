//
//  ViewController+Banners.h
//  WorkTest
//
//  Created by Dmtech on 29.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTBlueBanner.h"
#import "WTViewController.h"

@interface WTViewController (Banners)

-(void)showLoading;
-(void)hideLoading;
-(void)showError;
-(void)hideError;

@end
