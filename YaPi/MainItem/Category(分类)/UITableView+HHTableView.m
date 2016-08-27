//
//  UITableView+HHTableView.m
//  YaPi
//
//  Created by 曹后红 on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UITableView+HHTableView.h"

@implementation UITableView (HHTableView)

+ (UITableView *)initWithTableView:(CGRect)frame withDelegate:(id)delegate
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    return tableView;
}
@end
