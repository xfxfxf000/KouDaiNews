//
//  replyViewController.m


#import "ReplyViewController.h"

@interface ReplyViewController ()

@end

@implementation ReplyViewController

- (void)dealloc
{
    [_replyView release];
    [_docid release];
    [_replyBoard release];
    [_url release];
    [super dealloc];
}
-(id)initWIthDocid:(NSString *)docid andWithReplyBoard:(NSString *)replyBoard{
    self = [super init];
    if (self) {
        _replyBoard = replyBoard;
        _docid = docid;
        _url = @"http://comment.api.163.com/api/jsonp/post/insert";
    }
    return self;
}
-(void)makeView{
    _replyView = [[ReplyView alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height-44-150, 310, 150)];
    
    _replyView.delegate = self;
    [self.view addSubview:_replyView];
    [_replyView release];
}
//评论窗口的代理
-(void)dismissView:(ReplyView *)replyView{
    if ([self.delegate respondsToSelector:@selector(dismissViewController:)]) {
        [self.delegate dismissViewController:self];
    }
}
//提交评论
-(void)submitContent:(NSString *)content{
    
    NSLog(@"count:%@",content);
    if ([self.delegate respondsToSelector:@selector(dismissViewController:)]) {
        [self.delegate dismissViewController:self];
    }
    NSLog(@"url,%@",_url);
    ReplyCententUpload *contentUpload = [[ReplyCententUpload alloc]initWithURLStr:_url andWithDocid:_docid andWithRelyBoard:_replyBoard];
    [contentUpload uploadContent:content];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(dismissViewController:)]) {
        [self.delegate dismissViewController:self];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.frame = CGRectMake(0, 0, 320, 460-44);
    //键盘将要出现
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	// Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self makeView];
}
//键盘将要出现
-(void)keyboardWillShow:(NSNotification *)noti{
    CGSize size = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView beginAnimations:@"ttt" context:nil];
    [UIView setAnimationDuration:0.25];
    _replyView.frame = CGRectMake(5, self.view.bounds.size.height-64-150-size.height, 310, 150);
    [UIView commitAnimations];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
