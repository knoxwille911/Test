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


-(void)addSourceBlock:(NSString *)block blockSize:(NSNumber *)blockSize handler:(WTLoggerReaderAddSourceHandler)handler {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        const char *cString = [block cStringUsingEncoding:NSASCIIStringEncoding];
        BOOL result = _logReader->AddSourceBlock(cString, [blockSize intValue]);
        if (handler) {
            handler(result);
        }
    });
}


-(void)getNextLine:(NSString *)line lineSize:(NSNumber *)lineSize handler:(WTLoggerReaderGetNextLineHandler)handler {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        char str[lineSize.intValue];
        BOOL result = _logReader->GetNextLine(str, [lineSize intValue]);
        if (handler && result) {
            handler(result, [NSString stringWithUTF8String:str]);
        }
    });
}

@end
