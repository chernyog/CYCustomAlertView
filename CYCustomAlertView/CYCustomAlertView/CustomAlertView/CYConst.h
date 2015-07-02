//
//  CYConst.h
//  CYCustomAlertView
//
//  Created by apple on 15/7/2.
//  Copyright (c) 2015年 zhssit. All rights reserved.
//

#import <UIKit/UIKit.h>


// 日志输出
#ifdef DEBUG
#define CYLog(...) NSLog(__VA_ARGS__)
#else
#define CYLog(...)
#endif

// RGB颜色
#define CYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 字体大小
#define CYLabelFont [UIFont boldSystemFontOfSize:13]

// 图片路径
#define CYCustomAlertViewSrcName(file) [@"CYCustomAlertView.bundle" stringByAppendingPathComponent:file]

// 常量
UIKIT_EXTERN const CGFloat CYCustomAlertViewWidth;
UIKIT_EXTERN const CGFloat CYCustomAlertViewHeight;
UIKIT_EXTERN const CGFloat CYCustomAlertViewFastAnimationDuration;
UIKIT_EXTERN const CGFloat CYCustomAlertViewSlowAnimationDuration;