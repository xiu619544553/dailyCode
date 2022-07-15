//
//  TKVideoPlayerSupportUtils.h
//  ScreenRotationDemo
//
//  Created by hello on 2022/6/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKVideoPlayerSupportUtils : NSObject

@end


typedef NS_ENUM(NSUInteger, TKLogLevel) {
    // no log output.
    TKLogLevelNone = 0,

    // output debug, warning and error log.
    TKLogLevelError = 1,

    // output debug and warning log.
    TKLogLevelWarning = 2,

    // output debug log.
    TKLogLevelDebug = 3,
};


@interface TKLog : NSObject

/**
 * Output message to console.
 *
 *  @param logLevel         The log type.
 *  @param file         The current file name.
 *  @param function     The current function name.
 *  @param line         The current line number.
 *  @param format       The log format.
 */
+ (void)logWithFlag:(TKLogLevel)logLevel
               file:(const char *)file
           function:(const char *)function
               line:(NSUInteger)line
             format:(NSString *)format, ...;

@end




#ifdef __OBJC__

#define TK_LOG_MACRO(logFlag, frmt, ...) \
                                        [TKLog logWithFlag:logFlag\
                                                      file:__FILE__ \
                                                  function:__FUNCTION__ \
                                                      line:__LINE__ \
                                                    format:(frmt), ##__VA_ARGS__]


#define TK_LOG_MAYBE(logFlag, frmt, ...) TK_LOG_MACRO(logFlag, frmt, ##__VA_ARGS__)

#if DEBUG

/**
 * Log debug log.
 */
#define TKDebugLog(frmt, ...) TK_LOG_MAYBE(TKLogLevelDebug, frmt, ##__VA_ARGS__)

/**
 * Log debug and warning log.
 */
#define TKWarningLog(frmt, ...) TK_LOG_MAYBE(TKLogLevelWarning, frmt, ##__VA_ARGS__)

/**
 * Log debug, warning and error log.
 */
#define TKErrorLog(frmt, ...) TK_LOG_MAYBE(TKLogLevelError, frmt, ##__VA_ARGS__)

#else

#define TKDebugLog(frmt, ...)
#define TKWarningLog(frmt, ...)
#define TKErrorLog(frmt, ...)
#endif

#endif


NS_ASSUME_NONNULL_END
