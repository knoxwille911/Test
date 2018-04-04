//
//  WTConfiguration.m
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTConfiguration.h"

@implementation WTConfiguration

//default url to text file
+(NSString *)textDownloadDefaultURL {
    return @"https://github.com/dscape/spell/raw/master/test/resources/big.txt";
}


+(NSString *)defaultFilter {
    return @"*abc";
}

@end
