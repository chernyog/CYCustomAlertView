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

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id/*<CYAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super init]) {
        self.title = title;
        self.delegate = delegate;
        
    }
    return self;
}

- (void)show {
    
}

- (void)close {
    
}

@end
