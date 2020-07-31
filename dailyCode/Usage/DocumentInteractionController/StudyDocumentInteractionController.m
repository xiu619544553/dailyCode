//
//  StudyDocumentInteractionController.m
//  test
//
//  Created by hello on 2020/6/5.
//  Copyright © 2020 TK. All rights reserved.
//

#import "StudyDocumentInteractionController.h"

@interface StudyDocumentInteractionController () <UIDocumentInteractionControllerDelegate>
// 文档交互控制器
@property (nonatomic,strong) UIDocumentInteractionController *documentController;
@end

@implementation StudyDocumentInteractionController

#pragma mark - getter

- (UIDocumentInteractionController *)documentController {
    if (!_documentController) {
        // 0.pdf地址
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1168EAE7-AB02-44AE-9651-5FF80486F0A9" ofType:@"pdf"];
        
        // 1.指定要分享的链接
        _documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:path]];
        
        // 2.设置分享代理
        _documentController.delegate = self;
    }
    return _documentController;
}

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIDocumentInteractionController";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    previewBtn.frame = CGRectMake(100, 100, 100, 50.f);
    [previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    previewBtn.backgroundColor = UIColor.systemPinkColor;
    previewBtn.layer.cornerRadius = 25.f;
    [previewBtn addTarget:self action:@selector(previewBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previewBtn];
    
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(50, CGRectGetMaxY(previewBtn.frame) + 30, 200, 50.f);
    [menuBtn setTitle:@"不预览，直接操作菜单" forState:UIControlStateNormal];
    menuBtn.backgroundColor = UIColor.systemPinkColor;
    menuBtn.layer.cornerRadius = 25.f;
    [menuBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuBtn];
}

#pragma mark - UIDocumentInteractionController 的两种使用方式

// 方式一：预览
- (void)previewBtnAction {
    BOOL canOpen = [self.documentController presentPreviewAnimated:YES];
    
    if(canOpen) {
        NSLog(@"有可以打开选中文件的应用");
    } else {
        NSLog(@"沒有程序可以打开选中的文件");
    }
}

// 方式二：不预览，直接弹出菜单
- (void)menuBtnAction:(UIButton *)sender {
    // 显示一个`允许用户在另一个应用程序中打开文档`的菜单。这个菜单包含所有可以打开该URL的应用。如果应用，则返回NO
    
    // rect要填写。因为在ipad上会根据rect弹出menu视图。在iphone中，默认就是在底层模态出来；
    BOOL canOpen = [self.documentController presentOpenInMenuFromRect:[sender convertRect:sender.bounds toView:self.view] inView:self.view animated:YES];
    
    if (canOpen) {
        NSLog(@"有可以打开选中文件的应用");
    } else {
        NSLog(@"沒有程序可以打开选中的文件");
    }
}

#pragma mark - UIDocumentInteractionControllerDelegate

// 如果支持预览，该方法必须实现，它将提供预览将在其上显示的视图控制器。如果呈现在导航堆栈顶部，则提供导航控制器，以便以与平台其余部分一致的方式进行动画
// 如果返回导航控制器，则预览页面会push出来；如果返回的不是导航控制器，则present出来；
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController*)controller {
    return self.navigationController;
}


// 如果支持预览，则提供视图和矩形，将用作动画到全屏预览的起点。
// 实际执行的动画取决于平台和其他因素。
// 如果没有实现documentInteractionControllerRectForPreview，指定视图的边界将被使用。
// 如果没有实现documentInteractionControllerViewForPreview，那么预览控制器将会淡入而不是放大。
- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller {
    return self.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller {
    return self.view.frame;
}

// 点击预览窗口的“Done”(完成)按钮时调用
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController*)controller {
    NSLog(@"%s", __func__);
}

// 文件分享面板弹出的时候调用
- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController*)controller {
    NSLog(@"%s", __func__);
}

// 当选择一个文件分享App的时候调用
- (void)documentInteractionController:(UIDocumentInteractionController*)controller willBeginSendingToApplication:(nullable NSString *)application {
    NSLog(@"begin send : %@", application);
}

// 弹框消失的时候走的方法
- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController*)controller {
    NSLog(@"%s", __func__);
}


#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end

