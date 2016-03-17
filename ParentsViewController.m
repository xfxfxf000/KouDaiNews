//
//  ParentsViewController.m
//  WXXNews
//
//  Created by 钟高荣 on 14-9-13.
//  Copyright (c) 2014年 WangXiaoXiang. All rights reserved.
//

#import "ParentsViewController.h"

@interface ParentsViewController ()
{
}
@end

@implementation ParentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tabbar的背景图片
    self.tabBarController.tabBar.barStyle = UIBarStyleDefault;
    self.tabBarController.tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"share_menu_btn_cancel_normal.png"]];
}

//设置nav标题
-(void)setNavigationTitle:(NSString *)title{
    
//    UIBarButtonItem ;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    label.font = [UIFont boldSystemFontOfSize:18.0f];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:title];
    self.navigationItem.titleView = label;
    [label release];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
