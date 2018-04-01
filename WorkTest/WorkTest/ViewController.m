//
//  ViewController.m
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "ViewController.h"
#import "UIColors+WTColors.h"
#import "WTConfiguration.h"
#import "WTInjectorContainer.h"
#import "WTTransferManager.h"
#import "WTLoadingBanner.h"
#import "WTRedBanner.h"
#import "ViewController+Banners.h"
#import "WTLoggerReader.h"

static const CGFloat kViewsLeftOffset = 15;

@interface ViewController ()<UITextFieldDelegate> {
    UITextField *_urlTextField;
    UITextField *_filterTextField;
    UITextView *_resultTextView;
    UIButton *_startButton;
    UIImageView *_backgroundImageView;
    NSTimer *_timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)startTimer {
    _timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


-(void)timerFired {
    WTLoggerReaderGetNextLineHandler handler = [^(BOOL result, NSString *line) {
        if (result && line.length) {
            _resultTextView.text = [_resultTextView.text stringByAppendingString:line];
        }
    } copy];
    
    [injectorContainer().loggerReader getNextLine:@"" lineSize:@(1000) handler:handler];
}


-(void)setupView {
    
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background-menu"]];
    _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_backgroundImageView];
    
    [self setupURLTextField];
    [self setupFilterView];
    [self setupStartButton];
    [self setupResultTextView];
}


-(void)setupURLTextField {
    UILabel *urlLabel = [[UILabel new] autorelease];
    urlLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [urlLabel setFont:[UIFont systemFontOfSize:16.f]];
    [urlLabel setText:NSLocalizedString(@"URL:", @"URL:")];
    urlLabel.textColor = UIColor.urlTextViewTextColor;
    [self.view addSubview:urlLabel];
    
    NSLayoutYAxisAnchor *topAnchor = nil;
    if (@available(iOS 11, *)) {
        topAnchor = self.view.safeAreaLayoutGuide.topAnchor;
    } else {
        topAnchor = self.topLayoutGuide.bottomAnchor;
    }
    
    [urlLabel.topAnchor constraintEqualToAnchor:topAnchor constant:25.f].active = YES;
    [urlLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kViewsLeftOffset].active = YES;

    _urlTextField = [[UITextField new] autorelease];
    UIView *indentView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 5.f, 0.f)];
    indentView.backgroundColor = UIColor.clearColor;
    _urlTextField.leftView = indentView;
    _urlTextField.delegate = self;
    _urlTextField.leftViewMode = UITextFieldViewModeAlways;
    _urlTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _urlTextField.spellCheckingType = UITextSpellCheckingTypeNo;
    _urlTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _urlTextField.backgroundColor = UIColor.urlFieldBackgroundColor;
    _urlTextField.textColor = UIColor.urlFieldTextColor;
    _urlTextField.tintColor = UIColor.urlFieldTextColor;
    _urlTextField.layer.borderWidth = 1.f;
    _urlTextField.layer.cornerRadius = 5.f;
    _urlTextField.layer.borderColor = UIColor.urlFieldBorderColor.CGColor;
    _urlTextField.text = [WTConfiguration textDownloadDefaultURL];
    _urlTextField.returnKeyType = UIReturnKeyDone;
    [_urlTextField setFont:[UIFont systemFontOfSize:16.f]];
    _urlTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_urlTextField];
    
    [_urlTextField.centerYAnchor constraintEqualToAnchor:urlLabel.centerYAnchor constant:0].active = YES;
    [_urlTextField.leadingAnchor constraintEqualToAnchor:urlLabel.trailingAnchor constant:15.f].active = YES;
    [_urlTextField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-15.f].active = YES;
    [_urlTextField.heightAnchor constraintEqualToConstant:32.f].active = YES;
}


