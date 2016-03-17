//
//  MenuViewController.m


#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)dealloc
{
    [_tableView release];
    [_keepOutView release];
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {

        //_tableView.bounces = NO;
        self.view.backgroundColor = [UIColor clearColor];
        //_tableView.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _keepOutView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, self.view.bounds.size.height)];
    _keepOutView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self.view addSubview:_keepOutView];
    [_keepOutView release];
	// Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(pushView)]) {
        [self.delegate pushView];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
