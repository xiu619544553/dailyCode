//
//  TKVideoPlayerSupportUtils.m
//  ScreenRotationDemo
//
//  Created by hello on 2022/6/27.
//

#import "TKVideoPlayerSupportUtils.h"
#import "TKGCDExtensions.h"
#import "TKPlayerConfig.h"

@implementation TKVideoPlayerSupportUtils

@end


NSString *TKLogMessage = nil;
NSString *TKLogThreadName = nil;
static dispatch_queue_t TKLogSyncQueue;
@implementation TKLog

+ (void)initialize {
    _logLevel = TKLogLevelDebug;
    TKLogSyncQueue = dispatch_queue_create("com.tkvideoplayer.log.sync.queue.www", DISPATCH_QUEUE_SERIAL);
}

+ (void)logWithFlag:(TKLogLevel)logLevel
               file:(const char *)file
           function:(const char *)function
               line:(NSUInteger)line
             format:(NSString *)format, ... {
    if (logLevel > _logLevel || !format) return;

    va_list args;
    va_start(args, format);

    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);

    TKDispatchAsyncOnQueue(TKLogSyncQueue, ^{

        TKLogMessage = message;
        if (TKLogMessage.length) {
            NSString *flag;
            switch (logLevel) {
                case TKLogLevelDebug:
                    flag = @"DEBUG";
                    break;

                case TKLogLevelWarning:
                    flag = @"Waring";
                    break;

                case TKLogLevelError:
                    flag = @"Error";
                    break;

                default:
                    break;
            }

            TKLogThreadName = [[NSThread currentThread] description];
            TKLogThreadName = [TKLogThreadName componentsSeparatedByString:@">"].lastObject;
            TKLogThreadName = [TKLogThreadName componentsSeparatedByString:@","].firstObject;
            TKLogThreadName = [TKLogThreadName stringByReplacingOccurrencesOfString:@"{number = " withString:@""];
            // message = [NSString stringWithFormat:@"[%@] [Thread: %@] %@ => [%@ + %ld]", flag, threadName, message, tempString, line];
            TKLogMessage = [NSString stringWithFormat:@"[%@] [Thread: %02ld] [%@]", flag, (long)[TKLogThreadName integerValue], TKLogMessage];
            NSLog(@"%@", TKLogMessage);
        }

    });
}

@end
