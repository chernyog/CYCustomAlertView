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

//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"标题" message:@"消息内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
    
    CYAlertView *alert = [[CYAlertView alloc]initWithTitle:@"我的提示" message:@"消息正文" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
