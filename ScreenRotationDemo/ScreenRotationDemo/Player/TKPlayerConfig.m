//
//  SelPlayerConfiguration.m
//  TKVideoPlayer
//
//  Created by hello on 2022/6/16.
//

#import "TKPlayerConfig.h"

@implementation TKPlayerConfig

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _hideControlsInterval = 5.0f;
    }
    return self;
}

+ (void)preferLogLevel:(TKLogLevel)logLevel {
    _logLevel = logLevel;
}

@end
