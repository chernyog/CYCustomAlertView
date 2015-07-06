//
//  CYAlertView.m
//  CYAlertView
//
//  Created by cheny on 15/7/1.
//  Copyright (c) 2015年 zhssit. All rights reserved.
//

#import "CYAlertView.h"
#import "CYButton.h"


@interface CYAlertView ()

@property (nonatomic,strong) NSMutableArray *buttonArray;

/** 弹出框 */
@property (strong, nonatomic) UIView *dialogView;
/** 标题View */
@property (weak, nonatomic) UILabel *titleLabel;
/** 分割线 */
@property (weak, nonatomic) UIView *lineView;

@end

@implementation CYAlertView

#pragma mark - 懒加载

- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (NSMutableArray *)buttonTitles {
    if (_buttonTitles == nil) {
        _buttonTitles = [NSMutableArray array];
    }
    return _buttonTitles;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = CYColor(198, 198, 198);
        [self.dialogView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.frame = CGRectMake(0, 0, CYCustomAlertViewWidth, CYCustomAlertViewTitleHeight);
        titleLabel.font = CYFontB(16);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel = titleLabel;
        [self.dialogView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)dialogView {
    if (_dialogView == nil) {
        UIView *dialogView = [[UIView alloc]init];
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
        _dialogView = dialogView;
    }
    return _dialogView;
}

#pragma mark - 生命周期方法
- (void)layoutSubviews {
    [super layoutSubviews];

    // 对话框
    self.dialogView.width = CYCustomAlertViewWidth;
    self.dialogView.height = CYCustomAlertViewHeight;
    self.dialogView.centerX = self.centerX;
    self.dialogView.centerY = self.centerY;

    // 分割线
    CGFloat lineViewX = 0;
    CGFloat lineViewY = CGRectGetMaxY(self.containerView.frame) - 1;
    CGFloat lineViewW = CYCustomAlertViewWidth;
    CGFloat lineViewH = CYCustomAlertViewDefaultButtonSpacerHeight;
    self.lineView.frame = CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH);

    // 操作按钮
    if (self.buttonArray == nil) return;
    NSUInteger count = [self.buttonArray count];
    CGFloat buttonWidth = (self.dialogView.width * 1.0) / count;
    CGFloat eventButtonW = buttonWidth;
    CGFloat eventButtonH = self.dialogView.height - CGRectGetMaxY(self.lineView.frame);
    CGFloat eventButtonY =  CGRectGetMaxY(self.containerView.frame);
    for (NSUInteger i = 0; i < count; i++) {
        CGFloat eventButtonX = i * buttonWidth;
        UIButton *eventButton = [self.buttonArray objectAtIndex:i];
        eventButton.frame = CGRectMake(eventButtonX, eventButtonY, eventButtonW, eventButtonH);
    }
}

#pragma mark - 对外公开方法
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super init]) {
        self.dialogView.width = CYCustomAlertViewWidth;
        self.dialogView.height = CYCustomAlertViewHeight;
        self.dialogView.centerX = self.centerX;
        self.dialogView.centerY = self.centerY;
        
        self.title = title;
        self.message = message;
        self.delegate = delegate;
        self.frame = CYScreen.bounds;
        // 获取可变参数的值
        if (![self isBlankString:cancelButtonTitle]) {
            [self.buttonTitles addObject:cancelButtonTitle];
        }
        NSString *str;
        va_list list;
        if(otherButtonTitles)
        {
            //1.取得第一个参数的值
            CYLog(@"%@", otherButtonTitles);
            [self.buttonTitles addObject:otherButtonTitles];
            //2.从第2个参数开始，依此取得所有参数的值
            va_start(list, otherButtonTitles);
            while ((str = va_arg(list, NSString *))){
                CYLog(@"%@", str);
                [self.buttonTitles addObject:str];
            }
            va_end(list);
        }
        CYLog(@"%@", self.buttonTitles);
    }
    return self;
}

- (void)show
{
    [self setupContainerView];
    [self setupButtons];
    [self setupDialogStyle];
}


