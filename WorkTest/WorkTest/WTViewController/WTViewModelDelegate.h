//
//  WTViewModelDelegate.h
//  WorkTest
//
//  Created by Dmtech on 03.04.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTViewModelDelegate<NSObject>

@required

-(void)showLoadingBanner;
-(void)hideLoadingBanner;
-(void)showErrorBanner;
-(void)hideErrorBanner;

@end
