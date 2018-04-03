//
//  WTView.h
//  WorkTest
//
//  Created by Dmtech on 03.04.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTViewModel;

@interface WTView : UIView

-(instancetype)initWithFrame:(CGRect)frame viewModel:(WTViewModel *)viewModel;

@property(nonatomic, retain) UITextField *urlTextField;
@property(nonatomic, retain) UITextField *filterTextField;
@property(nonatomic, retain) UITextView *resultTextView;
@property(nonatomic, retain) UIButton *startButton;
@property(nonatomic, retain) UIImageView *backgroundImageView;

@end
