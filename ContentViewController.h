//
//  ContentViewController.h

#import <UIKit/UIKit.h>

#import "NormalTemplateViewController.h"
#import "ParentsViewController.h"
@interface ContentViewController :UIViewController <NormalVCDelegate>


@property (nonatomic,copy) NSString *ID;

@property (nonatomic,retain) NormalTemplateViewController *normalVC;


-(void)setNewContentWithID:(NSString *)ID;
@end
