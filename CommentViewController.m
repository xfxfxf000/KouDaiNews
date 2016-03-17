
//
//评论API http://comment.api.163.com/api/json/post/list/new/normal/news3_bbs/92E6OBNQ00014AED/desc/0/10/10/2/2
//
//热门评论 http://comment.api.163.com/api/json/post/list/new/hot/news3_bbs/92E6OBNQ00014AED/0/10/10/2/2

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)dealloc
{
    [_urlHot release];
    [_urlNormal release];
    [_tableView release];
    [_hotCommentArray release];
    [_normalCommentArray release];
    [_commentOper release];
    [_replyBoard release];
    [_docid release];
    [_replyVC release];
    [super dealloc];
}
-(id)initWithDocid:(NSString *)docid andWithReplyBoard:(NSString *)replyBoard{
    self = [super init];
    if (self) {
        //拼接url
        num = 10;
        _docid = docid;
        _replyBoard = replyBoard;
        
        _urlNormal = [[NSString alloc]initWithFormat:@"http://comment.api.163.com/api/json/post/list/new/normal/%@/%@/desc/0/%d/10/2/2",replyBoard,docid,num];

        
        _urlHot = [[NSString alloc]initWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/%d/10/2/2",replyBoard,docid,num];
        

        _hotCommentArray = [[NSMutableArray alloc]initWithCapacity:0];
        _normalCommentArray = [[NSMutableArray alloc]initWithCapacity:0];
        befPoint = CGPointMake(0, 0);
    }
    return self;
}
//创建视图
-(void)makeView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-88-10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //回复
    self.navigationController.toolbarHidden = YES;
    UIImageView *toolBar= [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-88, 320, 44)];
    toolBar.image = [UIImage imageNamed:@"toolbar_background.png"];
    [self.view addSubview:toolBar];
    toolBar.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reply:)];
    [toolBar addGestureRecognizer:tap];
    
    //刷新按钮
    UIButton *right = [CreateButton createButtonTypeCustomWithBarButton:[UIImage imageNamed:@"ic_title_refresh"] andWithSEL:@selector(refreshButtonClicked) andTarget:self];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0,35,27);
    [button1 setBackgroundImage:[UIImage imageNamed:@"ic_title_back.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.backBarButtonItem = nil;
    [leftItem release];
    
}

//点击左侧返回按钮回到上级界面
-(void)backHome{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshButtonClicked{
    NSLog(@"刷新");
    [self downLoadContent];
}
//点击评论
-(void)reply:(UITapGestureRecognizer *)tap{
    if (_replyVC == nil) {
        _replyVC = [[ReplyViewController alloc]initWIthDocid:_docid andWithReplyBoard:_replyBoard];
        _replyVC.delegate = self;
        [self.view insertSubview:_replyVC.view atIndex:self.view.subviews.count];

    }
}
-(void)dismissViewController:(ReplyViewController *)replyVC{
    [_replyVC.view removeFromSuperview];
    _replyVC = nil;
}
//下载数据
-(void)downLoadContent{
    _commentOper = [[CommentOperate alloc]init];
    _commentOper.delegate = self;
    [_commentOper downLoadCommentWithURL:_urlHot andWithAnalysis:kHot];
    [_commentOper downLoadCommentWithURL:_urlNormal andWithAnalysis:kNormal];
}
-(void)downLoadFinish:(NSMutableArray *)mArray andType:(analysisType)type{
    if (type == kNormal) {
        _normalCommentArray = mArray;
        NSLog(@"_normalArray.count:%lu",(unsigned long)_normalCommentArray.count);
        [_tableView reloadData];
    }else if (type == kHot){
        _hotCommentArray = mArray;
        //NSLog(@"_hotCommentArray:%d",_hotCommentArray.count);
        //NSLog(@"_hotCommentArray:%@",_hotCommentArray);
        [_tableView reloadData];
    }
    _tableView.contentOffset = befPoint;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self downLoadContent];
    [self makeView];
    //下载数据
	// Do any additional setup after loading the view.
}

#pragma mark - 表的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [_hotCommentArray count];
    }else if (section == 1){
        return [_normalCommentArray count]+1;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //热门评论
    if (indexPath.section == 0) {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hot"];
        if (cell == nil) {
            cell = [[[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hot"]autorelease];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setContent:[_hotCommentArray objectAtIndex:indexPath.row]];
        return cell;
    }
    //普通评论
    if (indexPath.section == 1) {
        if (indexPath.row>=_normalCommentArray.count) {
            UITableViewCell *cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"end"]autorelease];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.text = @"加载更多";
            return cell;
        }
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hot"];
        if (cell == nil) {
            cell = [[[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hot"]autorelease];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setContent:[_normalCommentArray objectAtIndex:indexPath.row]];
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //热门评论
    if (indexPath.section == 0) {
        float height = 35;
        NSArray *tmpArray = [_hotCommentArray objectAtIndex:indexPath.row];
        for (CommentItem *item in tmpArray) {
            CGSize size = [item.content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(250, 1000) lineBreakMode:NSLineBreakByCharWrapping];
            height = height + (size.height +30);
        }
        return height;
    }else if (indexPath.section == 1){
        if (indexPath.row>=_normalCommentArray.count) {
            return 44;
        }
        float height = 35;
        NSArray *tmpArray = [_normalCommentArray objectAtIndex:indexPath.row];
        for (CommentItem *item in tmpArray) {
            CGSize size = [item.content sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(250, 1000) lineBreakMode:NSLineBreakByCharWrapping];
            height = height + (size.height +30);
        }
        return height;
    }
    return 0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"热门评论!";
    }else if (section == 1){
        return @"最新评论";
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row >=_normalCommentArray.count) {
            //点击更多
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.text = @"加载中...";
            num+=10;
            _urlNormal =  [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/normal/%@/%@/desc/0/%d/10/2/2",_replyBoard,_docid,num];
            //原来数组中的内容要删除
//            [_hotCommentArray removeAllObjects];
//            [_normalCommentArray removeAllObjects];
            befPoint = _tableView.contentOffset;
            [self downLoadContent];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
