//
//  SubmitButton_v2.m
//  PopDemo
//
//  Created by 卢棪 on 10/8/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "SubmitButton_v2.h"

@implementation SubmitButton_v2

+ (id)buttonWithFrame:(CGRect)frame{
    return [[self alloc] initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews{

}
@end
