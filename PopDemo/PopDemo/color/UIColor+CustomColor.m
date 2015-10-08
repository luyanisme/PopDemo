//
//  UIColor+CustomColor.m
//  PopDemo
//
//  Created by 卢棪 on 9/30/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+ (UIColor *)customGrayColor{
    return [self colorWithRed:84 green:84 blue:84];
}

+ (UIColor *)customBlueColor{
    return [self colorWithRed:52 green:152 blue:219];
}

+ (UIColor *)customAlphaBlueColor{
    return [self colorWithRed:52 green:152 blue:219];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    return [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:1.0];
}

@end
