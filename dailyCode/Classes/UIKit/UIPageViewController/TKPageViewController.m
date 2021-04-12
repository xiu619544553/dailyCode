//
//  TKPageViewController.m
//  dailyCode
//
//  Created by hello on 2021/4/9.
//  Copyright © 2021 TK. All rights reserved.
//  https://www.pianshen.com/article/54761698031/

#import "TKPageViewController.h"
#import "TKPageContentViewController.h"

@interface TKPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray<NSString *> *arrayM;
@end

@implementation TKPageViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    UIViewController *pageController = [UIViewController new];
    pageController.view.backgroundColor = kRandomColor;
    
    /*
     spine 脊柱
     
     Set visible view controllers, optionally with animation. Array should only include view controllers that will be visible after the animation has completed.
     For transition style 'UIPageViewControllerTransitionStylePageCurl', if 'doubleSided' is 'YES' and the spine location is not 'UIPageViewControllerSpineLocationMid', two view controllers must be included, as the latter view controller is used as the back.
     
     用于设置首页中显示的视图，设置可见视图控制器，可选带有动画。数组应该只包括动画完成后可见的视图控制器。
     */
    [self.pageViewController setViewControllers:@[[self viewControllersAtIndex:0]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:^(BOOL finished) {
        NSLog(@"%@", finished ? @"完成" : @"未完成");
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pageViewController.view.frame = self.view.bounds;
}

#pragma mark - UIPageViewControllerDelegate

/// 手势启动时触发的方法【在手势驱动的转换开始之前调用】
/// @param pageViewController UIPageViewController实例
/// @param pendingViewControllers 被转换到的视图控制器
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
    NSLog(@"%s", __func__);
}

/// 当手势发起的转换结束时发送
/// @param pageViewController UIPageViewController
/// @param finished 指示动画是否完成
/// @param previousViewControllers 在转换之前的视图控制器
/// @param completed 指示过渡是否完成或退出。YES:用户完成了翻页手势；NO: 取消转场【跳转到另一个页面，置为 YES；转场途中取消跳转置为 NO】
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSLog(@"%@ %@", finished ? @"动画完成" : @"动画未完成", completed ? @"转场成功" : @"转场取消");
}

/// 指定 pageViewController 支持的窗口方向
- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
    return UIInterfaceOrientationMaskPortrait;
}

/// 指定 pageViewController 窗口首选方向
- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
    return UIInterfaceOrientationPortrait;
}

/// 当设备的方向改变了将会调用这个方法。你可以使用这个方法通过返回UIPageViewControllerSpi呢location类型的一个值来设定页面主键的位置
//- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {}

//- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
//    NSLog(@"%s", __func__);
//    return UIPageViewControllerSpineLocationMid;
//}

#pragma mark - UIPageViewControllerDataSource

/// 回页控制器中页的数量
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return 10;
//}

/// 回页控制器中当前页的索引
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    return 10;
//}

/// 返回之前的控制器
/// @param pageViewController UIPageViewController实例
/// @param viewController 获取当前页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    // 获取当前页控制器
    NSInteger index = ((TKPageContentViewController *)viewController).pageIndex;
    NSLog(@"Before - 获取当前控制器 index: %@", @(index));
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    // 前一页
    index --;
    
    return [self viewControllersAtIndex:index];
}

/// 返回之后的控制器
/// @param pageViewController UIPageViewController实例
/// @param viewController 获取当前页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    // 获取当前页控制器
    NSInteger index = ((TKPageContentViewController *)viewController).pageIndex;
    NSLog(@"After - 获取当前控制器 index: %@", @(index));
    if ((index == [self.arrayM count] - 1) || (index == NSNotFound)) {
        return nil;
    }
    
    // 后一页
    index ++;
    
    return [self viewControllersAtIndex:index];
}

#pragma mark -返回当前页的控制器
- (TKPageContentViewController *)viewControllersAtIndex:(NSInteger)index {
    if (index <= self.arrayM.count) return nil;
    
    TKPageContentViewController *pageContentVC = [[TKPageContentViewController alloc] init];
    pageContentVC.pageTitle = [self.arrayM objectAtIndex:index];
    pageContentVC.view.backgroundColor = [UIColor grayColor];
    pageContentVC.pageIndex = index;
    return pageContentVC;
}

#pragma mark - getter

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        
        // 转场动画有关的 options
        // UIPageViewControllerTransitionStylePageCurl
        NSDictionary *curlOptions = @{UIPageViewControllerOptionSpineLocationKey : @(100)};
        // UIPageViewControllerTransitionStyleScroll
        NSDictionary *scrollOptions = @{UIPageViewControllerOptionInterPageSpacingKey : @(10.f)};
        
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:scrollOptions];
        
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

#pragma mark - getter

- (NSMutableArray<NSString *> *)arrayM {
    if (!_arrayM) {
        _arrayM = [NSMutableArray array];
        
        for (int i = 0; i < 6; i ++) {
            [_arrayM addObject:@(i).stringValue];
        }
    }
    return _arrayM;
}

@end
