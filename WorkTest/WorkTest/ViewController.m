//
//  ViewController.m
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "ViewController.h"
#import "WTViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"GO" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0].active = YES;
    [button addTarget:self action:@selector(showTestController) forControlEvents:UIControlEventTouchUpInside];
}


-(void)showTestController {
    WTViewController *vc = [WTViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}
@end
