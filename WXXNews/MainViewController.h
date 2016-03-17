//
//  MainViewController.h
//  WXXNews
//
//  Created by 钟高荣 on 14-9-12.
//  Copyright (c) 2014年 WangXiaoXiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^HiddenTabbar)(BOOL isHidden);
@interface MainViewController : UITabBarController

@property(nonatomic,copy) HiddenTabbar hiddenTabberBlock;
@end
