//
//  WTBlueBanner.m
//  WorkTest
//
//  Created by Dmtech on 29.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTBlueBanner.h"
#import "UIColors+WTColors.h"

@implementation WTBlueBanner

-(UIColor *)bannerColor {
    return [UIColor blueBannerColor];
}


-(UIColor *)textColor {
    return [UIColor whiteColor];
}


-(UIFont *)textFont {
    return [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
}

@end
