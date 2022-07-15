//
//  TKGCDExtensions.m
//  ScreenRotationDemo
//
//  Created by hello on 2022/6/27.
//

#import "TKGCDExtensions.h"
#import <pthread.h>

extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

void TKDispatchSyncOnMainQueue(void (^block)(void)) {
    if (!block) {
        return;
    }

    if (pthread_main_np()) {
        block();
        return;
    }

    dispatch_sync(dispatch_get_main_queue(), block);
}

void TKDispatchAsyncOnMainQueue(void (^block)(void)) {
    if (!block) {
        return;
    }

    if (pthread_main_np()) {
        TKDispatchAsyncOnNextRunloop(block);
        return;
    }

    dispatch_async(dispatch_get_main_queue(), block);
}

void TKDispatchAsyncOnNextRunloop(void (^block)(void)) {
    dispatch_async(dispatch_get_main_queue(), block);
}

void TKDispatchAsyncOnQueue(dispatch_queue_t queue, void (^block)(void)) {
    if (!queue) {
        dispatch_async(dispatch_get_main_queue(), block);
        return;
    }
    dispatch_async(queue, block);
}

void TKDispatchSyncOnQueue(dispatch_queue_t queue, void (^block)(void)) {
    if (!queue) {
        dispatch_sync(dispatch_get_main_queue(), block);
        return;
    }
    dispatch_sync(queue, block);
}

void TKDispatchAfterTimeIntervalInSecond(NSTimeInterval timeInterval, void (^block)(void)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

int64_t tk_dispatch_benchmark(size_t count, void (^block)(void)) {
    return dispatch_benchmark(count, block);
}
