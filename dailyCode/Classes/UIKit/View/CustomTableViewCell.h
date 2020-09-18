//
//  CustomTableViewCell.h
//  test
//
//  Created by hello on 2020/5/19.
//  Copyright © 2020 TK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell
- (void)setName:(NSString *)name
            tag:(NSString *)tag
          count:(NSString *)count;
@end

NS_ASSUME_NONNULL_END
