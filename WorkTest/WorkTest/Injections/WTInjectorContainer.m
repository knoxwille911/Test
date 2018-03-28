//
//  WTInjectorContainer.m
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTInjectorContainer.h"

@implementation WTInjectorContainer

- (id<WTTransferManagerProtocol>)transferManager {
    static id<WTTransferManagerProtocol> transferManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transferManager = [[WTTransferManager alloc] initWithInjection:self];
    });
    return transferManager;
}


- (id<WTLoggerReaderProtocol>)loggerReader {
    static id<WTLoggerReaderProtocol> logger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logger = [[WTLoggerReader alloc] init];
    });
    return logger;
}

@end

WTInjectorContainer *injectorContainer() {
    static WTInjectorContainer * injectorContainer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        injectorContainer = [[WTInjectorContainer alloc] init];
        
    });
    return injectorContainer;
}
