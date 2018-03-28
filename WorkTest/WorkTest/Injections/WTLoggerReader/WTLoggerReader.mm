//
//  WTLoggerReader.m
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTLoggerReader.h"
#include "CLogReader.hpp"

@interface WTLoggerReader() {
    CLogReader *_logReader;
}

@end


@implementation WTLoggerReader

-(bool)setFilter:(NSString *)filter {
    const char *cString = [filter cStringUsingEncoding:NSASCIIStringEncoding];
    return _logReader->SetFilter(cString);
}


-(bool)addSourceBlock:(NSString *)block blockSize:(NSNumber *)blockSize {
    const char *cString = [block cStringUsingEncoding:NSASCIIStringEncoding];
    return _logReader->AddSourceBlock(cString, [blockSize intValue]);
}


-(bool)getNextLine:(NSString *)line lineSize:(NSNumber *)lineSize {
//    char *cString = [line cStringUsingEncoding:NSASCIIStringEncoding];
//    return _logReader->GetNextLine([line UTF8String], [lineSize intValue]);
    return YES;
}

@end