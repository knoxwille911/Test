//
//  WTBanner.h
//  WorkTest
//
//  Created by Dmtech on 29.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kWPBannerHeight;

@interface WTBanner : UIView

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UILabel *textLabel;

-(void)setupView;

@end
