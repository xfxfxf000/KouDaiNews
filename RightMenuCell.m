//
//  rightMenuCell.m


#import "RightMenuCell.h"

@implementation RightMenuCell

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
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kRIGHT_MENU_WIDTH, 40)];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_titleLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
