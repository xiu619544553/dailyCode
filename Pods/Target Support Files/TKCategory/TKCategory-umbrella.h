#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSObject+TKAdd.h"
#import "NSString+TKAdd.h"
#import "UIButton+TKAdd.h"
#import "UIColor+TKAdd.h"
#import "UIViewController+TKAdd.h"

FOUNDATION_EXPORT double TKCategoryVersionNumber;
FOUNDATION_EXPORT const unsigned char TKCategoryVersionString[];

