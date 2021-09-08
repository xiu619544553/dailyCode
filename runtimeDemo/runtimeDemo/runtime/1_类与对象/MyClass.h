//
//  MyClass.h
//  RuntimeDemo
//
//  Created by hello on 2021/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClass : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *string;

- (void)method1;
- (void)method2;
+ (void)classMethod1;


- (void)imp_submethod1;


@end

NS_ASSUME_NONNULL_END
