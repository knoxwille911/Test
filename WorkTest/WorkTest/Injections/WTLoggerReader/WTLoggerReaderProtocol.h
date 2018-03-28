//
//  WTLoggerReaderProtocol.h
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WTLoggerReaderProtocol<NSObject>

-(bool)setFilter:(NSString *)filter;
-(bool)addSourceBlock:(NSString *)block blockSize:(NSNumber *)blockSize;
-(bool)getNextLine:(NSString *)line lineSize:(NSNumber *)lineSize;

@end
