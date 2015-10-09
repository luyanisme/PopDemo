//
//  SubmitBtnViewController.m
//  PopDemo
//
//  Created by 卢棪 on 10/4/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "SubmitBtnViewController.h"
#import "SubmitButton_v1.h"
#import "SubmitButton_v2.h"
#import "Pubilc.h"

@interface SubmitBtnViewController ()
{
    BOOL _isSucceed_v1;
    BOOL _isSucceed_v2;
    UIView *_backgroundView;
}
@property (nonatomic, strong) SubmitButton_v1 *submitBtn_v1;

@property (nonatomic, strong) SubmitButton_v2 *submitBtn_v2;

@end

@implementation SubmitBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self configSubmitBtn];
    
    _isSucceed_v1 = YES;
    _isSucceed_v2 = YES;
}

- (void)configSubmitBtn{
    self.submitBtn_v1 = [SubmitButton_v1 buttonWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, (SCREEN_HEIGHT/2-50)/2+20, 150, 50)];
    [self.submitBtn_v1 addTarget:self action:@selector(submitTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn_v1];
    
    [self initBackgroundView];
    
    self.submitBtn_v2 = [SubmitButton_v2 buttonWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, (_backgroundView.frame.size.height-50)/2, 150, 50)];
    [self.submitBtn_v2 addTarget:self action:@selector(submitTap:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundView addSubview:self.submitBtn_v2];
}

- (void)initBackgroundView{
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    _backgroundView.backgroundColor = [UIColor colorWithRed:0.14f green:0.14f blue:0.19f alpha:1.00f];
    [self.view addSubview:_backgroundView];
}

- (void)submitTap:(SubmitButton_v1*)sender{
    
    if ([sender isKindOfClass:[SubmitButton_v1 class]]) {
        NSLog(@"The Button_v1 has been tapped");
        if (_isSucceed_v1) {
            self.submitBtn_v1.isSucceed = YES;
            _isSucceed_v1 = NO;
        } else {
            self.submitBtn_v1.isSucceed = NO;
            _isSucceed_v1 = YES;
        }
    } else {
        NSLog(@"The Button_v2 has been tapped");
        
        double delayInSeconds = 4;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (_isSucceed_v2) {
                [self.submitBtn_v2 requestComplete:YES];
                _isSucceed_v2 = NO;
            } else {
                [self.submitBtn_v2 requestComplete:NO];
                _isSucceed_v2 = YES;
            }
        });
    }
}
@end
