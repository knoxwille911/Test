//
//  WTTransferManagerProtocol.h
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WTTransferManagerTaskState) {
    WTTransferManagerTaskStateReady,
    WTTransferManagerTaskStateRunning,
    WTTransferManagerTaskStateComplete,
    WTTransferManagerTaskStateError
};


typedef void (^WTTransferManagerDownloadingHandler) (NSString *downloadedString, WTTransferManagerTaskState state, NSError *error);

@protocol WTTransferManagerProtocol<NSObject>

-(void)addDownloadTaskWithURL:(NSString *)url handler:(WTTransferManagerDownloadingHandler)handler;

-(void)cancelAllTasks;

@end
