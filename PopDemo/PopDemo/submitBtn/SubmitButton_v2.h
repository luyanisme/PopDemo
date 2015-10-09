//
//  SubmitButton_v2.h
//  PopDemo
//
//  Created by 卢棪 on 10/8/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitButton_v2 : UIControl

+ (id)buttonWithFrame:(CGRect)frame;
- (void)requestComplete:(BOOL)isSuccees;//请求数据结束
@end
