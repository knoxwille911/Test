//
//  WTLoadingBanner.m
//  WorkTest
//
//  Created by Dmtech on 29.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTLoadingBanner.h"

@implementation WTLoadingBanner

-(void)setupView {
    [super setupView];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:indicator];
    [indicator.centerYAnchor constraintEqualToAnchor:self.centerYAnchor constant:0.f].active = YES;
    [indicator.trailingAnchor constraintEqualToAnchor:self.textLabel.leadingAnchor constant:-15.f].active = YES;
    [indicator startAnimating];
}

@end
