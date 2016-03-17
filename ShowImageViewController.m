
#import "ShowImageViewController.h"

@interface ShowImageViewController ()

@end

@implementation ShowImageViewController
- (void)dealloc
{
    [_image release];
    [_imageView release];
    [super dealloc];
}

-(void)viewDidUnload{
    _image = nil;
    _imageView = nil;
}
-(id)initWithImage:(UIImage *)image{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}
-(void)makeView{
    self.view.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-44);
//    背景虚幻
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = CGRectMake(5, 100, 310, 250);
    _imageView.image = _image;
    [self.view addSubview:_imageView];
    self.view.contentMode = UIViewContentModeScaleAspectFit;
    [self showImage];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self makeView];
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showImage) userInfo:nil repeats:NO];
//    [NSTimer timerWithTimeInterval:0.75 target:self selector:@selector(showImage) userInfo:nil repeats:YES];
}
-(void)showImage{
    //NSLog(@"123");
    //产生层动画
//    CATransition* anim = [CATransition animation];
//    //设置动画时间
//    anim.duration = 1.5 ;
//    
//    //设置动画类型
//    anim.type = @"suckEffect" ;
//    
//    //设置子类型,从左侧推入
//    anim.subtype = kCATransitionFromTop ;
//    
//    [_imageView.layer addAnimation:anim forKey:nil];
//    [UIView beginAnimations:@"1" context:nil];
//    [UIView setAnimationDuration:0.25];
////    _imageView.frame = CGRectMake(0, 100, 320, 200);
//    [UIView commitAnimations];
    
    //imageView 添加收拾
    _imageView.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGesture:)];
    pinchGes.delegate = self;
    
//    UIRotationGestureRecognizer *rotationGes = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGesture:)];
//    rotationGes.delegate = self;
//    [_imageView addGestureRecognizer:rotationGes];
    [_imageView addGestureRecognizer:pinchGes];
    
}
//多个手势同时响应
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
-(void)pinchGesture:(UIPinchGestureRecognizer *)pinchGes{
    _imageView.transform = CGAffineTransformScale(_imageView.transform, pinchGes.scale, pinchGes.scale);
    pinchGes.scale = 1.0;
}
-(void)rotationGesture:(UIRotationGestureRecognizer *)rotationGes{
    //在开始触屏和手指移动过程中进行旋转
    if (rotationGes.state == UIGestureRecognizerStateBegan
        || rotationGes.state == UIGestureRecognizerStateChanged)
    {
        // 计算旋转矩阵变换
        _imageView.transform = CGAffineTransformRotate(_imageView.transform, rotationGes.rotation) ;
        rotationGes.rotation = 0 ;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.delegate touchesBegan:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
