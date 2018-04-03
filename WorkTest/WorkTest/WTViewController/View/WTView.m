//
//  WTView.m
//  WorkTest
//
//  Created by Dmtech on 03.04.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTView.h"
#import "UIColors+WTColors.h"
#import "WTConfiguration.h"

static const CGFloat kViewsLeftOffset = 15;

@interface WTView() {
}

@end


@implementation WTView

-(instancetype)initWithFrame:(CGRect)frame viewModel:(WTViewModel *)viewModel {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    
    _backgroundImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background-menu"]] autorelease];
    _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_backgroundImageView];
    
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
    [self addSubview:urlLabel];
    
    NSLayoutYAxisAnchor *topAnchor = self.topAnchor;
    [urlLabel.topAnchor constraintEqualToAnchor:topAnchor constant:25.f].active = YES;
    [urlLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kViewsLeftOffset].active = YES;
    
    _urlTextField = [[UITextField new] autorelease];
    UIView *indentView = [[[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 5.f, 0.f)] autorelease];
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
    _urlTextField.returnKeyType = UIReturnKeyDone;
    [_urlTextField setFont:[UIFont systemFontOfSize:16.f]];
    _urlTextField.borderStyle = UITextBorderStyleNone;
    [self addSubview:_urlTextField];
    
    [_urlTextField.centerYAnchor constraintEqualToAnchor:urlLabel.centerYAnchor constant:0].active = YES;
    [_urlTextField.leadingAnchor constraintEqualToAnchor:urlLabel.trailingAnchor constant:15.f].active = YES;
    [_urlTextField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-15.f].active = YES;
    [_urlTextField.heightAnchor constraintEqualToConstant:32.f].active = YES;
}


-(void)setupFilterView {
    UILabel *label = [[UILabel new] autorelease];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label setFont:[UIFont systemFontOfSize:16.f]];
    [label setText:NSLocalizedString(@"Filter:", @"Filter:")];
    label.textColor = UIColor.filterTextViewTextColor;
    [self addSubview:label];
    
    [label.topAnchor constraintEqualToAnchor:_urlTextField.bottomAnchor constant:25.f].active = YES;
    [label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kViewsLeftOffset].active = YES;
    
    _filterTextField = [[UITextField new] autorelease];
    UIView *indentView = [[[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 5.f, 0.f)] autorelease];
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
    
    [self addSubview:_filterTextField];
    
    [_filterTextField.centerYAnchor constraintEqualToAnchor:label.centerYAnchor constant:0].active = YES;
    [_filterTextField.leadingAnchor constraintEqualToAnchor:_urlTextField.leadingAnchor constant:0.f].active = YES;
    [_filterTextField.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-15.f].active = YES;
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
    [self addSubview:_startButton];
    
    [_startButton.topAnchor constraintEqualToAnchor:_filterTextField.bottomAnchor constant:5.f].active = YES;
    [_startButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:0.f].active = YES;
    [_startButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15.f].active = YES;
    [_startButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-15.f].active = YES;
    
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
    
    [self addSubview:_resultTextView];
    [_resultTextView.topAnchor constraintEqualToAnchor:_startButton.bottomAnchor constant:5.f].active = YES;
    [_resultTextView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15.f].active = YES;
    [_resultTextView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-15.f].active = YES;
    [_resultTextView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5.f].active = YES;
}


-(void)dealloc {
    [super dealloc];
}

@end
