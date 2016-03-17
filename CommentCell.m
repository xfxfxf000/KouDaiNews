//
//  CommentCell.m

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "LableSeting.h"
@implementation CommentCell


- (void)dealloc
{
    [_arrayFrame release];
    [_headImage release];
    [_contentLabel release];
    [_titleLabel release];
    [_countLabel release];
    [_lable1 release];
    [_lable2 release];
    [_lable3 release];
    [_lable4 release];
    [_lable5 release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self makeView];
    }
    return self;
}
-(void)makeView{
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
    _headImage.image = [UIImage imageNamed:@"head_img.png"];
    [self.contentView addSubview:_headImage];
    [_headImage release];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 10, 210, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:KTITLE_FONT_SIZE];
    _titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0.8 alpha:0.8];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_titleLabel release];
    
    _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 10, 45, 20)];
    _countLabel.textAlignment = NSTextAlignmentRight;
    _countLabel.font = [UIFont systemFontOfSize:KCOUNT_FONT_SIZE];
    [self.contentView addSubview:_countLabel];
    _countLabel.backgroundColor = [UIColor clearColor];
    [_countLabel release];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 35, 250, 50)];
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:KCONTENT_FONT_SIZE];
    [self.contentView addSubview:_contentLabel];
     _contentLabel.backgroundColor = [UIColor whiteColor];
    [_contentLabel release];
}
//设置内容
-(void)setContent:(NSArray *)array{
    _arrayFrame = [[NSMutableArray alloc]initWithCapacity:0];
    //帖子的总数
    int num = (int)[array count]-1;
    for (; num>=0; num--) {
        LableSeting *rect = [[LableSeting alloc]init];
        rect.x = (num-1)*2+60;
        rect.y = (num-1)*2+35;
        rect.width = 250-((num-1)*2)*2;
        //暂时为0
        rect.height = 0;
        [_arrayFrame addObject:rect];
        [rect release];
    }
    //追加贴
    //每一个内容的宽度除了，主贴
    float mainCommentY = 0;
    for (int i=0; i<array.count-1; i++) {
        //取一下宽度
        
        LableSeting *rect = [_arrayFrame objectAtIndex:i];
        
        CommentItem *tmpItem = [array objectAtIndex:i];
        CGSize size = [tmpItem.content sizeWithFont:[UIFont systemFontOfSize:kAPPEND_CONTENT_FONT_SIZE] constrainedToSize:CGSizeMake(rect.width, 1000) lineBreakMode:NSLineBreakByCharWrapping];
        contentHeight[i] = size.height;
        if (i>0) {
            LableSeting *befRect = [_arrayFrame objectAtIndex:i-1];
            rect.height = befRect.height+size.height+30;
            
        }else{
            rect.height = size.height+30;
        }
        mainCommentY = rect.height;
    }
    //追加帖创建
    [self setAppendComment:array];
    //主贴
    CommentItem *item = [array objectAtIndex:array.count-1];
    _titleLabel.text = item.from;
    _countLabel.text = item.count;
    _contentLabel.text = item.content;
    CGSize size = [item.content sizeWithFont:[UIFont systemFontOfSize:KCONTENT_FONT_SIZE] constrainedToSize:CGSizeMake(250, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    float heigth = size.height;
    _contentLabel.frame = CGRectMake(60, mainCommentY+35+5, 250, heigth);
    //头像
    //先判断链接是否为空，在缓存是否存在
    //_headImage.image = nil;
    if ([item.headImgSrc isKindOfClass:NSClassFromString(@"NSNull")]) {
        return;
    }
    [_headImage setImageWithURL:[NSURL URLWithString:item.headImgSrc] placeholderImage:[UIImage imageNamed:@"placeHolderImage"] options:SDWebImageRetryFailed];
}
//设置追加内容
-(void)setAppendComment:(NSArray *)content{
    _lable1.hidden = YES;
    _lable2.hidden = YES;
    _lable3.hidden = YES;
    _lable4.hidden = YES;
    _lable5.hidden = YES;
    for (int i=0; i<content.count-1; i++) {
        CommentItem *item = [content objectAtIndex:i];
        LableSeting *rect = [_arrayFrame objectAtIndex:i];
        if (rect.height>0) {
            if (i == 0) {
                _lable1 = [[AppendCommentLabel alloc]initWithFrame:CGRectMake(rect.x, rect.y, rect.width, rect.height) andContentHeight:contentHeight[0]];
                _lable1.titleLabel.text = item.from;
                _lable1.contentLabel.text = item.content;
                [self.contentView insertSubview:_lable1 atIndex:0];
            }else if (i == 1){
                
                _lable2 = [[AppendCommentLabel alloc]initWithFrame:CGRectMake(rect.x, rect.y, rect.width, rect.height) andContentHeight:contentHeight[i]];
                _lable2.titleLabel.text = item.from;
                _lable2.contentLabel.text = item.content;
                [self.contentView insertSubview:_lable2 atIndex:0];
            }else if(i==2){
                
                _lable3 = [[AppendCommentLabel alloc]initWithFrame:CGRectMake(rect.x, rect.y, rect.width, rect.height) andContentHeight:contentHeight[i]];
                _lable3.titleLabel.text = item.from;
                _lable3.contentLabel.text = item.content;
                [self.contentView insertSubview:_lable3 atIndex:0];
            }else if(i == 3){
                _lable4 = [[AppendCommentLabel alloc]initWithFrame:CGRectMake(rect.x, rect.y, rect.width, rect.height) andContentHeight:contentHeight[i]];
                _lable4.titleLabel.text = item.from;
                _lable4.contentLabel.text = item.content;
                [self.contentView insertSubview:_lable4 atIndex:0];
            }else if (i==4){
                _lable5 = [[AppendCommentLabel alloc]initWithFrame:CGRectMake(rect.x, rect.y, rect.width, rect.height) andContentHeight:contentHeight[i]];
                _lable5.titleLabel.text = item.from;
                _lable5.contentLabel.text = item.content;
                [self.contentView insertSubview:_lable5 atIndex:0];
            }
        }else{
            break;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
