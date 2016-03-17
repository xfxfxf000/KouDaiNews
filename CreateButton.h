//
//  CreateButton.h
//  WXXNews
//
//  Created by a a a a a on 13-6-21.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateButton : NSObject

+(UIButton *)createButtonTypeCustomWithBarButton:(UIImage *)image andWithSEL:(SEL)sel andTarget:(id)name;

+(UIButton *)createCustomButton:(UIImage *)image andWithSEL:(SEL)sel andTarget:(id)name andWithFrame:(CGRect) frame;

+(UIButton *)createRoundedRectButtonWithTitle:(NSString *)title andWithSEL:(SEL)sel andTarget:(id)name andWithFrame:(CGRect)frame;
@end
