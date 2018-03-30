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

-(instancetype)init {
    if (self = [super init]) {
        _logReader = new CLogReader();
    }
    return self;
}


-(bool)setFilter:(NSString *)filter {
    const char *cString = [filter cStringUsingEncoding:NSASCIIStringEncoding];
    return _logReader->SetFilter(cString);
}


-(bool)addSourceBlock:(NSString *)block blockSize:(NSNumber *)blockSize {
    const char *cString = [block cStringUsingEncoding:NSASCIIStringEncoding];
    return _logReader->AddSourceBlock(cString, [blockSize intValue]);
}


-(bool)getNextLine:(NSString *)line lineSize:(NSNumber *)lineSize {
    char *datechar = (char *)[line cStringUsingEncoding:NSASCIIStringEncoding];
    return _logReader->GetNextLine(datechar, [lineSize intValue]);
    return YES;
}

@end
