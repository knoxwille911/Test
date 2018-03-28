//
//  WTInjectorContainer.h
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTTransferManager.h"

@interface WTInjectorContainer : NSObject<WTTransferManagerInjection>

- (id<WTTransferManagerProtocol>)transferManager;

@end

WTInjectorContainer *injectorContainer();
