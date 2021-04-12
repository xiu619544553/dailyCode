//
//  TKPageContentViewController.h
//  dailyCode
//
//  Created by hello on 2021/4/12.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKPageContentViewController : TKBaseViewController
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, copy) NSString *pageTitle;
@end

NS_ASSUME_NONNULL_END
