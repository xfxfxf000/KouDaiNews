//
//  PlayerView.m
//  WXXNews
//
//  Created by WangXiaoXiang on 13-7-1.
//  Copyright (c) 2013年 WangXiaoXiang. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+(Class)layerClass{
    return [AVPlayerLayer class];
}

-(void)setPlayer:(AVPlayer *)player{
    AVPlayerLayer *avPlayerLayer = (AVPlayerLayer *)self.layer;
    [avPlayerLayer setPlayer:player];
}


@end
