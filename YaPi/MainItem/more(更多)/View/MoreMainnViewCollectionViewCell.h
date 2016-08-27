//
//  MoreMainnViewCollectionViewCell.h
//  YaPi
//
//  Created by 曹后红 on 16/8/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CollectionCellType){
    ///三方框架使用
    CollectionCellTypeThirdPart,
    ///系统功能用例
    CollectionCellTypeSystemFunc,
};

@interface MoreMainnViewCollectionViewCell : UICollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame;

///根据Type确定初始化内容
- (void)initWithIndex:(NSInteger)index andType:(CollectionCellType)type;

@end
