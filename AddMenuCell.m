//
//  AddMenuCell.m


#import "AddMenuCell.h"

@implementation AddMenuCell


-(void)dealloc{
    [_titleLable release];
    [_addButton release];
    [_ID release];
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
    //选中状态
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"add_menu_cell_background"]]; //无效的png
    //标题栏
    _titleLable = [[UILabel alloc]initWithFrame:self.contentView.frame ];
    _titleLable.textAlignment = NSTextAlignmentLeft;
    _titleLable.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_titleLable];
    
    _addButton = [CreateButton createCustomButton:[UIImage imageNamed:@"add_button3"] andWithSEL:@selector(addButtonClicked) andTarget:self andWithFrame:CGRectMake(self.contentView.frame.size.width-35, 5, 30, 30)];
    [self.contentView addSubview:_addButton];
    

}
-(void)setViewHidden{
    
}
-(void)addButtonClicked{
    //button 变成不可点击
    _addButton.enabled = NO;
    [_addButton setImage:[UIImage imageNamed:@"add_button3_checkmark"] forState:UIControlStateNormal];
    SQLOperate *oper = [[SQLOperate alloc]init];
    [oper updateToMenuListWithID:self.ID andWithState:@"1"];
    //NSLog(@"%@",self.ID);
}
//设置按钮状态
-(void)setStateToButton:(BOOL)yesOrNO{
    _addButton.enabled = yesOrNO;
    if (yesOrNO) {
        [_addButton setImage:[UIImage imageNamed:@"add_button3"] forState:UIControlStateNormal];
    }else{
        [_addButton setImage:[UIImage imageNamed:@"add_button3_checkmark"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
