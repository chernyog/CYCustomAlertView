//
//  ViewController.m
//  CYCustomAlertView
//
//  Created by cheny on 15/7/1.
//  Copyright (c) 2015年 zhssit. All rights reserved.
//

#import "ViewController.h"
#import "CYCustomAlertView.h"

@interface ViewController () <CYAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"标题" message:@"消息内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

- (IBAction)showDialog {
    CYAlertView *alert = [[CYAlertView alloc]initWithTitle:@"我的提示" message:@"消息正文" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.containerView = [self createDemoView];
    alert.message = @"消息正文";
    alert.title = @"提示标题";
    alert.buttonTitles = [NSMutableArray arrayWithArray:@[@"取消", @"提示"]];
    [alert show];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (UIView *)createDemoView
{
    UITextView *textView = [[UITextView alloc]init];
    textView.text = @"非强制，v1.0.4，250服务器\n1、今天早上\n2、的卡是否\n3、的拉伸到了地方\n4、洒落的发疯是\n5、啊大是大非\n6、阿打发第三方\n7、大发发的\n8、wojssdfasdf\n9、我批发快递费\n";
    textView.editable = NO;
    return textView;
}
// MARK: - <CYAlertViewDelegate>
- (void)customAlertView:(CYAlertView *)customAlertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    CYLog(@"cy ============================ %zd", buttonIndex);
}

@end
