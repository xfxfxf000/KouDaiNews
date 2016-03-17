
//

#import "NewsInformationViewController.h"
@interface NewsInformationViewController ()
{
 MPMoviePlayerViewController *_playController;
}
@end

@implementation NewsInformationViewController

- (void)dealloc
{
    [_docid release];
    [_tableView release];
    [_dataArray release];
    [_showImageVC release];
    [_newsInfo release];
    [super dealloc];
}

-(void)viewDidUnload{
    _docid = nil;
    _tableView = nil;
    _dataArray = nil;
    _showImageVC = nil;
    _newsInfo  = nil;
}
- (id)initWithDocid:(NSString *)docid
{
    self = [super init];
    if (self) {
        _docid = docid;
        
    }
    return self;
}
//点击评论
-(void)showComment{

    CommentViewController *commentVC = [[CommentViewController alloc]initWithDocid:_docid andWithReplyBoard:_newsInfo.replyBoard];
    commentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentVC animated:YES];
}
-(void)makeView{
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,10, 320, self.view.bounds.size.height-44) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
}
#pragma mark - 表的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return [_newsInfo.contentArray count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TitleCell *cell = [[[TitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"]autorelease];
        cell.titleLabel.text = _newsInfo.title;
        cell.timeLabel.text = _newsInfo.ptime;
        cell.sourcesLabel.text = _newsInfo.source;
        return cell;
    }
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"con"];
    if(cell == nil){
        cell = [[[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"con"]autorelease];
    }
    cell.delegate = self;
    NSDictionary *dic = [_newsInfo.contentArray objectAtIndex:indexPath.row];
    NSString *key = [[dic allKeys] objectAtIndex:0];
   // NSLog(@"key:%@",key);
    //只是一张图片
    if([key isEqualToString:@"url"]){
        cell.contentLabel.hidden = YES;
        cell.mImageView.hidden = NO;
        cell.playerView.hidden = YES;
        [cell setImageWithURL:[dic objectForKey:key]];
    //是视视频
    }else if([key isEqualToString:@"video"]){
        cell.contentLabel.hidden = YES;
        cell.mImageView.hidden = YES;
        cell.playerView.hidden = NO;
        [cell setPlayerInfo:[dic objectForKey:key]];
    //是文本
    }else if([key isEqualToString:@"text"]){
        cell.contentLabel.hidden = NO;
        cell.mImageView.hidden = YES;
        cell.playerView.hidden = YES;
        NSString *str = [dic objectForKey:key];
        CGSize conSize = [str sizeWithFont:[UIFont systemFontOfSize:kCONTENT_FONT_SIZE] constrainedToSize:CGSizeMake(310, 10000) lineBreakMode:NSLineBreakByCharWrapping];
        cell.contentLabel.frame = CGRectMake(5, 5, 310, conSize.height);
        cell.contentLabel.text = str;
    }
    cell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    return cell;
}
//contentCell的代理方法
-(void)selectedImage:(UIImage *)image andType:(OpenType)type  otherURL:(NSString *)url{
    if (type == Normal) {
        _showImageVC = [[ShowImageViewController alloc]initWithImage:image];
        _showImageVC.delegate = self;
        [self.view insertSubview:_showImageVC.view atIndex:[self.view.subviews count]];
    }else if(type == Video){
//        _showVideoVC = [[ShowVideoViewController alloc]initWithVideoURL:url];
//        _showVideoVC.delegate = self;
//        [self.view insertSubview:_showVideoVC.view atIndex:[self.view.subviews count]];
        [self playVideoWithPath:url];
    }
}


//播放视频
-(void)playVideoWithPath:(NSString *)path{
    if(path.length == 0){
        NSLog(@"没有找到路径");
        return;
    }
    NSLog(@"url  %@",path);
    
    //能够播放本地的视频和远程的视频，也能播放音频
    NSURL *url;
    NSRange range = [path rangeOfString:@"http://"];
    
    if(range.location!= NSNotFound){
        //      远程
        url = [NSURL URLWithString:path];
    }else{
        //    本地
        url = [NSURL fileURLWithPath:path];
    }
    
    if(!_playController){
        
        //初始化播放器
        _playController = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
        
        //        设置播放类型。
        [_playController.moviePlayer setMovieSourceType:MPMovieSourceTypeFile];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_playController.view];
        [window.rootViewController addChildViewController:_playController];
        
        
        //        [self presentViewController:_playController animated:YES completion:^{
        //        }];
        
        //        通知中心。单例。可以理解为一个广播站，任何对象可以通过通知中心发送一条广播。
        //        任何对象都可以在通知中心注册成为某条广播的观察者，只要有其他对象通过通知中心，发送此条广播，观察者就能接收到，并触发后序的selector方法。
        
        //        加入队列
        [_playController.moviePlayer prepareToPlay];
        //        开始播放
        [_playController.moviePlayer play];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playBack) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        
    }
}

//通知中心出发的方法
-(void)playBack{
    
    [_playController.view removeFromSuperview];
    [_playController removeFromParentViewController];
    
    if(_playController){
        [_playController.moviePlayer stop];
        _playController = nil;
        [_playController release];
    }
}



//showImage的代理方法
-(void)touchesBegan:(ShowImageViewController *)showImageVC{
    [_showImageVC.view removeFromSuperview];
    _showImageVC =nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }else{
        NSDictionary *dic = [_newsInfo.contentArray objectAtIndex:indexPath.row];
        NSString *key = [[dic allKeys] objectAtIndex:0];
//        NSLog(@"key:%@",key);
        if([key isEqualToString:@"url"]){
            return 150;
        }else if([key isEqualToString:@"video"]){
            return 150;
        
        }else if([key isEqualToString:@"text"]){
            NSString *str = [dic objectForKey:key];
            CGSize conSize = [str sizeWithFont:[UIFont systemFontOfSize:kCONTENT_FONT_SIZE] constrainedToSize:CGSizeMake(310, 10000) lineBreakMode:NSLineBreakByCharWrapping];
            return conSize.height +10;
            
        }
    }
    return 40;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NewsInfoOperate *infoOper = [[NewsInfoOperate alloc]initWithDocid:_docid];
    infoOper.delegate = self;
    [infoOper downLoad];
    [self makeView];

}
-(void)downLoadFinish:(NewsInfo *)info{
    //设置表上的内容
    _newsInfo = info;

    [_tableView reloadData];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(280, 0,100,40);
    [button setFont:[UIFont systemFontOfSize:14.0f]];
    [button setTitle:[NSString stringWithFormat:@"%@条评论",info.replyCount] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showComment) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0,35,27);
    [button1 setImage:[UIImage imageNamed:@"ic_title_back.png"] forState:UIControlStateNormal];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
