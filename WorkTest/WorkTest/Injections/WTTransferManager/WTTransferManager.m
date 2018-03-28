//
//  WTTransferManager.m
//  WorkTest
//
//  Created by Dmtech on 28.03.18.
//  Copyright © 2018 AntonK. All rights reserved.
//

#import "WTTransferManager.h"

@interface WTTransferManager()<NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate> {
    NSURLSession *_session;
    NSMutableArray<NSURLSessionTask *> *_activeTasks;
    NSMutableDictionary *_handlers;
}

@property (nonatomic, strong) id<WTTransferManagerInjection>injection; //unnesseseraty right now

@end

@implementation WTTransferManager

-(instancetype)initWithInjection:(id<WTTransferManagerInjection>)injection {
    if (self = [super init]) {
        self.injection = injection;
        _activeTasks = [NSMutableArray new];
        _handlers = [NSMutableDictionary new];
        
        [self setupSession];
    }
    return self;
}


-(void)setupSession {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration  defaultSessionConfiguration];
    config.HTTPMaximumConnectionsPerHost = 40;
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
}


-(void)addDownloadTaskWithURL:(NSString *)url handler:(WTTransferManagerDownloadingHandler)handler {
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]]];
    [_activeTasks addObject:dataTask];
    [_handlers setObject:handler forKey:@(dataTask.taskIdentifier)];
    
    [dataTask resume];
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
    
}


-(void)URLSession:(NSURLSession *)session
             task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskIdentifier == %d", task.taskIdentifier];
    NSArray<NSURLSessionTask *> *filteredArray = [[NSArray arrayWithArray:_activeTasks] filteredArrayUsingPredicate:predicate];
    if (filteredArray.count) {
        if (error) {
            WTTransferManagerDownloadingHandler neededHandler = [_handlers objectForKey:@(filteredArray.firstObject.taskIdentifier)];
            neededHandler(nil, error ? WTTransferManagerTaskStateError : WTTransferManagerTaskStateComplete, error);
        }
        [_activeTasks removeObjectsInArray:filteredArray];
        [_handlers removeObjectForKey:@(filteredArray.firstObject.taskIdentifier)];
    }
}


-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskIdentifier == %d", dataTask.taskIdentifier];
    
    NSString* dataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    NSArray<NSURLSessionTask *> *filteredArray = [[NSArray arrayWithArray:_activeTasks] filteredArrayUsingPredicate:predicate];
    if (filteredArray.count) {
        WTTransferManagerDownloadingHandler neededHandler = [_handlers objectForKey:@(filteredArray.firstObject.taskIdentifier)];
        neededHandler(dataStr, WTTransferManagerTaskStateRunning, nil);
    }
}


-(WTTransferManagerDownloadingHandler)neededHandlerForSessionTask:(NSURLSessionTask *)sessionTask {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskIdentifier == %d", sessionTask.taskIdentifier];
    NSArray<NSURLSessionTask *> *filteredArray = [[NSArray arrayWithArray:_activeTasks] filteredArrayUsingPredicate:predicate];
    if (filteredArray.count) {
        WTTransferManagerDownloadingHandler neededHandler = [_handlers objectForKey:@(filteredArray.firstObject.taskIdentifier)];
        return neededHandler;
    }
    return nil;
}

@end
