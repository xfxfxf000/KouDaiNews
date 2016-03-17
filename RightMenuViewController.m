//
//  RightMenuViewController.m


#import "RightMenuViewController.h"

@interface RightMenuViewController ()

@end

@implementation RightMenuViewController

- (void)dealloc
{
    [_addBackView release];
    [_addButton release];
    [_editButton release];
    [_addNC release];
    [_dataArray release];
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)makeView{
    NSLog(@"%@",NSHomeDirectory());
    self.view.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    self.view.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(320-KTOLEFT_X, 0, kRIGHT_MENU_WIDTH, self.view.bounds.size.height-30-50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    //add按钮下面的背景条
    _addBackView = [[UIView alloc]initWithFrame:CGRectMake(320-KTOLEFT_X, self.view.bounds.size.height-30-50, kRIGHT_MENU_WIDTH, 30)];
    _addBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"right_menu_add_background2"]];
    [self.view addSubview:_addBackView];
    [_addBackView release];
    //add按钮
    _addButton = [CreateButton createCustomButton:[UIImage imageNamed:@"add_button3"] andWithSEL:@selector(addButtonClicked) andTarget:self andWithFrame:CGRectMake(kRIGHT_MENU_WIDTH-30, 2.5, 25, 25)];
    [self.addBackView addSubview:_addButton];
    //[_addButton release]; //悲催button没了
    //edit按钮
    _editButton = [CreateButton createCustomButton:[UIImage imageNamed:@"right_edit_button.png"] andWithSEL:@selector(editButtonClicked) andTarget:self andWithFrame:CGRectMake(2.5, 2.5, 25, 25)];
    [_addBackView addSubview:_editButton];
}
//点击添加按钮
-(void)addButtonClicked{
    //添加页面
    if (_addNC == nil) {
        AddViewController *tmpVC = [[AddViewController alloc]init];
        tmpVC.delegate = self;
        _addNC = [[KDNavigationController alloc]initWithRootViewController:tmpVC];
    
        [tmpVC release];
    }
    [self presentViewController:_addNC animated:YES completion:nil];
}
//添加页面的代理
-(void)rightMenuReloadANDDismissAddVC:(AddViewController *)addVC{
    [self loadDataFromSQL];
    [_tableView reloadData];
    [addVC dismissViewControllerAnimated:YES
                              completion:nil];
    _addNC = nil;
}
//点击编辑按钮
-(void)editButtonClicked{
    if (isEditing) {
        [_tableView setEditing:NO animated:YES];
    }else{
        [_tableView setEditing:YES animated:YES];
    }
    isEditing = !isEditing;
}
//从数据库中读取数据
-(void)loadDataFromSQL{
    [_dataArray removeAllObjects];
    for (AddItem *addItem in [SQLOperate loadMenuListData]) {
        //NSLog(@"%d",addItem.state);
        //no表示已经添加
        if (addItem.state==YES) {
            [_dataArray addObject:addItem];
        }
    }
}
#pragma mark - 表代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"%d",_dataArray.count);
    return [_dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    RightMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu"];
    if (cell == nil) {
        cell = [[[RightMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menu"]autorelease];
    }
    //从数组中取数据
    AddItem *addItem = [_dataArray objectAtIndex:indexPath.row];
    //放到cell中
    cell.titleLabel.text = addItem.title;
    cell.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRIGHT_MENU_CELL_HEIGHT;
}
//可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//编辑
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%d",indexPath.row);
    //更新一下数据库
    AddItem *addItem = [_dataArray objectAtIndex:indexPath.row];
    SQLOperate *oper = [[SQLOperate alloc]init];
    [oper updateToMenuListWithID:addItem.ID andWithState:@"0"];
    //删除数组中的该项内容
    [_dataArray removeObjectAtIndex:indexPath.row];
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}
//删除按钮样式
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
//点击某一项
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%d",indexPath.row);
    AddItem *addItem = [_dataArray objectAtIndex:indexPath.row];
    [self.delegate setTitleAtMenuTableViewCellClicked:addItem.title andID:addItem.ID];
}
//表代理结束
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"右边的菜单即将收回");
    if ([self.delegate respondsToSelector:@selector(pushView)]) {
        [self.delegate pushView];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self loadDataFromSQL];
    _keepOutView.frame = CGRectMake(0, 0, _keepOutView.bounds.size.width, _keepOutView.bounds.size.height);
    [self makeView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
