//
//  HeadCell.m


#import "HeadCell.h"
#import "UIImageView+WebCache.h"
@implementation HeadCell
- (void)dealloc
{
    [_scorllView release];
    [_pageControl release];
    [_titleLabel release];
    [_titleArray release];
    [_docidArray release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWithCount:(int)count
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //一共有几条新闻
        _titleArray = [[NSMutableArray alloc]initWithCapacity:0];
        _docidArray = [[NSMutableArray alloc]initWithCapacity:0];
        _imageUrlArray = [[NSMutableArray alloc]init];
        _count = count;
        [self makeView];
    }
    return self;
}
-(void)makeView{

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _scorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 230)];
    //设置大小
    _scorllView.contentSize = CGSizeMake(320*_count, _scorllView.frame.size.height);
    //设置水平滑动条
    _scorllView.backgroundColor = [UIColor blackColor];
    _scorllView.showsHorizontalScrollIndicator = NO;
    _scorllView.delegate = self;
    _scorllView.pagingEnabled = YES;
    [self.contentView addSubview:_scorllView];
    [_scorllView release];
    //背景
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _scorllView.bounds.size.height-20, 320, 20)];
    view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    [self.contentView addSubview:view];
    [view release];
    
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2.5, 250, 15)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:kHEAD_CELL_TITLE_FONT_SIZE];
    [view addSubview:_titleLabel];
    [_titleLabel release];
    
    //指示器
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(260, 2.5, 50, 15)];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.numberOfPages = _count;
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(currentPageChange) forControlEvents:UIControlEventValueChanged];
    [view addSubview:_pageControl];
    [_pageControl release];
    
}

-(void)setContent:(NSArray *)array{
    int i = 0;
    NSLog(@"array count %lu",(unsigned long)array.count);
    for (MainPageItems *item in array) {
        //刚刚进去当然要放一个title上去
        if (i==0) {
            _titleLabel.text = item.title;
        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 230)];
        imageView.tag = 100+i;
        
        //把取得的地址存放到数组中去
        [_imageUrlArray addObject:item.imgsrc];
        
        //判断缓存是否存在
        if ( item.imgsrc != nil) {
            imageView.contentMode = UIViewContentModeScaleAspectFill;
        
            [imageView setImageWithURL:[NSURL URLWithString:item.imgsrc] placeholderImage:[UIImage imageNamed:@"placeHolderImage"] options:SDWebImageRetryFailed];
        }
        
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
        [imageView addGestureRecognizer:tap];
        
        //下载end
        [_scorllView addSubview:imageView];
        //需要把title存起来
        [_titleArray addObject:item.title];
        //把url存起来
        [_docidArray addObject:item.docid];
        i++;
    }
    
}
//当点击图片触发的方法
-(void)tapImage:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)[tap view];
    
    NSLog(@"%@",[_docidArray objectAtIndex:imageView.tag-100]);
    NewsInformationViewController *newsInfoVC = [[NewsInformationViewController alloc]initWithDocid:[_docidArray objectAtIndex:imageView.tag-100]];
    [self.delegate pushView:newsInfoVC];
}

#pragma mark - scrollView的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //NSLog(@"%f",_scorllView.contentOffset.x);
    int i = scrollView.contentOffset.x/320;
    _pageControl.currentPage = i;
    _titleLabel.text = [_titleArray objectAtIndex:i];
}

//当指示器发生改变时
-(void)currentPageChange{
    //改变当前要显示的图片
    CGPoint pt = _scorllView.contentOffset;
    pt.x= _pageControl.currentPage *320;
    [_scorllView setContentOffset:pt animated:YES];
    //改变titleLable
    _titleLabel.text = [_titleArray objectAtIndex:_pageControl.currentPage];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
