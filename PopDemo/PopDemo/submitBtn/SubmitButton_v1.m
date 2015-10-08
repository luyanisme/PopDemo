//
//  SubmitButton_v1.m
//  PopDemo
//
//  Created by 卢棪 on 10/4/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "SubmitButton_v1.h"

@interface SubmitButton_v1 ()
{
    CGRect  _orignalFrame;//原先的frame
    NSTimer *_timer;//定时器
    CGFloat _process;//进度
    
    CAShapeLayer *_correctMarked_1;//画钩
    CAShapeLayer *_correctMarked_2;//画钩
}
@property (nonatomic, strong) UILabel      *titleName;//文字内容
@property (nonatomic, strong) CAShapeLayer *circleLayer;//画圆环
@property (nonatomic, strong) CAShapeLayer *processLayer;//画进度环

@end

@implementation SubmitButton_v1

@synthesize isSucceed = _isSucceed;

+ (id)buttonWithFrame:(CGRect)frame{
    return [[self alloc] initWithFrame:frame];
};

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.borderWidth = 2.0f;
        self.layer.borderColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f].CGColor;
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews{
    [self addTarget:self
             action:@selector(touchUpInsideHandler:)
   forControlEvents:UIControlEventTouchUpInside];
    [self initLabel];
}

- (void)initLabel{
    self.titleName = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/4, self.frame.size.height/3, self.frame.size.width/2, self.frame.size.height/3)];
    self.titleName.font = [UIFont fontWithName:@"Avenir" size:20.0f];
    self.titleName.textAlignment = NSTextAlignmentCenter;
    self.titleName.text = @"Submit";
    self.titleName.textColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f];
    [self addSubview:self.titleName];
}

- (void)touchUpInsideHandler:(SubmitButton_v1 *)sender
{
    _process = 0;
    
    [self removeAllAnimations];
    _orignalFrame = self.frame;
    self.enabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.layer.backgroundColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f].CGColor;
        self.titleName.textColor = [UIColor whiteColor];
    } completion:^(BOOL finished) {
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
        scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
        scaleAnimation.springBounciness = 18.0f;
        [self.titleName.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
        [scaleAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                self.titleName.hidden = YES;
                self.layer.borderColor = [UIColor colorWithRed:0.73f green:0.73f blue:0.73f alpha:1.00f].CGColor;
                self.layer.backgroundColor = [UIColor whiteColor].CGColor;
                self.layer.borderWidth = 4.0f;
                self.layer.frame = CGRectMake(self.frame.origin.x+(self.frame.size.width-self.frame.size.height)/2, self.frame.origin.y, self.frame.size.height, self.frame.size.height);
            } completion:^(BOOL finished) {
                self.layer.borderWidth = 0.0f;
                [self addCircleLayer];
                [self triggerTimer];
            }];
        }];
    }];
    
}

- (void)removeAllAnimations
{
    [self.self.titleName.layer pop_removeAllAnimations];
}

- (void)addCircleLayer
{
    CGFloat lineWidth = 4.f;
    CGFloat radius = CGRectGetWidth(self.bounds)/2 - lineWidth/2;
    self.circleLayer = [CAShapeLayer layer];
    CGRect rect = CGRectMake(lineWidth/2, lineWidth/2, radius * 2, radius * 2);
    self.circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                       cornerRadius:radius].CGPath;
    
    self.circleLayer.strokeColor = [UIColor colorWithRed:0.73f green:0.73f blue:0.73f alpha:1.00f].CGColor;
    self.circleLayer.fillColor = nil;
    self.circleLayer.lineWidth = lineWidth;
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:self.circleLayer];
    
    self.processLayer = [CAShapeLayer layer];
    self.processLayer.strokeEnd = 0;
    self.processLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                       cornerRadius:radius].CGPath;
    self.processLayer.strokeColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f].CGColor;
    self.processLayer.fillColor = nil;
    self.processLayer.lineWidth = lineWidth;
    self.processLayer.lineCap = kCALineCapRound;
    self.processLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:self.processLayer];
}

- (void)triggerTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)timerFired:(NSTimer *)timer{
    if (_process > 1.0) {
        [_timer invalidate];
        [self reBackLayer];
        return;
    }
    _process = _process + 0.1;
    self.processLayer.strokeEnd = _process;
}

