//
//  WTLoggerReader.h
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTLoggerReaderProtocol.h"

/*
 * wrapper for c++ logreader
 */

@interface WTLoggerReader : NSObject<WTLoggerReaderProtocol>

@end
