//
//  ReplayView.m
//  WXXNews
//
//  Created by WangXiaoXiang on 13-7-2.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "ReplyView.h"

@implementation ReplyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self makeView];
    }
    return self;
}

-(void)makeView{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 2, 250, 28)];
    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor  = [UIColor redColor];
    label.text = @"评论服务器回出现延迟情况，在下已经尝试很多次了！";
    label.font = [UIFont systemFontOfSize:11];
    label.numberOfLines = 0;
    
    [self addSubview:label];
    //关闭按钮
    _closeButton = [CreateButton createCustomButton:[UIImage imageNamed:@"delete.png"] andWithSEL:@selector(deleteButtonClicked) andTarget:self andWithFrame:CGRectMake(-2, -2, 30, 30)];
    [self addSubview:_closeButton];
    //提交按钮
    _confirmButton = [CreateButton createCustomButton:[UIImage imageNamed:@"submit.png"] andWithSEL:@selector(submitButtonClicked) andTarget:self andWithFrame:CGRectMake(kSELF_WIDTH-28, -2, 30, 30)];
    [self addSubview:_confirmButton];
    //文本
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(30, 30, kSELF_WIDTH-60, kSELF_HEIGHT-30-10)];
    [_textView becomeFirstResponder];
    [_textView setExclusiveTouch:YES];
    _textView.allowsEditingTextAttributes = YES;
    
    _textView.font = [UIFont systemFontOfSize:13];
//    _textView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _textView.delegate = self;
    
    
    [self addSubview:_textView];
    [_textView release];
    
}

//-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    if (textView.text.length > 0 ) {
//        _confirmButton.enabled = YES;
//    }
//    return YES;
//}
//将要开始变编辑的时候
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (textView.text.length == 0 || [textView.text isEqualToString:@" "]) {
        _confirmButton.enabled = NO;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0 || [textView.text isEqualToString:@" "]) {
        _confirmButton.enabled = NO;
    }else if(textView.text.length > 0 ) {
        _confirmButton.enabled = YES;
    }
}
-(void)deleteButtonClicked{
    if ([self.delegate respondsToSelector:@selector(dismissView:)]) {
        [self.delegate dismissView:self];
    }
    NSLog(@"delete");
}
-(void)submitButtonClicked{
    if ([self.delegate respondsToSelector:@selector(submitContent:)]) {
        [self.delegate submitContent:_textView.text];
    }
    NSLog(@"submit");
}
- (void)dealloc {
    [_closeButton release];
    [_confirmButton release];
    [_textView release];
    [super dealloc];
}
@end
