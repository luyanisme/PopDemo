//
//  SubmitButton_v2.m
//  PopDemo
//
//  Created by 卢棪 on 10/8/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "SubmitButton_v2.h"

@interface SubmitButton_v2 ()
{
    CAShapeLayer *_borderDownLayer;//外边框
    CAShapeLayer *_borderUpLayer;//外边框
    CGRect       _originalFrame;//原始边框
    
    CAShapeLayer *_correctMarked_1;//画钩
    CAShapeLayer *_correctMarked_2;//画钩
}

@property (nonatomic, assign) BOOL     isSucceed;//提交是否成功
@property (nonatomic, strong) UILabel  *titleName;//文字内容

@end

@implementation SubmitButton_v2

@synthesize isSucceed = _isSucceed;

+ (id)buttonWithFrame:(CGRect)frame{
    return [[self alloc] initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.backgroundColor = [UIColor colorWithRed:0.59f green:0.60f blue:0.63f alpha:1.00f].CGColor;
        _originalFrame = frame;
        [self configBorderLayer];
        [self configSubViews];
    }
    return self;
}

- (void)configBorderLayer{
    
    CGFloat lineWidth = 3.0f;
    CGFloat radius = _originalFrame.size.height/2;
    CGRect rect = CGRectMake(0, 0, _originalFrame.size.width, _originalFrame.size.height);
    
    _borderDownLayer = [CAShapeLayer layer];
    _borderDownLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                       cornerRadius:radius].CGPath;
    
    _borderDownLayer.strokeColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f].CGColor;
    _borderDownLayer.fillColor = nil;
    _borderDownLayer.lineWidth = lineWidth;
    _borderDownLayer.lineCap = kCALineCapRound;
    _borderDownLayer.lineJoin = kCALineJoinRound;
    _borderDownLayer.strokeStart = 0;
    _borderDownLayer.strokeEnd = 0.5;
    
    //增加光晕效果
    _borderDownLayer.shadowColor = [UIColor whiteColor].CGColor;
    _borderDownLayer.shadowOffset = CGSizeMake(0, 0);
    _borderDownLayer.shadowRadius = 10;
    _borderDownLayer.shadowOpacity = 1.0;
    
    [self.layer addSublayer:_borderDownLayer];
    
    _borderUpLayer = [CAShapeLayer layer];
    _borderUpLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                       cornerRadius:radius].CGPath;
    
    _borderUpLayer.strokeColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f].CGColor;
    _borderUpLayer.fillColor = nil;
    _borderUpLayer.lineWidth = lineWidth;
    _borderUpLayer.lineCap = kCALineCapRound;
    _borderUpLayer.lineJoin = kCALineJoinRound;
    _borderUpLayer.strokeStart = 0.5;
    _borderUpLayer.strokeEnd = 1;
    
    _borderUpLayer.shadowColor = [UIColor whiteColor].CGColor;
    _borderUpLayer.shadowOffset = CGSizeMake(0, 0);
    _borderUpLayer.shadowRadius = 10;
    _borderUpLayer.shadowOpacity = 1.0;
    
    [self.layer addSublayer:_borderUpLayer];
}

- (void)configSubViews{
    [self addTarget:self
             action:@selector(touchUpInsideHandler:)
   forControlEvents:UIControlEventTouchUpInside];
    [self initLabel];
}

- (void)initLabel{
    self.titleName = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/4, self.frame.size.height/6, self.frame.size.width/2, self.frame.size.height*2/3)];
    self.titleName.font = [UIFont fontWithName:@"Avenir" size:20.0f];
    self.titleName.textAlignment = NSTextAlignmentCenter;
    self.titleName.text = @"Submit";
    self.titleName.textColor = [UIColor whiteColor];
    [self addSubview:self.titleName];
}

- (void)touchUpInsideHandler:(SubmitButton_v2 *)sender{
    self.enabled = NO;
    self.titleName.text = @"Loading";
    [self configAnimation];
}

