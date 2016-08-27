//
//  UITableView+HHTableView.h
//  YaPi
//
//  Created by 曹后红 on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HHTableView)
/**
 *  快速创建tableView
 *
 *  @param frame    tableView的frame
 *  @param delegate 代理
 *
 *  @return 返回一个自定义的tableView
 */

+ (UITableView *)initWithTableView:(CGRect)frame withDelegate:(id)delegate;
@end
