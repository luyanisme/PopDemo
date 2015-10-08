//
//  RollingLabel.h
//  PopDemo
//
//  Created by 卢棪 on 10/4/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RollingLabel : UIScrollView

@property (nonatomic, strong) NSString *contentText;//放置内容的label

- (id)initWithFrame:(CGRect)frame font:(UIFont *)font;

@end
