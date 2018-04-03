//
//  WTViewModel.h
//  WorkTest
//
//  Created by Dmtech on 03.04.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTViewModelDelegate;

@interface WTViewModel : NSObject<UITextFieldDelegate>

-(instancetype)initWithDelegate:(id<WTViewModelDelegate>)delegate;

-(void)attachToViewController:(UIViewController *)viewController;
-(void)viewControllerWillDissapear;

-(void)buttonTap;

@end
