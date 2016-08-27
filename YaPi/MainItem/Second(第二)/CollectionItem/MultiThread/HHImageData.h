//
//  HHImageData.h
//  YaPi
//
//  Created by 曹后红 on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHImageData : NSObject

//索引
@property(nonatomic, assign) int index;

//图片数据
@property(nonatomic, strong) NSData *imageData;

@end
