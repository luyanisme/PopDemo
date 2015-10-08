//
//  SubmitBtnViewController.m
//  PopDemo
//
//  Created by 卢棪 on 10/4/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "SubmitBtnViewController.h"
#import "SubmitButton_v1.h"
#import "Pubilc.h"

@interface SubmitBtnViewController ()
{
    BOOL _isSucceed;
}
@property (nonatomic, strong) SubmitButton_v1 *submitBtn;

@end

@implementation SubmitBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self configSubmitBtn];
    _isSucceed = YES;
}

- (void)configSubmitBtn{
    self.submitBtn = [SubmitButton_v1 buttonWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, (SCREEN_HEIGHT-50)/2, 150, 50)];
    self.submitBtn.backgroundColor = [UIColor whiteColor];
    [self.submitBtn addTarget:self action:@selector(submitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn];
}

- (void)submitTap:(SubmitButton_v1*)sender{
    NSLog(@"The Button has been tapped");
    if (_isSucceed) {
        self.submitBtn.isSucceed = YES;
        _isSucceed = NO;
    } else {
        self.submitBtn.isSucceed = NO;
        _isSucceed = YES;
    }
}
@end
