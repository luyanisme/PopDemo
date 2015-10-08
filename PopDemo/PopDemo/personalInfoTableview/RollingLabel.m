//
//  RollingLabel.m
//  PopDemo
//
//  Created by 卢棪 on 10/4/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "RollingLabel.h"

@interface RollingLabel ()
{
    UIFont  *_font;
    UILabel *_contentLabel;//放置内容的label
    CGFloat _textHeight;
    BOOL    _isEnd;//是否已到头
}
@end

@implementation RollingLabel

@synthesize contentText = _contentText;

- (id)initWithFrame:(CGRect)frame font:(UIFont *)font{
    self = [super initWithFrame:frame];
    if (self) {
        _font = font;
        _textHeight = frame.size.height;
        [self configScrollview];
        [self configLabel];
        _isEnd = NO;
    }
    return self;
}

- (void)configScrollview{
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    /*边框模糊效果*/
    {
        float fadeLength = 5.0f;
        CAGradientLayer* gradientMask = [CAGradientLayer layer];
        gradientMask.bounds = self.layer.bounds;
        gradientMask.position = CGPointMake([self bounds].size.width / 2, [self bounds].size.height / 2);
        NSObject *transparent = (NSObject*) [[UIColor clearColor] CGColor];
        NSObject *opaque = (NSObject*) [[UIColor blackColor] CGColor];
        gradientMask.startPoint = CGPointMake(0.0, CGRectGetMidY(self.frame));
        gradientMask.endPoint = CGPointMake(1.0, CGRectGetMidY(self.frame));
        float fadePoint = (float)fadeLength/self.frame.size.width;
        [gradientMask setColors: [NSArray arrayWithObjects: transparent, opaque, opaque, transparent, nil]];
        [gradientMask setLocations: [NSArray arrayWithObjects:
                                     [NSNumber numberWithFloat: 0.0],
                                     [NSNumber numberWithFloat: fadePoint],
                                     [NSNumber numberWithFloat: 1 - fadePoint],
                                     [NSNumber numberWithFloat: 1.0],
                                     nil]];
        self.layer.mask = gradientMask;
    }
    
}

- (void)configLabel{
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.font = _font;
}

- (void)configContent{
    self.contentSize = _contentLabel.frame.size;
}

- (void)setContentText:(NSString *)contentText{
     CGSize textSize = [contentText sizeWithFont:_font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    _contentLabel.text = contentText;
    _contentLabel.frame = CGRectMake(2, 0, textSize.width+3, _textHeight);
    [self addSubview:_contentLabel];
    [self configContent];
    [self configAnimation];
}

- (void)configAnimation{
    [UIView animateWithDuration:3.5 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:0 animations:^{
        if (!_isEnd) {
            _contentLabel.transform = CGAffineTransformMakeTranslation(-(_contentLabel.frame.size.width-self.frame.size.width),0);
            _isEnd = YES;
        } else {
            _contentLabel.transform = CGAffineTransformIdentity;
            _isEnd = NO;
        }
        
    } completion:^(BOOL finished) {
        [self configAnimation];
    }];
}
@end
