//
//  TKImagePickerController.m
//  dailyCode
//
//  Created by hello on 2020/8/3.
//  Copyright © 2020 TK. All rights reserved.

/*
 NSPhotoLibraryAddUsageDescription: 只能写，不能读
 NSPhotoLibraryUsageDescription: 具有读写权限
 
 尽管这个键管理着对用户的照片库的读写访问，如果你的应用程序只需要向库添加资产而不需要读取任何资产，最好使用NSPhotoLibraryAddUsageDescription
 */

#import "TKImagePickerController.h"
#import <Masonry/Masonry.h>

@interface TKImagePickerController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation TKImagePickerController

#pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.f];
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f));
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIImagePickerController *pickerController = [UIImagePickerController new];
    pickerController.editing = NO;
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    /*
     info: {
         UIImagePickerControllerImageURL = "file:///private/var/mobile/Containers/Data/Application/C54C5904-B41A-4C1B-8B7B-4EC955347E92/tmp/2384618B-5758-4B90-848A-598D90E7EEB7.png";
         UIImagePickerControllerMediaType = "public.image";
         UIImagePickerControllerOriginalImage = "<UIImage: 0x283e7dce0> size {1536, 2048} orientation 0 scale 1.000000";
         UIImagePickerControllerReferenceURL = "assets-library://asset/asset.PNG?id=9235AE3B-67A8-422A-8D1E-E74FFB0B1E52&ext=PNG";
     }
     */
    DLog(@"\ninfo: %@   \nvalue: %@", info, info[UIImagePickerControllerOriginalImage]);
    
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    DLog(@"已取消");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    DLog(@"\nnavigationController: %@  \nviewController: %@", navigationController, viewController);
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    DLog(@"\nnavigationController: %@  \nviewController: %@", navigationController, viewController);
}

// 返回由委托确定的导航控制器所支持的接口朝向的完整集
- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController {
    return UIInterfaceOrientationMaskAll;
}

// 返回由委托确定的导航控制器表示的首选方向
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController {
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortraitUpsideDown;
}

#pragma mark - getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = UIColor.grayColor;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    DLog(@"xxx");
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortraitUpsideDown;
}
@end
