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

@interface ViewController ()<UITextFieldDelegate> {
    UITextField *_urlTextField;
    UITextView *_resultTextView;
    UIButton *_startButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)setupView {
    [self setupURLTextField];
    [self setupResultTextView];
    [self setupStartButton];
}


-(void)setupURLTextField {
    _urlTextField = [[UITextField new] autorelease];
    UIView *indentView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 5.f, 0.f)];
    indentView.backgroundColor = UIColor.clearColor;
    _urlTextField.leftView = indentView;
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
    [_urlTextField setFont:[UIFont systemFontOfSize:16.f]];
    _urlTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_urlTextField];
    
    NSLayoutYAxisAnchor *topAnchor = nil;
    if (@available(iOS 11, *)) {
        topAnchor = self.view.safeAreaLayoutGuide.topAnchor;
    } else {
        topAnchor = self.topLayoutGuide.bottomAnchor;
    }
    
    [_urlTextField.topAnchor constraintEqualToAnchor:topAnchor constant:5.f].active = YES;
    [_urlTextField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:15.f].active = YES;
    [_urlTextField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-15.f].active = YES;
    [_urlTextField.heightAnchor constraintEqualToConstant:32.f].active = YES;
}


-(void)setupResultTextView {
    _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_startButton setTitle:@"GO" forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _startButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_startButton];
    
    [_startButton.topAnchor constraintEqualToAnchor:_urlTextField.bottomAnchor constant:5.f].active = YES;
    [_startButton.centerXAnchor constraintEqualToAnchor:_urlTextField.centerXAnchor constant:5.f].active = YES;
    [_startButton addTarget:self action:@selector(buttonTap) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setupStartButton {
    _resultTextView = [UITextView new];
    _resultTextView = [UITextView new];
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


-(void)buttonTap {
    [injectorContainer().transferManager addDownloadTaskWithURL:_urlTextField.text handler:^(NSString *downloadedString, WTTransferManagerTaskState state, NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
