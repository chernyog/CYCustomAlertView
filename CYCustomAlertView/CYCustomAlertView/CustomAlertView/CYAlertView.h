//
//  CYAlertView.h
//  CYAlertView
//
//  Created by cheny on 15/7/1.
//  Copyright (c) 2015年 zhssit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYCustomAlertView.h"


@class CYAlertView;

@protocol CYAlertViewDelegate <NSObject>

@optional

- (void)customAlertView:(CYAlertView *)customAlertView clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)customAlertViewCancel:(CYAlertView *)customAlertView;

- (void)willPresentCustomAlertView:(CYAlertView *)customAlertView;  // before animation and showing view
- (void)didPresentCustomAlertView:(CYAlertView *)customAlertView;  // after animation

- (void)customAlertView:(CYAlertView *)customAlertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)customAlertView:(CYAlertView *)customAlertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

@end

@interface CYAlertView : UIView

/** 代理对象 */
@property(weak, nonatomic) id /*<CYAlertViewDelegate>*/ delegate;
/** 弹出框的标题 */
@property(copy, nonatomic) NSString *title;
/** 提示消息内容 */
@property(copy, nonatomic) NSString *message;
/** 容器视图（添加用户自定义的控件） */
@property (strong, nonatomic) UIView *containerView;
/** 弹出框 */
@property (strong, nonatomic) UIView *dialogView;
/** 按钮标题数组 */
@property (strong, nonatomic) NSArray *buttonTitles;

/**
 实例化CYAlertView对象

 @param title             title
 @param message           message
 @param delegate          delegate
 @param cancelButtonTitle cancelButtonTitle
 @param otherButtonTitles otherButtonTitles

 @return CYAlertView对象
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

/** 显示弹出框 */
- (void)show;

/** 隐藏弹出框 */
- (void)close;

@end
