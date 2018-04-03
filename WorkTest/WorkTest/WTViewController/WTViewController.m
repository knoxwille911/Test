//
//  WTViewController.m
//  WorkTest
//
//  Created by Dmtech on 02.04.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTViewController.h"
#import "WTViewModel.h"
#import "WTViewModelDelegate.h"

@interface WTViewController () {
    
    WTViewModel *_viewModel;
}

@end

@implementation WTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [[WTViewModel alloc] initWithDelegate:self];
    [_viewModel attachToViewController:self];
}


-(void)viewWillDisappear:(BOOL)animated {
    [_viewModel viewControllerWillDissapear];
    [super viewWillDisappear:animated];
}


-(void)showLoadingBanner {
    [self showLoadingBanner];
}


-(void)hideLoadingBanner {
    [self hideLoadingBanner];
}


-(void)showErrorBanner {
    [self showErrorBanner];
}


-(void)hideErrorBanner {
    [self hideErrorBanner];
}


-(void)dealloc {
    [super dealloc];
    [_viewModel release];
}

@end