#pragma mark - 重写set方法
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setContainerView:(UIView *)containerView {
    _containerView = containerView;
    
    _containerView.width = CYCustomAlertViewWidth;
    _containerView.height = CYCustomAlertViewHeight - CYCustomAlertViewButtonHeigth - CYCustomAlertViewTitleHeight;
    _containerView.x = 0;
    _containerView.y = CYCustomAlertViewTitleHeight;
    if ([_containerView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *tmpView = (UIScrollView *)_containerView;
        tmpView.contentSize = CGSizeMake(_containerView.width, _containerView.height);
    }
    [self.dialogView addSubview:_containerView];
}

#pragma mark - 私有方法
- (void)setupContainerView
{
    if (self.containerView == nil) {
        self.containerView = [[UIView alloc] init];
        self.containerView.width = CYCustomAlertViewWidth;
        self.containerView.height = CYCustomAlertViewHeight - CYCustomAlertViewButtonHeigth - CYCustomAlertViewTitleHeight;;
        self.containerView.x = 0;
        self.containerView.y = CYCustomAlertViewTitleHeight;
        // 添加label
        UILabel *messageLabel = [[UILabel alloc]init];
        messageLabel.frame = self.containerView.bounds;
        messageLabel.text = self.message;
        messageLabel.backgroundColor = [UIColor whiteColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = CYFont(13);
        [self.containerView addSubview:messageLabel];
    }
}

/** 设置对话框的外观 */
- (void)setupDialogStyle
{
    self.dialogView.layer.shouldRasterize = YES;
    self.dialogView.layer.rasterizationScale = [CYScreen scale];
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [CYScreen scale];
    
    self.dialogView.layer.opacity = 0.5f;
    self.dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [self addSubview:self.dialogView];
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    
    [UIView animateWithDuration:0.2f animations:^{
        self.backgroundColor = CYColor_A(0, 0, 0, 0.4);
        self.dialogView.layer.opacity = 1.0f;
        self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

/** 添加按钮 */
- (void)setupButtons
{
    if (self.buttonTitles == nil) return;
    
    NSUInteger count = [self.buttonTitles count];
    CGFloat buttonWidth = (self.dialogView.width * 1.0) / count;
    CGFloat eventButtonW = buttonWidth;
    CGFloat eventButtonH = CYCustomAlertViewButtonHeigth;
    CGFloat eventButtonY =  CGRectGetMaxY(self.containerView.frame); // self.dialogView.height - CYCustomAlertViewButtonHeigth;
    for (NSUInteger i = 0; i < count; i++) {
        CYButton *eventButton = [CYButton buttonWithType:UIButtonTypeCustom];
        CGFloat eventButtonX = i * buttonWidth;
        eventButton.frame = CGRectMake(eventButtonX, eventButtonY, eventButtonW, eventButtonH);
        // 绑定事件
        [eventButton addTarget:self action:@selector(customAlertViewButton_Click:) forControlEvents:UIControlEventTouchUpInside];
        // 设置按钮属性
        eventButton.tag = i;
        [eventButton setTitle:[self.buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
        [eventButton setTitleColor:[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f] forState:UIControlStateNormal];
        [eventButton setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.5f] forState:UIControlStateHighlighted];
        [eventButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [eventButton.layer setCornerRadius:CYCustomAlertViewCornerRadius];
        // 设置按钮背景图片
        [eventButton setBackgroundImage:[UIImage imageNamed:CYCustomAlertViewSrcName(@"btn_bg")] forState:UIControlStateNormal];
        if (i == 0) {
            [eventButton.titleLabel setFont:CYFontB(17)];
        }
        // 设置按钮底部为圆角
        if (count > 1) {
            UIBezierPath *maskPath = nil;
            if (i == 0) {
                maskPath = [UIBezierPath bezierPathWithRoundedRect:eventButton.bounds byRoundingCorners: UIRectCornerBottomLeft cornerRadii:CGSizeMake(CYCustomAlertViewCornerRadius, CYCustomAlertViewCornerRadius)];
            }else if (i == (count - 1)) {
                maskPath = [UIBezierPath bezierPathWithRoundedRect:eventButton.bounds byRoundingCorners: UIRectCornerBottomRight cornerRadii:CGSizeMake(CYCustomAlertViewCornerRadius, CYCustomAlertViewCornerRadius)];
            }else {
                maskPath = [UIBezierPath bezierPathWithRoundedRect:eventButton.bounds byRoundingCorners: kNilOptions cornerRadii:CGSizeMake(CYCustomAlertViewCornerRadius, CYCustomAlertViewCornerRadius)];
            }
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = eventButton.bounds;
            maskLayer.path = maskPath.CGPath;
            eventButton.layer.mask = maskLayer;
        }
        [self.buttonArray addObject:eventButton];
        [self.dialogView addSubview:eventButton];
    }
}

///  判断是否是空白字符串
///
///  @param string string
///
///  @return 是否是空白字符串
- (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/** 隐藏弹出框 */
- (void)close
{
    self.dialogView.layer.opacity = 1.0f;
    for (UIView *v in [self subviews]) {
        [v removeFromSuperview];
    }
    [self removeFromSuperview];
}


#pragma mark - 按钮点击事件
/** 按钮点击事件 */
- (void)customAlertViewButton_Click:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(customAlertView:clickedButtonAtIndex:)]) {
        [self.delegate customAlertView:self clickedButtonAtIndex:[sender tag]];
        [self close];
    }
}



@end
