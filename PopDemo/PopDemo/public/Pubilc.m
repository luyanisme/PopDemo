//
//  Pubilc.m
//  PopDemo
//
//  Created by 卢棪 on 10/1/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "Pubilc.h"

@implementation Pubilc

+ (CGSize) screenSize
{
    static dispatch_once_t once;
    static CGSize size;
    dispatch_once(&once, ^{size = [UIScreen mainScreen].bounds.size;});
    return size;
}

@end
