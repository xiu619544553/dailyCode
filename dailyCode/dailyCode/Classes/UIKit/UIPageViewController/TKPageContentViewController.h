//
//  TKPageContentViewController.h
//  dailyCode
//
//  Created by hello on 2021/4/12.
//  Copyright © 2021 TK. All rights reserved.
//

#import "TKBaseViewController.h"
@class TKPageContentViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol TKPageContentViewControllerDelegate <NSObject>

@optional
- (void)viewController:(TKPageContentViewController *)viewController willAppearAtIndex:(NSInteger)index;
- (void)viewController:(TKPageContentViewController *)viewController didAppearAtIndex:(NSInteger)index;

- (void)viewController:(TKPageContentViewController *)viewController willDisappearAtIndex:(NSInteger)index;
- (void)viewController:(TKPageContentViewController *)viewController didDisappearAtIndex:(NSInteger)index;

@end

@interface TKPageContentViewController : TKBaseViewController

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, copy) NSString *pageTitle;

@property (nonatomic, weak) id <TKPageContentViewControllerDelegate> lifeCycleDelegate;

@end

NS_ASSUME_NONNULL_END
