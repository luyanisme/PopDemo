//
//  Pubilc.h
//  PopDemo
//
//  Created by 卢棪 on 10/1/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCREEN_WIDTH ([Pubilc screenSize].width)
#define SCREEN_HEIGHT ([Pubilc screenSize].height)
#define NAVIBAR_HEIGHT (64.0f)

@interface Pubilc : NSObject

// 屏幕尺寸获取
+ (CGSize) screenSize;

@end
