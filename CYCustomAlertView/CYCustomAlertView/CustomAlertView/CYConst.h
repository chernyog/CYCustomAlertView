
#import <UIKit/UIKit.h>


// 日志输出
#ifdef DEBUG
#define CYLog(...) NSLog(__VA_ARGS__)
#else
#define CYLog(...)
#endif

// RGB颜色
#define CYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define CYColor_A(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 字体大小
#define CYLabelFont [UIFont boldSystemFontOfSize:13]
#define CYFont(f) [UIFont systemFontOfSize:(f)]
#define CYFontB(f) [UIFont boldSystemFontOfSize:(f)]


// 图片路径
#define CYCustomAlertViewSrcName(file) [@"CYCustomAlertView.bundle" stringByAppendingPathComponent:file]

/** 屏幕的宽高 */
#define CYScreen [UIScreen mainScreen]
#define CYScreenWith CYScreen.bounds.size.width
#define CYScreenHeight CYScreen.bounds.size.height

// 常量
/** 弹出框的宽度 */
UIKIT_EXTERN const CGFloat CYCustomAlertViewWidth;
/** 弹出框的高度 */
UIKIT_EXTERN const CGFloat CYCustomAlertViewHeight;
/** 弹出框显示或隐藏时间（较快） */
UIKIT_EXTERN const CGFloat CYCustomAlertViewFastAnimationDuration;
/** 弹出框显示或隐藏时间（较慢） */
UIKIT_EXTERN const CGFloat CYCustomAlertViewSlowAnimationDuration;
/** 圆角半径 */
UIKIT_EXTERN const CGFloat CYCustomAlertViewCornerRadius;
/** 按钮的高度 */
UIKIT_EXTERN const CGFloat CYCustomAlertViewButtonHeigth;
/** 默认的按钮间间距 */
UIKIT_EXTERN const CGFloat CYCustomAlertViewDefaultButtonSpacerHeight;
/** 标题的高度 */
UIKIT_EXTERN const CGFloat CYCustomAlertViewTitleHeight;