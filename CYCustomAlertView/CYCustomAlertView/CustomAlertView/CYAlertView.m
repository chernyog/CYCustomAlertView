//
//  CYAlertView.m
//  CYAlertView
//
//  Created by cheny on 15/7/1.
//  Copyright (c) 2015年 zhssit. All rights reserved.
//

#import "CYAlertView.h"


@interface CYAlertView ()



@end

@implementation CYAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super init]) {
        self.title = title;
        self.delegate = delegate;
        self.frame = CYScreen.bounds;
    }
    return self;
}

- (void)show {
    self.dialogView = [self createContainerView];
    
    self.dialogView.layer.shouldRasterize = YES;
    self.dialogView.layer.rasterizationScale = [CYScreen scale];
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [CYScreen scale];
    
    self.dialogView.layer.opacity = 0.5f;
    self.dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [self addSubview:self.dialogView];
    
    NSLog(@"self ====> %@", NSStringFromCGRect(self.frame));
    NSLog(@"dialogView ====> %@", NSStringFromCGRect(self.dialogView.frame));
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    [UIView animateWithDuration:0.2f animations:^{
        self.backgroundColor = CYColor_A(0, 0, 0, 0.4);
        self.dialogView.layer.opacity = 1.0f;
        self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    self.dialogView.backgroundColor = [UIColor redColor];
}

- (void)close {
    
}

#pragma mark - 私有方法

- (UIView *)createContainerView
{
    if (self.containerView == nil) {
        self.containerView = [[UIView alloc] init];
        self.containerView.width = CYCustomAlertViewWidth;
        self.containerView.height = CYCustomAlertViewHeight;
        self.containerView.centerY = self.centerY;
        self.containerView.centerX = self.centerX;
    }
    
    CGSize screenSize = CYScreen.bounds.size;
    CGFloat dialogWidth = self.containerView.width;
    CGFloat dialogHeight = self.containerView.height + CYCustomAlertViewButtonHeigth + CYCustomAlertViewDefaultButtonSpacerHeight;
    CGSize dialogSize = CGSizeMake(dialogWidth, dialogHeight);
    
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height)];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = dialogContainer.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[CYColor(218, 218, 218) CGColor],
                       (id)[CYColor(233, 233, 233) CGColor],
                       (id)[CYColor(218, 218, 218) CGColor],
                       nil];
    
    CGFloat cornerRadius = CYCustomAlertViewCornerRadius;
    gradient.cornerRadius = cornerRadius;
    [dialogContainer.layer insertSublayer:gradient atIndex:0];
    
    dialogContainer.layer.cornerRadius = cornerRadius;
    dialogContainer.layer.borderColor = [CYColor(198, 198, 198) CGColor];
    dialogContainer.layer.borderWidth = 1;
    dialogContainer.layer.shadowRadius = cornerRadius + 5;
    dialogContainer.layer.shadowOpacity = 0.1f;
    dialogContainer.layer.shadowOffset = CGSizeMake(0 - (cornerRadius+5)/2, 0 - (cornerRadius+5)/2);
    dialogContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    dialogContainer.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds cornerRadius:dialogContainer.layer.cornerRadius].CGPath;
  
    UIView *lineView = [[UIView alloc] init];
    CGFloat lineVirwX = 0;
    CGFloat lineVirwY = dialogContainer.bounds.size.height - CYCustomAlertViewButtonHeigth - CYCustomAlertViewDefaultButtonSpacerHeight;
    CGFloat lineVirwW = dialogContainer.bounds.size.width;
    CGFloat lineVirwH = CYCustomAlertViewDefaultButtonSpacerHeight;
    lineView.frame = CGRectMake(lineVirwX, lineVirwY, lineVirwW, lineVirwH);
    lineView.backgroundColor = CYColor(198, 198, 198);
    [dialogContainer addSubview:lineView];
    [dialogContainer addSubview:self.containerView];
    [self addButtonsToView:dialogContainer];
    return dialogContainer;
}

#pragma mark - 添加按钮
- (void)addButtonsToView: (UIView *)container
{
    if (self.buttonTitles == nil) return;
    
    NSUInteger count = [self.buttonTitles count];
    CGFloat buttonWidth = container.bounds.size.width / count;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *eventButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat eventButtonX = i * buttonWidth;
        CGFloat eventButtonY = container.bounds.size.height - CYCustomAlertViewButtonHeigth;
        CGFloat eventButtonW = buttonWidth;
        CGFloat eventButtonH = CYCustomAlertViewButtonHeigth;
        [eventButton setFrame:CGRectMake(eventButtonX, eventButtonY, eventButtonW, eventButtonH)];
        // 绑定事件
        [eventButton addTarget:self action:@selector(customAlertViewButton_Click:) forControlEvents:UIControlEventTouchUpInside];
        // 设置按钮属性
        [eventButton setTag:i];
        [eventButton setTitle:[self.buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
        [eventButton setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
        [eventButton setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.5f] forState:UIControlStateHighlighted];
        [eventButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [eventButton.layer setCornerRadius:CYCustomAlertViewCornerRadius];
        // 设置按钮背景图片
        [eventButton setBackgroundImage:[UIImage imageNamed:CYCustomAlertViewSrcName(@"btn_bg")] forState:UIControlStateNormal];
//        eventButton.clipsToBounds = YES;
        [container addSubview:eventButton];
    }
}

#pragma mark - 按钮点击事件
/** 按钮点击事件 */
- (void)customAlertViewButton_Click:(id)sender
{
    if (self.delegate != nil) {
        [self.delegate customAlertView:self clickedButtonAtIndex:[sender tag]];
    }
}



@end
