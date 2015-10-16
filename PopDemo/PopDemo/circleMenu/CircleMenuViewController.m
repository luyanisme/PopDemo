//
//  CircleMenuViewController.m
//  PopDemo
//
//  Created by 卢棪 on 10/10/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "CircleMenuViewController.h"
#import "CircleMenu.h"
#import "Pubilc.h"

@interface CircleMenuViewController ()<CircleMenuDelegate>

@property CircleMenu *circleMenu;

@end

@implementation CircleMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.13f green:0.13f blue:0.13f alpha:1.00f];
    self.navigationController.navigationBar.translucent = YES;
    [self initSubviews];
}

- (void)initSubviews{
    self.circleMenu = [CircleMenu menuWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, (SCREEN_HEIGHT-60)/2, 60, 60)];
    self.circleMenu.backgroundColor = [UIColor colorWithRed:0.91f green:0.36f blue:0.27f alpha:1.00f];
    self.circleMenu.delegate = self;
    self.circleMenu.functionButtonColors = @[[UIColor colorWithRed:0.90f green:0.37f blue:0.29f alpha:1.00f],
                                             [UIColor colorWithRed:0.11f green:0.65f blue:0.80f alpha:1.00f],
                                             [UIColor colorWithRed:0.39f green:0.74f blue:0.20f alpha:1.00f],
                                             [UIColor colorWithRed:0.93f green:0.71f blue:0.33f alpha:1.00f]];
    [self.circleMenu showByController:self];
}

#pragma mark - Delegate of CircleMenu
- (void)functionButtonTapped:(NSInteger)index{
    NSLog(@"%d", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
