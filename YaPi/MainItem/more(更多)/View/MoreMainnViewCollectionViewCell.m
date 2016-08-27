//
//  MoreMainnViewCollectionViewCell.m
//  YaPi
//
//  Created by 曹后红 on 16/8/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MoreMainnViewCollectionViewCell.h"

@implementation MoreMainnViewCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20*UIRate)];
        textLabel.tag = 10000;
        textLabel.center = self.contentView.center;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = IOS7_Font(15*UIRate);
        textLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:textLabel];
        
    }
    return self;
}

- (void)initWithIndex:(NSInteger)index andType:(CollectionCellType)type
{
    UILabel *textLabel =(UILabel *)[self viewWithTag:10000];
    
    if (type == CollectionCellTypeThirdPart) {
        switch (index) {
            case 0:
                textLabel.text = @"AFNetworking";
                break;
            case 1:
                textLabel.text = @"MBProgressHUD";
                break;
            case 2:
                textLabel.text = @"MJRefresh";
                break;
            case 3:
                textLabel.text = @"pop";
                break;
            case 4:
                textLabel.text = @"SDWebImage";
                break;
            case 5:
                textLabel.text = @"Toast";
                break;
             case 6:
                textLabel.text = @"WebViewJavaScriptBridge";
            default:
                break;
        }

    }else if (type == CollectionCellTypeSystemFunc){
        
        switch (index) {
            case 0:
                textLabel.text = @"TouchID";
                break;
            case 1:
                textLabel.text = @"多线程";
                break;
            case 2:
                textLabel.text = @"3";
                break;
            case 3:
                textLabel.text = @"4";
                break;
            case 4:
                textLabel.text = @"5";
                break;
            case 5:
                textLabel.text = @"6";
                break;
            default:
                break;
        }

    }
    
    
}

@end
