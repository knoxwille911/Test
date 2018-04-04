//
//  WTTransferManager.h
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTransferManagerProtocol.h"

/*
 * transfer manager just for downloading files
 */

@protocol WTTransferManagerInjection<NSObject> // just for future

@end

@interface WTTransferManager : NSObject<WTTransferManagerProtocol>

- (instancetype)init __attribute__((unavailable("dont use init, use initWithInjection")));

- (instancetype)initWithInjection:(id<WTTransferManagerInjection>)injection;

@end
