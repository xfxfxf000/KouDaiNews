//
//  MainViewController.m
//  WXXNews
//
//  Created by 钟高荣 on 14-9-12.
//  Copyright (c) 2014年 WangXiaoXiang. All rights reserved.
//

#import "MainViewController.h"
#import "PhotoViewController.h"
#import "RootViewController.h"
#import "VideoViewController.h"
#import "KDNavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tabbar的背景图片
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"share_menu_btn_cancel_normal.png"]];
    
    VideoViewController *fun = [[VideoViewController alloc]init];
    KDNavigationController *nav = [[KDNavigationController alloc]initWithRootViewController:fun];
    [fun release];
    UITabBarItem *item = [[UITabBarItem alloc]init];
    [item setFinishedSelectedImage:[UIImage imageNamed:@"ic_group_channel_video_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_group_channel_video_unselected"]];
    item.title = @"视频";

    nav.tabBarItem = item;
    [item release];
    
//    ic_group_channel_hot_selected
    
    RootViewController *root = [[RootViewController alloc]init];
    UITabBarItem *item2 = [[UITabBarItem alloc]init];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"ic_group_channel_hot_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_group_channel_hot_unselected"]];
    item2.title = @"新闻";
    root.tabBarItem = item2;
    [item2 release];
    
    PhotoViewController *photo = [[PhotoViewController alloc]init];
    KDNavigationController *nav2 =[[KDNavigationController alloc]initWithRootViewController:photo];
    [photo release];
    UITabBarItem *item3 = [[UITabBarItem alloc]init];
    [item3 setFinishedSelectedImage:[UIImage imageNamed:@"ic_group_channel_pic_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"ic_group_channel_pic_unselected"]];
    item3.title = @"图集";
    nav2.tabBarItem = item3;
    [item3 release];
    
    NSArray *array = [NSArray arrayWithObjects:root,nav,nav2, nil];
    [root release];
    [nav release];
    [nav2 release];
    
    
//    改变tabbar的字体颜色
    [[self tabBar]setTintColor:[[UIColor redColor]colorWithAlphaComponent:0.8]];
    
    self.viewControllers = array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)dealloc{
    [super dealloc];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
