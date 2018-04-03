//
//  WTBanner.m
//  WorkTest
//
//  Created by Dmtech on 29.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTBanner.h"

CGFloat const kWPBannerHeight = 24;

@implementation WTBanner

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [self bannerColor];
        _text = text;
        [self setupView];
    }
    return self;
}


-(void)setupView {
    self.textLabel = [[UILabel new] autorelease];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.textLabel];
    
    self.textLabel.textColor = [self textColor];
    self.textLabel.font = [self textFont];
    self.textLabel.text = _text;
    [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0].active = YES;
}


-(UIColor *)bannerColor {
    return nil;
}


-(UIColor *)textColor {
    return nil;
}


-(UIFont *)textFont {
    return nil;
}

-(void)dealloc {
    [self.textLabel release];
    [super dealloc];
}

@end
