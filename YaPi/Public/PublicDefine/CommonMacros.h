//
//  CommonMacros.h
//  YaPi
//
//  Created by 曹后红 on 16/7/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h
#endif

// 屏幕宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//适配比列
#define UIRate SCREEN_WIDTH/375.0

//color
// 获取颜色alpha默认1
#define RGBCOLOR(RED,GREEN,BLUE) [UIColor colorWithRed:RED/255.00 green:GREEN/255.00 blue:BLUE/255.00 alpha:1.0]

// 获取颜色
#define RGBACOLOR(RED,GREEN,BLUE,ALPHA)[UIColor colorWithRed:RED/255.00 green:GREEN/255.00 blue:BLUE/255.00 alpha:(ALPHA)]
//rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//rgb颜色转换（16进制->10进制）
#define UIColorFromRGBA(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:0]
//字体大小
#define IOS7_Font(sizeX) [UIFont fontWithName:@"HelveticaNeue" size:sizeX]
#define IOS7_BlodFont(sizeX) [UIFont fontWithName:@"Helvetica-Bold" size:sizeX]

