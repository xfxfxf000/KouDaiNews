//
//  ReplayView.h
//  WXXNews
//
//  Created by WangXiaoXiang on 13-7-2.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateButton.h"
#define kSELF_WIDTH  self.bounds.size.width
#define kSELF_HEIGHT  self.bounds.size.height

@class ReplyView;
@protocol replyViewDelegate <NSObject>

-(void)dismissView:(ReplyView *)replyView;
-(void)submitContent:(NSString *)content;

@end
@interface ReplyView : UIView<UITextViewDelegate>
@property (retain,nonatomic) UITextView *textView;
@property (retain,nonatomic) UIButton *closeButton;
@property (retain,nonatomic) UIButton  *confirmButton;

@property (assign,nonatomic) id<replyViewDelegate> delegate;
@end
