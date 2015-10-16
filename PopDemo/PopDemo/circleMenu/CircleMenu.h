//
//  CircleMenu.h
//  PopDemo
//
//  Created by 卢棪 on 10/10/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CircleMenuDelegate <NSObject>

@required
- (void)functionButtonTapped:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, ButtonDirection)
{
    DIRECTIONTOP    = 10000,
    DIRECTIONRIGHT  = 10001,
    DIRECTIONBOTTOM = 10002,
    DIRECTIONLEFT   = 10003,
};

@interface CircleMenu : UIControl

+ (id)menuWithFrame:(CGRect)frame;
- (void)showByController:(UIViewController*)controller;//展示menu

@property (nonatomic, strong) NSArray *functionButtonColors;//按钮颜色
@property (retain, nonatomic) id <CircleMenuDelegate> delegate;

@end
