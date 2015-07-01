//
//  CYCustomAlertView.h
//  CYCustomAlertView
//
//  Created by cheny on 15/7/1.
//  Copyright (c) 2015年 zhssit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYCustomAlertView;

@protocol CYCustomAlertViewDelegate <NSObject>

@optional

- (void)customAlertView:(CYCustomAlertView *)customAlertView clickedButtonAtIndex:(NSInteger)buttonIndex;


- (void)customAlertViewCancel:(CYCustomAlertView *)customAlertView;

- (void)willPresentCustomAlertView:(CYCustomAlertView *)customAlertView;  // before animation and showing view
- (void)didPresentCustomAlertView:(CYCustomAlertView *)customAlertView;  // after animation

- (void)customAlertView:(CYCustomAlertView *)customAlertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)customAlertView:(CYCustomAlertView *)customAlertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

@end

@interface CYCustomAlertView : UIView

/** 代理对象 */
@property(nonatomic,weak) id <CYCustomAlertViewDelegate> delegate;
/** 标题 */
@property(nonatomic,copy) NSString *title;
/** 消息内容 */
@property(nonatomic,copy) NSString *message;


/**
 实例化CYCustomAlertView对象

 @param title             title
 @param message           message
 @param delegate          delegate
 @param cancelButtonTitle cancelButtonTitle
 @param otherButtonTitles otherButtonTitles

 @return CYCustomAlertView对象
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id <UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

@end
