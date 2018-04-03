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
    NSURLRequest *request = [[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]] autorelease];
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request];
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
    WTTransferManagerDownloadingHandler handler = [self neededHandlerForSessionTask:task];
    if (error) {
        if (handler) {
            handler(nil, WTTransferManagerTaskStateError, error);
        }
        [self removeHandlerForTask:task];
    }
    else {
        if (handler) {
            handler(nil, WTTransferManagerTaskStateComplete, error);
        }
    }
}


-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    WTTransferManagerDownloadingHandler handler = [self neededHandlerForSessionTask:dataTask];
    if (handler) {
        NSString* dataStr = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
        NSLog(@"WTTransferManager: string downloaded %@", dataStr);
        handler(dataStr, WTTransferManagerTaskStateRunning, nil);
    }
}


-(void)removeHandlerForTask:(NSURLSessionTask *)task {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"taskIdentifier == %d", task.taskIdentifier];
    NSArray<NSURLSessionTask *> *filteredArray = [[NSArray arrayWithArray:_activeTasks] filteredArrayUsingPredicate:predicate];
    if (filteredArray.count) {
        [_activeTasks removeObjectsInArray:filteredArray];
        [_handlers removeObjectForKey:@(filteredArray.firstObject.taskIdentifier)];
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


-(void)cancelAllTasks {
    [_activeTasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
    [_activeTasks removeAllObjects];
    [_handlers removeAllObjects];
}

@end
