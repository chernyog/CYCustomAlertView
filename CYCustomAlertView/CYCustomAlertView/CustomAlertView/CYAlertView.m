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

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(0, 0, CYScreenWith, CYCustomAlertViewTitleHeight);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel = titleLabel;
        [self.dialogView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)dialogView {
    if (_dialogView == nil) {
        UIView *dialogView = [[UIView alloc]init];
        CGFloat dialogWidth = self.containerView.width;
        CGFloat dialogHeight = self.containerView.height + CYCustomAlertViewButtonHeigth + CYCustomAlertViewDefaultButtonSpacerHeight;
        CGSize dialogSize = CGSizeMake(dialogWidth, dialogHeight);
        CGFloat dialogViewX = (CYScreenWith - dialogSize.width) / 2;
        CGFloat dialogViewY = (CYScreenHeight - dialogSize.height) / 2;
        CGFloat dialogViewW = dialogSize.width;
        CGFloat dialogViewH = dialogSize.height;
        dialogView.frame = CGRectMake(dialogViewX, dialogViewY, dialogViewW, dialogViewH);
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = dialogView.bounds;
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[CYColor(218, 218, 218) CGColor],
                           (id)[CYColor(233, 233, 233) CGColor],
                           (id)[CYColor(218, 218, 218) CGColor],
                           nil];
        
        CGFloat cornerRadius = CYCustomAlertViewCornerRadius;
        gradient.cornerRadius = cornerRadius;
        [dialogView.layer insertSublayer:gradient atIndex:0];
        
        dialogView.layer.cornerRadius = cornerRadius;
        dialogView.layer.borderColor = [CYColor(198, 198, 198) CGColor];
        dialogView.layer.borderWidth = 1;
        dialogView.layer.shadowRadius = cornerRadius + 5;
        dialogView.layer.shadowOpacity = 0.1f;
        dialogView.layer.shadowOffset = CGSizeMake(0 - (cornerRadius+5)/2, 0 - (cornerRadius+5)/2);
        dialogView.layer.shadowColor = [UIColor blackColor].CGColor;
        dialogView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:dialogView.bounds cornerRadius:dialogView.layer.cornerRadius].CGPath;
        self.dialogView = dialogView;
    }
    return _dialogView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.dialogView.width = CYCustomAlertViewWidth;
    self.dialogView.height = CYCustomAlertViewHeight;
    self.dialogView.centerX = self.centerX;
    self.dialogView.centerY = self.centerY;
    
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super init]) {
        
        self.dialogView.width = CYCustomAlertViewWidth;
        self.dialogView.height = CYCustomAlertViewHeight;
        self.dialogView.centerX = self.centerX;
        self.dialogView.centerY = self.centerY;
        
        self.title = title;
        self.delegate = delegate;
        self.frame = CYScreen.bounds;
    }
    return self;
}

- (void)show {
    [self.dialogView addSubview:[self createContainerView]];
    NSLog(@"%@", NSStringFromCGRect(self.dialogView.frame));
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
    self.dialogView.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@", self.dialogView.subviews);
}

- (void)close {
    
}

#pragma mark - 重写set方法
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

#pragma mark - 私有方法

- (void)setContainerView:(UIView *)containerView {
    _containerView = containerView;
    
    _containerView.width = CYCustomAlertViewWidth;
    _containerView.height = CYCustomAlertViewHeight;
    _containerView.x = 0;
    _containerView.y = CYCustomAlertViewTitleHeight;

    
}

- (UIView *)createContainerView
{
    if (self.containerView == nil) {
        self.containerView = [[UIView alloc] init];
        self.containerView.width = CYCustomAlertViewWidth;
        self.containerView.height = CYCustomAlertViewHeight;
        self.containerView.x = 0;
        self.containerView.y = CYCustomAlertViewTitleHeight;
    }
    
#warning TODO!!!
    
    UIView *dialogContainer = [[UIView alloc] init];
  
    UIView *lineView = [[UIView alloc] init];
    CGFloat lineViewX = 0;
    CGFloat lineViewY = dialogContainer.height - CYCustomAlertViewButtonHeigth - CYCustomAlertViewDefaultButtonSpacerHeight;
    CGFloat lineViewW = dialogContainer.width;
    CGFloat lineViewH = CYCustomAlertViewDefaultButtonSpacerHeight;
    lineView.frame = CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH);
    lineView.backgroundColor = CYColor(198, 198, 198);
    [dialogContainer addSubview:lineView];
    [dialogContainer addSubview:self.containerView];
    [self addButtonsToView:dialogContainer];
    dialogContainer.backgroundColor = [UIColor redColor];
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
        [eventButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [eventButton.layer setCornerRadius:CYCustomAlertViewCornerRadius];
        // 设置按钮背景图片
        [eventButton setBackgroundImage:[UIImage imageNamed:CYCustomAlertViewSrcName(@"btn_bg")] forState:UIControlStateNormal];
        if (i == 0) {
            [eventButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        }
        // 设置按钮底部为圆角
        if (count > 1) {
            UIBezierPath *maskPath = nil;
            if (i == 0) {
                 maskPath = [UIBezierPath bezierPathWithRoundedRect:eventButton.bounds byRoundingCorners: UIRectCornerBottomLeft cornerRadii:CGSizeMake(CYCustomAlertViewCornerRadius, CYCustomAlertViewCornerRadius)];
            }
            if (i == (count - 1)) {
                maskPath = [UIBezierPath bezierPathWithRoundedRect:eventButton.bounds byRoundingCorners: UIRectCornerBottomRight cornerRadii:CGSizeMake(CYCustomAlertViewCornerRadius, CYCustomAlertViewCornerRadius)];
            }
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = eventButton.bounds;
            maskLayer.path = maskPath.CGPath;
            eventButton.layer.mask = maskLayer;
        }
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
