//
//  WTViewModel.m
//  WorkTest
//
//  Created by Dmtech on 03.04.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTViewModel.h"
#import "WTView.h"
#import "UIColors+WTColors.h"
#import "WTConfiguration.h"
#import "WTInjectorContainer.h"
#import "WTTransferManager.h"
#import "WTLoadingBanner.h"
#import "WTRedBanner.h"
#import "WTViewController+Banners.h"
#import "WTLoggerReader.h"

@interface WTViewModel() {
    NSTimer *_timer;
    WTView *_view;
}

@property (nonatomic, unsafe_unretained) id<WTViewModelDelegate> delegate;

@end


@implementation WTViewModel

-(instancetype)initWithDelegate:(id<WTViewModelDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}


-(void)attachToViewController:(UIViewController *)viewController {
    _view = [[[WTView alloc] initWithFrame:CGRectZero viewModel:self] autorelease];
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    [viewController.view addSubview:_view];
    
    NSLayoutYAxisAnchor *topAnchor = nil;
    if (@available(iOS 11, *)) {
        topAnchor = viewController.view.safeAreaLayoutGuide.topAnchor;
    } else {
        topAnchor = viewController.topLayoutGuide.bottomAnchor;
    }
    NSLayoutAnchor *bottomSaveAnchor;
    
    if (@available(iOS 11, *)) {
        bottomSaveAnchor = viewController.view.safeAreaLayoutGuide.bottomAnchor;
    } else {
        bottomSaveAnchor = viewController.bottomLayoutGuide.topAnchor;
    }
    [_view.leadingAnchor constraintEqualToAnchor:viewController.view.leadingAnchor constant:0].active = YES;
    [_view.trailingAnchor constraintEqualToAnchor:viewController.view.trailingAnchor constant:0].active = YES;
    [_view.bottomAnchor constraintEqualToAnchor:bottomSaveAnchor constant:0].active = YES;
    [_view.topAnchor constraintEqualToAnchor:topAnchor constant:0].active = YES;
    
    _view.filterTextField.delegate = self;
    _view.urlTextField.delegate = self;
    [_view.startButton addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
}


-(void)startTimer {
    //timer needs to triger asking parser for next string
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                     target:self
                                                   selector:@selector(timerFired)
                                                   userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


-(void)timerFired {
    __block WTViewModel *weakSelf = self;
    WTLoggerReaderGetNextLineHandler handler = [[^(BOOL result, NSString *line) {
        if (!result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf->_delegate hideLoadingBanner];
            });
        }
        if (result && line.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf->_view.resultTextView.text = [[weakSelf->_view.resultTextView.text stringByAppendingString:@"\n\n"] stringByAppendingString:line];
                NSRange bottom = NSMakeRange(weakSelf->_view.resultTextView.text.length - 1, 1);
                [weakSelf->_view.resultTextView scrollRangeToVisible:bottom];
            });
        }
    } copy] autorelease];
    [injectorContainer().loggerReader getNextLine:@"" lineSize:@(4096) handler:handler];
}


-(void)buttonTap {
    _view.resultTextView.text = @"";
    [injectorContainer().transferManager cancelAllTasks];
    
    __block WTViewModel *weakSelf = self;
    __block WTTransferManagerDownloadingHandler handler = [[^(NSString *downloadedString, WTTransferManagerTaskState state, NSError *error) {
        //parse file while downloading process
        if (downloadedString.length) {
            __block WTLoggerReaderAddSourceHandler handler = [[^(BOOL result) {
                if (result) {
                    
                }
            } copy] autorelease];
            [injectorContainer().loggerReader addSourceBlock:downloadedString blockSize:@(downloadedString.length) handler:handler];
        }
        //show banners if needed
        dispatch_async(dispatch_get_main_queue(), ^{
            if (state == WTTransferManagerTaskStateRunning) {
                [weakSelf->_delegate hideErrorBanner];
                [weakSelf->_delegate showLoadingBanner];
            }
            if (state == WTTransferManagerTaskStateError) {
                [weakSelf->_delegate hideLoadingBanner];
                [weakSelf->_delegate showErrorBanner];
            }
            if (state == WTTransferManagerTaskStateReady) {
                [weakSelf startTimer];
            }
        });
    } copy] autorelease];
    
    //set filter to parser
    [injectorContainer().loggerReader setFilter:_view.filterTextField.text];
    
    //start download
    [injectorContainer().transferManager addDownloadTaskWithURL:_view.urlTextField.text handler:handler];
}


-(void)viewControllerWillDissapear {
    [_timer invalidate];
    _timer = nil;
    [injectorContainer().transferManager cancelAllTasks];
}

#pragma mark text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


-(void)dealloc {
    [super dealloc];
}

@end
