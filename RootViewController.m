

#import "RootViewController.h"
#import "NormalTemplateViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController {
    NormalTemplateViewController *_contentViewController;
}

- (void)dealloc
{
    [_contentNavigationController release];
    [_contentViewController release];
    [_rightMenuVC release];
    [_oper release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self makeView];
    [self isMenuListExist];
    self.view.backgroundColor = [UIColor whiteColor];
   
}


-(void)makeView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //内容导航
//    _contentViewController = [[ContentViewController alloc]init];
    _contentViewController = [[NormalTemplateViewController alloc] initWithID:@"toutiao"];
    _contentNavigationController = [[KDNavigationController alloc]initWithRootViewController:_contentViewController];
    [_contentViewController release];
//    //设置顶bar风格
    
    //内容导航右边的按钮。按钮是加在自己的导航栏上，不是直接导航栏上
    UIButton *rightButton = [CreateButton createButtonTypeCustomWithBarButton:[UIImage imageNamed:@"ic_discuss_list_article.png"] andWithSEL:@selector(rightButtonClicked) andTarget:self];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    _contentViewController.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [rightBarButtonItem release];

    //导航栏背景图片

    [self.view addSubview:_contentNavigationController.view];
    
}


//点击菜单按钮
-(void)rightButtonClicked{
    CGRect rect = CGRectMake(-KTOLEFT_X, 0, self.view.frame.size.width, self.view.frame.size.height);
    //内容VIew向左推170
    [CreateAnimation createAnimationWithView:_contentNavigationController.view moveToFrame:rect target:self selector:@selector(insertContentViewAtZero)];
        //判断菜单VIEW是否存在;
    if (_rightMenuVC == nil) {
        _rightMenuVC = [[RightMenuViewController alloc]init];
        _rightMenuVC.delegate = self;
        //[self.view addSubview:_menuViewController.view]
    }
    [self.view insertSubview:_rightMenuVC.view atIndex:0];
    //一段时间以后把_把
}
//点击左边的按钮
-(void)leftButtonClecked{
     CGRect rect = CGRectMake(KTORIGHT_X, 0, self.view.frame.size.width, self.view.frame.size.height);
    [CreateAnimation createAnimationWithView:_contentNavigationController.view moveToFrame:rect target:self selector:@selector(insertContentViewAtZero)];
}
//把视图插入到最后面
-(void)insertContentViewAtZero{
    [self.view insertSubview:_contentNavigationController.view atIndex:0];
}
//推出内容view
#pragma mark - menuView的代理方法
-(void)pushView{
    //OCPrint(@"rootViewController",@"push");
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //先把ContentView插入到最前面
    [self.view insertSubview:_contentNavigationController.view atIndex:[self.view.subviews count]];
    
    [CreateAnimation createAnimationWithView:_contentNavigationController.view moveToFrame:rect target:nil selector:nil];
    [CreateAnimation dismissViewUseTime:0.75 target:self selector:@selector(dismissAnView)];
    
}
-(void)setTitleAtMenuTableViewCellClicked:(NSString *)title andID:(NSString *)ID{
    //    UIBarButtonItem ;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    label.font = [UIFont boldSystemFontOfSize:20.0f];
 
    NSMutableString *str = [[NSMutableString alloc]initWithString:title];
    
    [str insertString:@" " atIndex:1];
    
    [label setTextColor:[[UIColor redColor]colorWithAlphaComponent:0.8]];
    [label setText:str];
    
    _contentViewController.navigationItem.titleView = label;
    _contentViewController.ID = ID;
    [_contentViewController setNewContentWithID:ID];
    [self pushView];
}
//删除菜单视图
-(void)dismissAnView{
    //把两个菜单视图都删除掉
    [_rightMenuVC.view removeFromSuperview];
    //此时rootView只有一个视图
    
    _rightMenuVC = nil;

}
//判断菜单数据库是否存在，不存在就需要解析Addlist
-(void)isMenuListExist{
    if ([SQLOperate findTable:@"MenuList"]) {
        NSLog(@"数据已经存在!");
        return;
    }else{
        _oper = [[SQLOperate alloc]init];
        //加载文件
        //文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AddList" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
        //放到数据源中,需要拷贝数据里面的内容
        NSArray *tmpArray = [dic objectForKey:@"list"];
        for (NSDictionary *item in tmpArray) {
            //取出数据,并且存入数据库中
            AddItem *addItem = [[AddItem alloc]init];
            addItem.ID = [item objectForKey:@"id"];
            addItem.state = [[item objectForKey:@"state"]integerValue];
            addItem.title = [item objectForKey:@"title"];
            addItem.url = [item objectForKey:@"url"];
            //存入数据库
            [_oper insertElementToMenuListWithID:addItem.ID andWihtTitle:addItem.title andWithState:[item objectForKey:@"state"] andWithURL:addItem.url];
            //添加到数组当中
            [addItem release];
        }
        [dic release];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
