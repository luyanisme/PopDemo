//
//  ShakeBtnViewController.m
//  PopDemo
//
//  Created by 卢棪 on 9/30/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "ShakeBtnViewController.h"
#import "ShakeButton.h"

@interface ShakeBtnViewController ()

@property (nonatomic, strong) ShakeButton *popBtn;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation ShakeBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.popBtn = [[ShakeButton alloc] init];
    self.popBtn.frame = CGRectMake((self.view.bounds.size.width-80)/2, (self.view.bounds.size.height-40)/2, 80, 40);
    self.popBtn.backgroundColor = [UIColor customBlueColor];
    
    [self.popBtn setTitle:@"Login in" forState:UIControlStateNormal];
    [self.popBtn addTarget:self action:@selector(tapPop:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.popBtn];
    
}

- (void)addActivityIndicatorView{
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicatorView];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)tapPop:(ShakeButton *)sender{
    [self addActivityIndicatorView];
    self.popBtn.userInteractionEnabled = NO;
    [self.activityIndicatorView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * 1000000000)), dispatch_get_main_queue(), ^{
        [self shakeBtn];
    });
}

/*这些方法应该放在最后*/
POPSpringAnimation *shake;
- (void)shakeBtn{
    if (!shake) {
        shake = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    }
    shake.velocity = @(3000);
    shake.springBounciness = 20;
    [shake setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.popBtn.userInteractionEnabled = YES;
        [self.activityIndicatorView stopAnimating];
        UIImageView *failedView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        failedView.image = [UIImage imageNamed:@"failed.png"];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:failedView];
    }];
    [self.popBtn.layer pop_addAnimation:shake forKey:@"shake"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