-(void)setupFilterView {
    UILabel *label = [[UILabel new] autorelease];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label setFont:[UIFont systemFontOfSize:16.f]];
    [label setText:NSLocalizedString(@"Filter:", @"Filter:")];
    label.textColor = UIColor.filterTextViewTextColor;
    [self.view addSubview:label];
    
    [label.topAnchor constraintEqualToAnchor:_urlTextField.bottomAnchor constant:25.f].active = YES;
    [label.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kViewsLeftOffset].active = YES;
    
    _filterTextField = [[UITextField new] autorelease];
    UIView *indentView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 5.f, 0.f)];
    indentView.backgroundColor = UIColor.clearColor;
    _filterTextField.leftView = indentView;
    _filterTextField.leftViewMode = UITextFieldViewModeAlways;
    _filterTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _filterTextField.spellCheckingType = UITextSpellCheckingTypeNo;
    _filterTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _filterTextField.backgroundColor = UIColor.urlFieldBackgroundColor;
    _filterTextField.textColor = UIColor.urlFieldTextColor;
    _filterTextField.tintColor = UIColor.urlFieldTextColor;
    _filterTextField.layer.borderWidth = 1.f;
    _filterTextField.layer.cornerRadius = 5.f;
    _filterTextField.layer.borderColor = UIColor.urlFieldBorderColor.CGColor;
    _filterTextField.text = [WTConfiguration defaultFilter];
    [_filterTextField setFont:[UIFont systemFontOfSize:16.f]];
    _filterTextField.borderStyle = UITextBorderStyleNone;
    _filterTextField.returnKeyType = UIReturnKeyDone;
    _filterTextField.delegate = self;
    [self.view addSubview:_filterTextField];
    
    [_filterTextField.centerYAnchor constraintEqualToAnchor:label.centerYAnchor constant:0].active = YES;
    [_filterTextField.leadingAnchor constraintEqualToAnchor:_urlTextField.leadingAnchor constant:0.f].active = YES;
    [_filterTextField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-15.f].active = YES;
    [_filterTextField.heightAnchor constraintEqualToConstant:32.f].active = YES;
}


-(void)setupStartButton {
    _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_startButton setTitle:@"GO" forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor startButtonTextColor] forState:UIControlStateNormal];
    _startButton.translatesAutoresizingMaskIntoConstraints = NO;
    _startButton.layer.borderWidth = 1.f;
    _startButton.layer.cornerRadius = 5.f;
    _startButton.layer.borderColor = UIColor.urlFieldBorderColor.CGColor;
    [self.view addSubview:_startButton];
    
    [_startButton.topAnchor constraintEqualToAnchor:_filterTextField.bottomAnchor constant:5.f].active = YES;
    [_startButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0.f].active = YES;
    [_startButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:15.f].active = YES;
    [_startButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-15.f].active = YES;
    [_startButton addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setupResultTextView {
    _resultTextView = [[UITextView new] autorelease];
    _resultTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _resultTextView.backgroundColor = [UIColor resultTextViewBackgroundColor];
    _resultTextView.textColor = [UIColor resultTextViewTextColor];
    _resultTextView.bounces = NO;
    _resultTextView.font = [UIFont systemFontOfSize:16.0f];
    _resultTextView.alwaysBounceVertical = YES;
    _resultTextView.scrollEnabled = YES;
    _resultTextView.editable = NO;
    _resultTextView.layer.borderWidth = 1.f;
    _resultTextView.layer.cornerRadius = 5.f;
    _resultTextView.layer.borderColor = [UIColor resultTextViewBorderColor].CGColor;
    
    [self.view addSubview:_resultTextView];
    
    NSLayoutAnchor *bottomSaveAnchor;
    
    if (@available(iOS 11, *)) {
        bottomSaveAnchor = self.view.safeAreaLayoutGuide.bottomAnchor;
    } else {
        bottomSaveAnchor = self.bottomLayoutGuide.topAnchor;
    }
    
    [_resultTextView.topAnchor constraintEqualToAnchor:_startButton.bottomAnchor constant:5.f].active = YES;
    [_resultTextView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:15.f].active = YES;
    [_resultTextView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-15.f].active = YES;
    [_resultTextView.bottomAnchor constraintEqualToAnchor:bottomSaveAnchor constant:-5.f].active = YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


-(void)buttonTap {
    WTTransferManagerDownloadingHandler handler = [^(NSString *downloadedString, WTTransferManagerTaskState state, NSError *error) {
        if (downloadedString.length) {
            WTLoggerReaderAddSourceHandler handler = [^(BOOL result) {
                if (result) {
                    [self startTimer];
                }
            } copy];
            
            [injectorContainer().loggerReader addSourceBlock:downloadedString blockSize:@(downloadedString.length) handler:handler];
        }
        if (state == WTTransferManagerTaskStateRunning) {
            [self hideErrorBanner];
            [self showLoadingBanner];
        }
        if (state == WTTransferManagerTaskStateError) {
            [self hideLoadingBanner];
            [self showErrorBanner];
        }
        if (state == WTTransferManagerTaskStateComplete) {
            [self hideLoadingBanner];
            [self hideErrorBanner];
        }
    } copy];
    [injectorContainer().loggerReader setFilter:_filterTextField.text];
    [injectorContainer().transferManager addDownloadTaskWithURL:_urlTextField.text handler:handler];
}

@end