- (void)configAnimation{

    POPBasicAnimation *downAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
    downAnimation.toValue = @(0.48);
    _borderDownLayer.autoreverses = NO;
    downAnimation.duration = 0.5;
    
    POPBasicAnimation *upAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
    upAnimation.toValue = @(0.98);
    _borderUpLayer.autoreverses = NO;
    upAnimation.duration = 0.5;
    
    [_borderDownLayer pop_addAnimation:downAnimation forKey:nil];
    [_borderUpLayer pop_addAnimation:upAnimation forKey:nil];
    
    [downAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        [_borderDownLayer pop_removeAllAnimations];
        [_borderUpLayer pop_removeAllAnimations];
        
        CABasicAnimation *startDownAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        startDownAnimation.toValue = @(0);
        
        CABasicAnimation *endDownAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        endDownAnimation.toValue = @(0.02);
        
        CAAnimationGroup *downGroup = [CAAnimationGroup animation];
        downGroup.animations = [NSArray arrayWithObjects:startDownAnimation,endDownAnimation, nil];
        downGroup.duration = 1.5;
        downGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        downGroup.autoreverses = YES;
        downGroup.repeatCount = HUGE;
        
        [_borderDownLayer addAnimation:downGroup forKey:nil];
        
        CABasicAnimation *startUpAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        startUpAnimation.toValue = @(0.5);
        
        CABasicAnimation *endUpAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        endUpAnimation.toValue = @(0.52);
        
        CAAnimationGroup *upGroup = [CAAnimationGroup animation];
        upGroup.animations = [NSArray arrayWithObjects:startUpAnimation,endUpAnimation, nil];
        upGroup.duration = 1.5;
        upGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        upGroup.autoreverses = YES;
        upGroup.repeatCount = HUGE;//永远重复
        
        [_borderUpLayer addAnimation:upGroup forKey:nil];
        
    }];

}

#pragma mark - 添加成功或失败按钮
- (void)addCorrectMarked{
    _correctMarked_1 = [CAShapeLayer layer];
    _correctMarked_2 = [CAShapeLayer layer];
    
    UIBezierPath *path_1 = [UIBezierPath bezierPath];
    if (self.isSucceed) {
        [path_1 moveToPoint:CGPointMake(_originalFrame.size.width/2, _originalFrame.size.height*2/3)];
        [path_1 addLineToPoint:CGPointMake(_originalFrame.size.width/2-sqrtf(_originalFrame.size.height), _originalFrame.size.height*2/3-sqrtf(_originalFrame.size.height))];
    } else {
        [path_1 moveToPoint:CGPointMake(_originalFrame.size.width/2-sqrtf(_originalFrame.size.height*1.5/2), _originalFrame.size.height/2-sqrtf(_originalFrame.size.height*1.5/2))];
        [path_1 addLineToPoint:CGPointMake(_originalFrame.size.width/2+sqrtf(_originalFrame.size.height*1.5/2), _originalFrame.size.height/2+sqrtf(_originalFrame.size.height*1.5/2))];
    }
    
    UIBezierPath *path_2 = [UIBezierPath bezierPath];
    if (self.isSucceed) {
        [path_2 moveToPoint:CGPointMake(_originalFrame.size.width/2, _originalFrame.size.height*2/3)];
        [path_2 addLineToPoint:CGPointMake(_originalFrame.size.width/2+sqrtf(_originalFrame.size.height*3.5), _originalFrame.size.height*2/3-sqrtf(_originalFrame.size.height*3.5))];
    } else {
        [path_2 moveToPoint:CGPointMake(_originalFrame.size.width/2+sqrtf(_originalFrame.size.height*1.5/2), _originalFrame.size.height/2-sqrtf(_originalFrame.size.height*1.5/2))];
        [path_2 addLineToPoint:CGPointMake(_originalFrame.size.width/2-sqrtf(_originalFrame.size.height*1.5/2), _originalFrame.size.height/2+sqrtf(_originalFrame.size.height*1.5/2))];
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
                [self configBorderLayer];
                self.layer.backgroundColor = [UIColor colorWithRed:0.59f green:0.60f blue:0.63f alpha:1.00f].CGColor;

                self.titleName.hidden = NO;
            } completion:^(BOOL finished) {
                self.enabled = YES;
            }];
        });
    }];
    
}

//数据请求结束
- (void)requestComplete:(BOOL)isSuccees{
    self.isSucceed = isSuccees;
    [_borderUpLayer removeAllAnimations];
    [_borderUpLayer removeFromSuperlayer];
    [_borderDownLayer removeAllAnimations];
    [_borderDownLayer removeFromSuperlayer];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.titleName.hidden = YES;
        self.titleName.text = @"Submit";
        if (self.isSucceed) {
            self.layer.backgroundColor = [UIColor colorWithRed:0.00f green:0.81f blue:0.59f alpha:1.00f].CGColor;
        } else {
            self.layer.backgroundColor = [UIColor colorWithRed:0.99f green:0.47f blue:0.49f alpha:1.00f].CGColor;
        }
    } completion:^(BOOL finished) {
        [self addCorrectMarked];
    }];
}
@end