- (void)reBackLayer{
    [self.circleLayer removeFromSuperlayer];
    [self.processLayer removeFromSuperlayer];
    [UIView animateWithDuration:0.25 animations:^{
        if (self.isSucceed) {
            self.layer.backgroundColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f].CGColor;
            self.layer.borderWidth = 2.0f;
            self.layer.borderColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f].CGColor;
            self.frame = _orignalFrame;
        } else {
            self.layer.backgroundColor = [UIColor colorWithRed:0.99f green:0.47f blue:0.49f alpha:1.00f].CGColor;
            self.layer.borderWidth = 2.0f;
            self.layer.borderColor = [UIColor colorWithRed:0.99f green:0.47f blue:0.49f alpha:1.00f].CGColor;
            self.frame = _orignalFrame;
        }
    } completion:^(BOOL finished) {
        [self addCorrectMarked];
    }];
    
}

- (void)addCorrectMarked{
    _correctMarked_1 = [CAShapeLayer layer];
    _correctMarked_2 = [CAShapeLayer layer];
    
    UIBezierPath *path_1 = [UIBezierPath bezierPath];
    if (self.isSucceed) {
        [path_1 moveToPoint:CGPointMake(_orignalFrame.size.width/2, _orignalFrame.size.height*2/3)];
        [path_1 addLineToPoint:CGPointMake(_orignalFrame.size.width/2-sqrtf(_orignalFrame.size.height), _orignalFrame.size.height*2/3-sqrtf(_orignalFrame.size.height))];
    } else {
        [path_1 moveToPoint:CGPointMake(_orignalFrame.size.width/2-sqrtf(_orignalFrame.size.height*1.5/2), _orignalFrame.size.height/2-sqrtf(_orignalFrame.size.height*1.5/2))];
        [path_1 addLineToPoint:CGPointMake(_orignalFrame.size.width/2+sqrtf(_orignalFrame.size.height*1.5/2), _orignalFrame.size.height/2+sqrtf(_orignalFrame.size.height*1.5/2))];
    }
    
    UIBezierPath *path_2 = [UIBezierPath bezierPath];
    if (self.isSucceed) {
        [path_2 moveToPoint:CGPointMake(_orignalFrame.size.width/2, _orignalFrame.size.height*2/3)];
        [path_2 addLineToPoint:CGPointMake(_orignalFrame.size.width/2+sqrtf(_orignalFrame.size.height*3.5), _orignalFrame.size.height*2/3-sqrtf(_orignalFrame.size.height*3.5))];
    } else {
        [path_2 moveToPoint:CGPointMake(_orignalFrame.size.width/2+sqrtf(_orignalFrame.size.height*1.5/2), _orignalFrame.size.height/2-sqrtf(_orignalFrame.size.height*1.5/2))];
        [path_2 addLineToPoint:CGPointMake(_orignalFrame.size.width/2-sqrtf(_orignalFrame.size.height*1.5/2), _orignalFrame.size.height/2+sqrtf(_orignalFrame.size.height*1.5/2))];
    }
    
    _correctMarked_1.strokeColor = [UIColor whiteColor].CGColor;
    _correctMarked_1.fillColor = nil;
    _correctMarked_1.lineWidth = 4.0f;
    _correctMarked_1.lineCap = kCALineCapRound;
    _correctMarked_1.lineJoin = kCALineJoinRound;
    _correctMarked_1.path = path_1.CGPath;
    
    _correctMarked_2.strokeColor = [UIColor whiteColor].CGColor;
    _correctMarked_2.fillColor = nil;
    _correctMarked_2.lineWidth = 4.0f;
    _correctMarked_2.lineCap = kCALineCapRound;
    _correctMarked_2.lineJoin = kCALineJoinRound;
    _correctMarked_2.path = path_2.CGPath;
    
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    _correctMarked_1.autoreverses = NO;
    animation.duration = 0.25;
    
    [_correctMarked_1 pop_addAnimation:animation forKey:nil];
    [_correctMarked_2 pop_addAnimation:animation forKey:nil];
    
    [self.layer addSublayer:_correctMarked_1];
    [self.layer addSublayer:_correctMarked_2];
    
    [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        //延迟一秒执行
        double delayInSeconds = 0.5f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [_correctMarked_1 removeFromSuperlayer];
            [_correctMarked_2 removeFromSuperlayer];
            [UIView animateWithDuration:0.25 animations:^{
                if (!self.isSucceed) {
                    self.layer.borderColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f].CGColor;
                }
                self.layer.backgroundColor = [UIColor whiteColor].CGColor;
                self.titleName.textColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f];
                self.titleName.hidden = NO;
            } completion:^(BOOL finished) {
                self.enabled = YES;
            }];
        });
    }];
    
}

@end
