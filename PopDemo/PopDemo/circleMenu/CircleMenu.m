//
//  CircleMenu.m
//  PopDemo
//
//  Created by 卢棪 on 10/10/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "CircleMenu.h"

#define MARGIN (20.0f)

@interface CircleMenu ()
{
    CGRect _originalFrame;//原始frame大小
    UILabel *_titleName;//标签名称
    
    CAShapeLayer *_glowCircleLayer;//光圈
    CAShapeLayer *_blackCircle;//黑色圆圈
    
    UIViewController *_currentCtrl;//当前的视图控制器
}

@end

@implementation CircleMenu

+ (id)menuWithFrame:(CGRect)frame{
    if (frame.size.width != frame.size.height) {
        frame.size.height = frame.size.width;
    }
    return [[self alloc] initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _originalFrame = frame;
        self.layer.cornerRadius = frame.size.height/2;
        [self addTarget:self action:@selector(touchUpInsideHandler:) forControlEvents:UIControlEventTouchUpInside];
        [self configWidget];
    }
    return self;
}

- (void)configWidget{
    [self initTitleLabel];
}

- (void)showByController:(UIViewController *)controller{
    _currentCtrl = controller;
    [controller.view addSubview:self];
}

- (void)initTitleLabel{
    _titleName = [[UILabel alloc] initWithFrame:CGRectMake(_originalFrame.size.height/6, _originalFrame.size.height/6, _originalFrame.size.height*2/3, _originalFrame.size.height*2/3)];
    _titleName.textColor = [UIColor whiteColor];
    _titleName.text = @"GO";
    _titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:25.0f];
    _titleName.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleName];
}

- (void)initBlackCircle{
    CGFloat lineWidth = 10.0f;
    CGFloat radius = 0;
    
    _blackCircle = [CAShapeLayer layer];
    _blackCircle.opacity = 1;
    _blackCircle.path = [self pathWithDiameter:radius].CGPath;
    
    _blackCircle.strokeColor = [UIColor colorWithRed:0.13f green:0.13f blue:0.13f alpha:1.00f].CGColor;
    _blackCircle.fillColor = [UIColor colorWithRed:0.13f green:0.13f blue:0.13f alpha:1.00f].CGColor;
    _blackCircle.lineWidth = lineWidth;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    UIBezierPath *toPath = [self pathWithDiameter:CGRectGetWidth(self.bounds) - lineWidth*2];//缩小当前path的动画
    [pathAnimation setValue:@"Animation2" forKey:@"blackCircle"];
    pathAnimation.toValue = (id)toPath.CGPath;
    pathAnimation.duration = 0.25;
    pathAnimation.delegate = self;
    //为了使动画结束后不弹回起始效果
    pathAnimation.autoreverses = NO;//默认就是NO，设置成Yes之后下面fillMode就不起作用了
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    [_blackCircle addAnimation:pathAnimation forKey:nil];
    
    [self.layer addSublayer:_blackCircle];
}

- (void)initGlowCircle{
    
    CGFloat lineWidth = 10.0f;
    CGFloat radius = CGRectGetWidth(self.bounds)/4 - lineWidth/2;
    
    _glowCircleLayer = [CAShapeLayer layer];
    _glowCircleLayer.opacity = 0.5;
    _glowCircleLayer.path = [self pathWithDiameter:radius].CGPath;
    
    _glowCircleLayer.strokeColor = [UIColor colorWithRed:0.71f green:0.72f blue:0.75f alpha:1.00f].CGColor;
    _glowCircleLayer.fillColor = nil;
    _glowCircleLayer.lineWidth = lineWidth;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    UIBezierPath *toPath = [self pathWithDiameter:CGRectGetWidth(self.bounds)*1.5 - lineWidth/2];//缩小当前path的动画
    [pathAnimation setValue:@"Animation1" forKey:@"glowCircle"];
    pathAnimation.toValue = (id)toPath.CGPath;
    pathAnimation.duration = 0.25;
    pathAnimation.delegate = self;
    [_glowCircleLayer addAnimation:pathAnimation forKey:@"glowCircle"];
    [self.layer addSublayer:_glowCircleLayer];
    
}

#pragma mark - Delegate of animation
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    if ([[anim valueForKey:@"glowCircle"] isEqual:@"Animation1"]) {
        [_glowCircleLayer removeFromSuperlayer];
        [self initBlackCircle];
    }
    
    if ([[anim valueForKey:@"blackCircle"] isEqual:@"Animation2"]) {
        [self initFunctionButtons];
    }
    
}

- (void)initFunctionButtons{
    for (int i=0; i<4; i++) {
        UIButton *functionBtn = [[UIButton alloc] init];
        functionBtn.backgroundColor = self.functionButtonColors[i];
        functionBtn.tag = 10000+i;
        functionBtn.center = _currentCtrl.view.center;
        [functionBtn addTarget:self action:@selector(functionButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [_currentCtrl.view addSubview:functionBtn];
            switch (i) {
                case 0:{
                    [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
                        functionBtn.frame = CGRectMake(self.frame.origin.x+5, self.frame.origin.y-MARGIN-(self.bounds.size.height-10), self.bounds.size.width-10, self.bounds.size.height-10);
                        functionBtn.layer.cornerRadius = functionBtn.frame.size.width/2;
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                    break;
                    
                case 1:{
                    [UIView animateWithDuration:0.25 delay:0.1 options:0 animations:^{
                        functionBtn.frame = CGRectMake(self.frame.origin.x+self.bounds.size.width+20, self.frame.origin.y+5, self.bounds.size.width-10, self.bounds.size.height-10);
                        functionBtn.layer.cornerRadius = functionBtn.frame.size.width/2;
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                    break;
                    
                case 2:{
                    [UIView animateWithDuration:0.25 delay:0.2 options:0 animations:^{
                        functionBtn.frame = CGRectMake(self.frame.origin.x+5, self.frame.origin.y+self.bounds.size.height+MARGIN, self.bounds.size.width-10, self.bounds.size.height-10);
                        functionBtn.layer.cornerRadius = functionBtn.frame.size.width/2;
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                    break;
                    
                case 3:{
                    [UIView animateWithDuration:0.25 delay:0.3 options:0 animations:^{
                        functionBtn.frame = CGRectMake(self.frame.origin.x-(self.bounds.size.width+MARGIN-10), self.frame.origin.y+5, self.bounds.size.width-10, self.bounds.size.height-10);
                        functionBtn.layer.cornerRadius = functionBtn.frame.size.width/2;
                    } completion:^(BOOL finished) {
                        
                    }];
                }
                    break;
                    
                default:
                    break;
            }
            
        
    }
    
}

- (void)functionButtonTap:(UIButton *)sender{
    
    switch (sender.tag) {
        case DIRECTIONTOP:
            return;
            break;
            
        case DIRECTIONRIGHT:
            return;
            break;
            
        case DIRECTIONBOTTOM:
            return;
            break;
            
        case DIRECTIONLEFT:
            return;
            break;
            
        default:
            break;
    }
    
    if (self.delegate) {
        [self.delegate functionButtonTapped:(sender.tag-10000)];
    }
}

- (UIBezierPath *)pathWithDiameter:(CGFloat)diameter {
    return [UIBezierPath bezierPathWithOvalInRect:CGRectMake((CGRectGetWidth(self.bounds) - diameter) / 2, (CGRectGetHeight(self.bounds) - diameter) / 2, diameter, diameter)];
}

- (void)touchUpInsideHandler:(CircleMenu *)sender{
    self.enabled = NO;
    [self initGlowCircle];
}

@end
