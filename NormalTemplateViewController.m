//
//  NormalTemplateViewController.m

#import "NormalTemplateViewController.h"
#import "NewsInformationViewController.h"
@interface NormalTemplateViewController ()
{
    JSONFileOperate *jsonOper;
}
@end

@implementation NormalTemplateViewController

- (void)dealloc
{
    
    [jsonOper cancelRequest];
    [_url release];
    [_tableView release];
    [_normolDataArray release];
    [_headDataArray release];
    [_ID release];
    [_refreshView release];
    [super dealloc];
}
-(id)initWithID:(NSString *)ID{
    self = [super init];
    if (self) {
        //根据传过来的ID取数据
        NSLog(@"Normal,%@",ID);
        NSLog(@"sql:%@",[SQLOperate getURLWithByID:ID fromTableName:@"MenuList"]);
        if ([SQLOperate getURLWithByID:ID fromTableName:@"MenuList"].length <10) {
            _url = @"http://c.3g.163.com/nc/article/headline/T1295501906343/0-20.html";
        }else{
            _url = [[NSString alloc]initWithString:[SQLOperate getURLWithByID:ID fromTableName:@"MenuList"]];
        }

        _ID = ID;
    }
    return self;
}


-(void)makeView{
    //表
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-44) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    //下拉刷新
    _refreshView = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight)];
    _refreshView.delegate = self;
    [_tableView addSubview:_refreshView];

}
//开始刷新
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isLoading = YES;
    [self downLoadDate];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return isLoading;
}
-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view{
    return [NSDate date];
}
#pragma mark - scorllView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshView egoRefreshScrollViewDidScroll:scrollView];
    isScrolling = YES;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshView egoRefreshScrollViewDidEndDragging:scrollView];
//    NSLog(@"结束拖拽");
//    NSLog(@"结束拖拽%d,%d",befRow,nowRow);
    //读取图片
    [self cellLoadImage];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

//    NSLog(@"结束滑动");
//    NSLog(@"结束滑动%d,%d",befRow,nowRow);
    //读取图片
    [self cellLoadImage];
}

-(void)cellLoadImage{
    if (befRow<nowRow) {
        for (int i = nowRow ; i>=nowRow-7||i<0; i--) {
            if (i<0) {
                break;
            }
            //得到cell
            NormalCell *cell = (NormalCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
            if ([cell isKindOfClass:[NotExistsImageCell class]]) {
                return;
            }
            MainPageItems *item = [_normolDataArray objectAtIndex:i];
            [cell setImageWithURLString:item.imgsrc];
        }
    }else{
        for (int i = nowRow ; i<=nowRow+7; i++) {
            if (i>= _normolDataArray.count) {
                break;
            }
            //得到cell
            NormalCell *cell = (NormalCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
            if ([cell isKindOfClass:[NotExistsImageCell class]]) {
                return;
            }
            MainPageItems *item = [_normolDataArray objectAtIndex:i];
            [cell setImageWithURLString:item.imgsrc];
        }
    }
}
#pragma mark - 表的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (_headDataArray.count>0) {
            return 1;
        }else{
            return 0;
        }
    }
    return [_normolDataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HeadCell *cell = [[[HeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"head" andWithCount:(int)[_headDataArray count]]autorelease];
        cell.delegate = self;
        [cell setContent:_headDataArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    //判断有没有图片
    MainPageItems *item = [_normolDataArray objectAtIndex:indexPath.row];
    if ([item.imgsrc isEqualToString:@""]) {
        NotExistsImageCell *notExistsImageCell = [tableView dequeueReusableCellWithIdentifier:@"NotExistsImage"];
        if (notExistsImageCell == nil) {
            notExistsImageCell = [[[NotExistsImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NotExistsImage"]autorelease];
        }
        [notExistsImageCell setContentWithItem:item];
        notExistsImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return notExistsImageCell;
    }else{
        NormalCell *normalCell = [tableView dequeueReusableCellWithIdentifier:@"normal"];
        
        if (normalCell == nil) {
            normalCell = [[[NormalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normal"]autorelease];
            [normalCell setContentWithItem:[_normolDataArray objectAtIndex:indexPath.row]];
        }
        
        if (isScrolling) {
            NSLog(@"滑动中%ld",(long)indexPath.row);
            befRow = nowRow;
            nowRow = (int)indexPath.row;
            [normalCell setContentWIthItemOnlyWordage:[_normolDataArray objectAtIndex:indexPath.row]];
        }
        normalCell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
        normalCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return normalCell;
    }
}

//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 230;
    }
    return 100;
}

//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MainPageItems *item = [_normolDataArray objectAtIndex:indexPath.row];
    NewsInformationViewController *newsInfoVC = [[NewsInformationViewController alloc]initWithDocid:item.docid];
    newsInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newsInfoVC animated:YES];
//    [self.delegate pushViewNewsInfoVC:newsInfoVC];
    [newsInfoVC release];
    //NSLog(@"docid:%@",item.docid);
}
//表代理结束
//headCell的代理
-(void)pushView:(UIViewController *)vc{
    [self.delegate pushViewNewsInfoVC:vc];
//    [vc release];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
//得到表名称
-(NSString *)getTableName{
    NSArray *tmpArray = [_url componentsSeparatedByString:@"/"];
    return [tmpArray objectAtIndex:[tmpArray count]-2];
}
//下载数据
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _normolDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    _headDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableDictionary *dic = [SQLOperate loadMainPageDataFromTableName:[self getTableName]];
    _headDataArray = [dic objectForKey:@"arrayHead"];
    _normolDataArray = [dic objectForKey:@"arrayNormal"];
    
    [self makeView];
    //下载数据
    [self downLoadDate];
}
//下载数据
-(void)downLoadDate{
    jsonOper = [[JSONFileOperate alloc]init];
    jsonOper.delegate = self;
    [jsonOper downLoadDate:_url];
    NSLog(@"url,%@",_url);
}
//下载的代理
-(void)downLoadFinsh:(NSMutableArray *)headArray andNormalArray:(NSMutableArray *)normalArray{
    //从字典中取内容
    _headDataArray = headArray;
    _normolDataArray = normalArray;
    [_tableView reloadData];
    [_refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    isLoading = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNewContentWithID:(NSString *)ID{
    self.ID = ID;
}

@end
