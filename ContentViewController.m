//
//  ContentViewController.m


#import "ContentViewController.h"

@interface ContentViewController ()

@end


@implementation ContentViewController
- (void)dealloc
{
    [_normalVC release];
    [_ID release];
    [super dealloc];
}


-(void)viewDidUnload{
    _normalVC = nil;
    _ID = nil;
}
-(id)init
{
    self = [super init];
    if (self) {
        //设置顶bar风格
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];

        label.font = [UIFont boldSystemFontOfSize:20.0f];
        [label setTextColor:[[UIColor redColor]colorWithAlphaComponent:0.5f]];
        [label setText:@"新 闻"];
        self.navigationItem.titleView = label;
        [label release];

    }
    return self;
}

-(void)makeView{
    self.ID = @"toutiao";
    _normalVC = [[NormalTemplateViewController alloc]initWithID:self.ID];
    _normalVC.view.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight);
    _normalVC.view.backgroundColor = [UIColor blackColor];
    _normalVC.delegate = self;
    [self.view addSubview:_normalVC.view];
}
-(void)setNewContentWithID:(NSString *)ID{
    self.ID = ID;
    [_normalVC.view removeFromSuperview];
    _normalVC = [[NormalTemplateViewController alloc]initWithID:self.ID];
    _normalVC.delegate = self;
    _normalVC.view.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight);
    [self.view addSubview:_normalVC.view];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self makeView];
    self.hidesBottomBarWhenPushed = YES;
	// Do any additional setup after loading the view.
}

-(void)pushViewNewsInfoVC:(UIViewController *)vc{
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
