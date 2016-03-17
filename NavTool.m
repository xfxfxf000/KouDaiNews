//
//  NavTool.m
//  abcd
//
//  Created by Mac on 14-8-26.
//  Copyright (c) 2014年 QF. All rights reserved.
//

#import "NavTool.h"

@interface NavTool ()

@end

@implementation NavTool

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
//生成barbutton
+(void)createBarButton:(UINavigationController *)nav{
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 20,60,30)];
    [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_edit.png"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setFont:[UIFont systemFontOfSize:13.0f]];
    [button setTitle:@"分类" forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    nav.navigationItem.leftBarButtonItem = item;
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(280,20,60,30)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"buttonbar_edit.png"] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button2 setFont:[UIFont systemFontOfSize:13.0f]];
    [button2 setTitle:@"设置" forState:UIControlStateNormal];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:button2];
    nav.navigationItem.rightBarButtonItem = item2;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
