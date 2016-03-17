//
//  AddViewController.m


#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController


- (void)dealloc
{
    NSLog(@"添加页面消失");
    [_tableView release];
    [_dataArray release];
    [_oper release];
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        //数据源
        _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
        //取数据
        [self loadPlist];
    }
    return self;
}
//创建导航栏上的元素
-(void)NCMakeView{
    UIButton *leftButton = [CreateButton createButtonTypeCustomWithBarButton:[UIImage imageNamed:@"ic_title_back"] andWithSEL:@selector(backButtonClicked) andTarget:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}
//点击放回按钮
-(void)backButtonClicked{
    [self.delegate rightMenuReloadANDDismissAddVC:self];
}
//创建视图
-(void)makeView{
    
    //表
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-44) style:UITableViewStylePlain];
    //_tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark - 表的代理函数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"add"];
    if (cell == nil) {
        cell = [[[AddMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"add"]autorelease];
    }
    //取出数据源中的内容
    AddItem *addItem = [_dataArray objectAtIndex:indexPath.row];
    cell.titleLable.text = addItem.title;
    [cell setStateToButton:!addItem.state];
    cell.ID = addItem.ID;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kADD_MENU_CELL_HEIGHT;
}
//读取文件
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self NCMakeView];
    [self makeView];

	// Do any additional setup after loading the view.
}
//解析plist文件
-(void)loadPlist{
    if ([SQLOperate findTable:@"MenuList"]) {
        //NSLog(@"数据已经存在!");
        for (id obj in [SQLOperate loadMenuListData]) {
            [_dataArray addObject:obj];
        }
    }else{
    
    }
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
