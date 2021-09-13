//
//  UIViewController+Tracking.m
//  RuntimeDemo
//
//  Created by hello on 2021/9/13.
//

#import "UIViewController+Tracking.h"
#import "AppDelegate.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)

/*
 * 用给定的名称和实现向类添加新方法。
 *
 * @param cls 要向其添加方法的类。
 * @param name 指定要添加的方法的名称的选择器。
 * @param imp 新的实现。函数必须接受至少两个参数:self和_cmd。
 * @param types 描述方法参数类型的字符数组。
 *
 * @return 如果成功添加了方法，则是YES，否则是NO(例如，类已经包含了一个同名的方法实现)。
 *
 * @note class_addMethod将添加超类实现的覆盖，但不会替换该类中的现有实现。要更改现有的实现，请使用method_setImplementation。
 */
// BOOL class_addMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp, const char * _Nullable types)

/*
 * 替换给定类的方法实现。
 *
 * @param cls 要修改的类。
 * @param name 标识要替换其实现的方法的选择器。
 * @param imp 由cls标识的类的由名称标识的方法的新实现。
 * @param types 描述方法参数类型的字符数组。函数至少有 self和_cms两个参数
 *
 * @return 返回旧的IMP
 *
 * @note 这个函数有两种不同的行为方式:
 * - 如果由name标识的选择器还不存在，则添加它，就像调用了class_addMethod一样。
     使用类型指定的类型编码。
 * - 如果按名称标识的选择器确实存在，它的IMP将被替换，就像调用method_setImplementation一样。
     忽略types指定的类型编码。
 *
 */
// IMP _Nullable class_replaceMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp, const char * _Nullable types)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(tk_viewDidLoad);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        // 旧方法的实现更换为新方法的实现
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            // 新SEL的实现为旧IMP --> 调用新方法，可以调用旧方法
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else { // add失败，标识该类已有 swizzledSelector 同名的方法
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
#pragma mark - Method Swizzling

- (void)tk_viewDidLoad {
    [self tk_viewDidLoad];
    
    NSLog(@"%@_%s", NSStringFromClass([self class]), __func__);
    
    static dispatch_once_t onceToken;
    static dispatch_semaphore_t lock;
    dispatch_once(&onceToken, ^{
        lock = dispatch_semaphore_create(1);
    });
    
    
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    
    NSString *key = NSStringFromClass([self class]);
    NSNumber *val = [ViewControllerCountDict objectForKey:key];
    if (val) { val = @(val.integerValue + 1); }
    else { val = @(1); }
    
    [ViewControllerCountDict setObject:val forKey:key];
    
    dispatch_semaphore_signal(lock);
}

@end
