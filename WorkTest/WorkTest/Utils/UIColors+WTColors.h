//
//  UIColors+WTColors.h
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WTColors)

#pragma mark - urlt text field color

+(UIColor *)urlFieldBackgroundColor;
+(UIColor *)urlFieldTextColor;
+(UIColor *)urlFieldBorderColor;

+(UIColor *)urlTextViewTextColor;

#pragma mark - filter color

+(UIColor *)filterFieldBackgroundColor;
+(UIColor *)filterFieldTextColor;
+(UIColor *)filterFieldBorderColor;

+(UIColor *)filterTextViewTextColor;

#pragma mark - resultTextView color

+(UIColor *)resultTextViewBackgroundColor;
+(UIColor *)resultTextViewTextColor;
+(UIColor *)resultTextViewBorderColor;

#pragma mark - resultTextView color

+(UIColor *)startButtonTextColor;

#pragma mark - Banners

+(UIColor *)redBannerColor;
+(UIColor *)blueBannerColor;

@end
