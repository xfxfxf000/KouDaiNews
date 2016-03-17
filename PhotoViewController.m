//
//  PhotoViewController.m
//  koudaiNews
//
//  Created by FengXu on 16/3/6.
//  Copyright (c) 2016年 WangXiaoXiang. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    
    label.font = [UIFont boldSystemFontOfSize:20.0f];
    [label setTextColor:[[UIColor redColor]colorWithAlphaComponent:0.5f]];
    [label setText:@"图 集"];
    self.navigationItem.titleView = label;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
