//
//  ViewController+Banners.h
//  WorkTest
//
//  Created by Dmtech on 29.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTBlueBanner.h"
#import "ViewController.h"

@interface ViewController (Banners)

-(void)showLoadingBanner;
-(void)hideLoadingBanner;
-(void)showErrorBanner;
-(void)hideErrorBanner;

@end