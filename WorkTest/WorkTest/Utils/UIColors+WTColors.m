//
//  UIColors+WTColors.m
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "UIColors+WTColors.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (WTColors)

#pragma mark - urlt text field color

+(UIColor *)urlFieldBackgroundColor {
    return UIColorFromRGB(0xe8e8e8);
}


+(UIColor *)urlFieldTextColor {
    return UIColorFromRGB(0x6b6b6b);
}


+(UIColor *)urlFieldBorderColor {
    return UIColorFromRGB(0x325883);
}


+(UIColor *)urlTextViewTextColor {
    return UIColorFromRGB(0x6b6b6b);
}

#pragma mark - resultTextView color

+(UIColor *)resultTextViewBackgroundColor {
    return UIColorFromRGB(0xe8e8e8);
}


+(UIColor *)resultTextViewTextColor {
    return UIColorFromRGB(0x6b6b6b);
}


+(UIColor *)resultTextViewBorderColor {
    return UIColorFromRGB(0x325883);
}


#pragma mark - filter color

+(UIColor *)filterFieldBackgroundColor {
    return UIColorFromRGB(0xe8e8e8);
}


+(UIColor *)filterFieldTextColor {
    return UIColorFromRGB(0x6b6b6b);
}


+(UIColor *)filterFieldBorderColor {
    return UIColorFromRGB(0x325883);
}


+(UIColor *)filterTextViewTextColor {
    return UIColorFromRGB(0x6b6b6b);
}

@end
