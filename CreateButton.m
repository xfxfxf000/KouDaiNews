//
//  CreateButton.m
//  WXXNews
//
//  Created by a a a a a on 13-6-21.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CreateButton.h"

@implementation CreateButton

//创建一个用于导航栏上的按钮
+(UIButton *)createButtonTypeCustomWithBarButton:(UIImage *)image andWithSEL:(SEL)sel andTarget:(id)name{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:name action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//创建一个自定义的按钮
+(UIButton *)createCustomButton:(UIImage *)image andWithSEL:(SEL)sel andTarget:(id)name andWithFrame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:name action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//圆角按钮
+(UIButton *)createRoundedRectButtonWithTitle:(NSString *)title andWithSEL:(SEL)sel andTarget:(id)name andWithFrame:(CGRect)frame{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:name action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
