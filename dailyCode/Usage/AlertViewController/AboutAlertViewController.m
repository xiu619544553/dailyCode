//
//  AboutAlertViewController.m
//  test
//
//  Created by hello on 2020/7/3.
//  Copyright © 2020 TK. All rights reserved.
//

/*
 1、UIImagePickerController 禁止子类化
 */

#import "AboutAlertViewController.h"

@interface AboutAlertViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIImageView *imgV;

/// 自定义 UIImagePickerViewController.camera 页面上的拍照、照片缩放等控件
@property (nonatomic, strong) UIView *cameraOverlayView;

@end

@implementation AboutAlertViewController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = UIColor.whiteColor;

    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
    imgV.backgroundColor = UIColor.grayColor;
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgV];
    _imgV = imgV;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.systemPinkColor;
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    _btn = btn;
}

#pragma mark - Event Methods

- (void)btnAction:(UIButton *)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍 照" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
//        [self showCamera];
        [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
//        [self showPhoto];
        [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *cancelAction;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cancelAction = [UIAlertAction actionWithTitle:@"取 消" style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction * _Nonnull action) {
            [actionSheet dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    else {
        cancelAction = [UIAlertAction actionWithTitle:@"取 消" style:UIAlertActionStyleCancel handler:nil];
    }
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:cancelAction];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        actionSheet.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *popover = actionSheet.popoverPresentationController;
        if (nil != popover) {
            popover.sourceView = _btn;
            popover.sourceRect = _btn.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    
    if (info && [info objectForKey:UIImagePickerControllerOriginalImage]) {
        UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
        _imgV.image = image;
    }
    
    DLog(@"完成选取动作=%@", picker.viewControllers);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    DLog(@"取消=%@", picker.viewControllers);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Methods

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    imagePicker.sourceType = sourceType;
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    
    // 自定义 camera 顶层拍照、缩放等控件
//    if (imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//        imagePicker.showsCameraControls = NO;
//
//        self.cameraOverlayView.frame = imagePicker.cameraOverlayView.frame;
//        imagePicker.cameraOverlayView = self.cameraOverlayView;
//    }
    
    
    UIPopoverPresentationController *presentationController = imagePicker.popoverPresentationController;
    presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)showCamera {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    // 以 popover 小窗口形式弹出相机和相册
    imagePicker.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *popPC = imagePicker.popoverPresentationController;
    popPC.sourceView = _btn;
    popPC.sourceRect = _btn.bounds;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        BOOL shouldAutorotate = [imagePicker shouldAutorotate];
        UIInterfaceOrientationMask supportedInterfaceOrientations = [imagePicker supportedInterfaceOrientations];
        UIInterfaceOrientation preferredInterfaceOrientationForPresentation = [imagePicker preferredInterfaceOrientationForPresentation];
        
        DLog(@"\nshouldAutorotate : %@  \nsupportedInterfaceOrientations : %ld   \npreferredInterfaceOrientationForPresentation : %ld", shouldAutorotate ? @"是" : @"否", supportedInterfaceOrientations, preferredInterfaceOrientationForPresentation);
    });
}

- (void)showPhoto {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.navigationBar.translucent = NO;
    [imagePicker.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [imagePicker.navigationBar setShadowImage:[[UIImage alloc] init]];
    
//    imagePicker.cameraOverlayView = self.view;
    
//    imagePicker.modalPresentationStyle = UIModalPresentationPopover;
//    UIPopoverPresentationController *popPC = imagePicker.popoverPresentationController;
//    popPC.sourceView = _btn;
//    popPC.sourceRect = _btn.bounds;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
//    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        BOOL shouldAutorotate = [imagePicker shouldAutorotate];
        UIInterfaceOrientationMask supportedInterfaceOrientations = [imagePicker supportedInterfaceOrientations];
        UIInterfaceOrientation preferredInterfaceOrientationForPresentation = [imagePicker preferredInterfaceOrientationForPresentation];
        
        DLog(@"\nshouldAutorotate : %@  \nsupportedInterfaceOrientations : %ld   \npreferredInterfaceOrientationForPresentation : %ld", shouldAutorotate ? @"是" : @"否", supportedInterfaceOrientations, preferredInterfaceOrientationForPresentation);
    });
}

// 强制竖屏
- (void)forceOrientationPortrait {
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIInterfaceOrientationPortrait] forKey:@"orientation"];
}

#pragma mark - getter

- (UIView *)cameraOverlayView {
    if (!_cameraOverlayView) {
        _cameraOverlayView = [UIView new];
    }
    return _cameraOverlayView;
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortraitUpsideDown;
}
@end
