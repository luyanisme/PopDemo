//
//  MenuDeleteBtnViewController.m
//  PopDemo
//
//  Created by 卢棪 on 10/1/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "MenuDeleteBtnViewController.h"
#import "MDButton.h"

@interface MenuDeleteBtnViewController ()

@end

@implementation MenuDeleteBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self setUpNvaBarItem];
}

- (void)setUpNvaBarItem{
     MDButton *button = [MDButton button];
//    [button addTarget:self action:@selector(animateTitleLabel:) forControlEvents:UIControlEventTouchUpInside];
    button.tintColor = [UIColor customBlueColor];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
