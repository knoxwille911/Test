//
//  WTLoggerReaderProtocol.h
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WTLoggerReaderAddSourceHandler) (BOOL result);
typedef void (^WTLoggerReaderGetNextLineHandler) (BOOL result, NSString *line);

@protocol WTLoggerReaderProtocol<NSObject>

-(bool)setFilter:(NSString *)filter;
-(void)addSourceBlock:(NSString *)block blockSize:(NSNumber *)blockSize handler:(WTLoggerReaderAddSourceHandler)handler;
-(void)getNextLine:(NSString *)line lineSize:(NSNumber *)lineSize handler:(WTLoggerReaderGetNextLineHandler)handler;

@end
