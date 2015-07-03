/**
 *
 *  FileName：UIView+CYFrame.h
 *  Author：cheny
 *  Date：2013-5-2
 *  Desc：UIView的分类，目的是快速设置和访问UIView的Frame属性
 *
 */

#import <UIKit/UIKit.h>

@interface UIView (CYFrame)

// 在分类里面自动生成get,set方法
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@end
