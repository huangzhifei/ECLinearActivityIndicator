//
//  ECLinearActivityIndicatorView.m
//  ECLinearActivityIndicator
//
//  Created by eric on 2018/1/30.
//  Copyright © 2018年 huangzhifei. All rights reserved.
//

#import "ECLinearActivityIndicatorView.h"

@interface ECLinearActivityIndicatorView()

@property (nonatomic, strong) CAGradientLayer *leftGradientLayer;
@property (nonatomic, strong) CAGradientLayer *rightGradientLayer;
@property (nonatomic, strong) CABasicAnimation *leftAnimation;
@property (nonatomic, strong) CABasicAnimation *rightAnimation;
@property (nonatomic, assign) BOOL animating;

@end

@implementation ECLinearActivityIndicatorView

- (instancetype)init {
    if (self = [super init]) {
        _animating = NO;
        _hidesWhenStopped = YES;
        _duration = 1.5;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.clipsToBounds = true;
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    
    if (self.hidesWhenStopped) {
        self.hidden = !self.animating;
    }
    [self.layer addSublayer:self.leftGradientLayer];
    [self.layer addSublayer:self.rightGradientLayer];
}

- (CAGradientLayer *)leftGradientLayer {
    if (!_leftGradientLayer) {
        UIColor *color = [self.tintColor colorWithAlphaComponent:0.7];
        UIColor *clearColor = [self.tintColor colorWithAlphaComponent:0];
        _leftGradientLayer = [CAGradientLayer layer];
        _leftGradientLayer.colors = @[clearColor, color];
        _leftGradientLayer.startPoint = CGPointMake(0.5, 0);
        _leftGradientLayer.endPoint = CGPointMake(1, 0);
        _leftGradientLayer.anchorPoint = CGPointMake(0, 0);
        _leftGradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _leftGradientLayer.masksToBounds = YES;
        _leftGradientLayer.cornerRadius = self.bounds.size.height * 0.5;
    }
    return _leftGradientLayer;
}

- (CAGradientLayer *)rightGradientLayer {
    if (!_rightGradientLayer) {
        UIColor *color = [self.tintColor colorWithAlphaComponent:0.7];
        UIColor *clearColor = [self.tintColor colorWithAlphaComponent:0];
        _rightGradientLayer = [CAGradientLayer layer];
        _rightGradientLayer.colors = @[clearColor, color];
        _rightGradientLayer.startPoint = CGPointMake(0.5, 0);
        _rightGradientLayer.endPoint = CGPointMake(0, 0);
        _rightGradientLayer.anchorPoint = CGPointMake(0, 0);
        _rightGradientLayer.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        _rightGradientLayer.masksToBounds = YES;
        _rightGradientLayer.cornerRadius = self.bounds.size.height * 0.5;
    }
    return _rightGradientLayer;
}

- (CABasicAnimation *)leftAnimation {
    if (!_leftAnimation) {
        _leftAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        _leftAnimation.fromValue = @(-self.bounds.size.width);
        _leftAnimation.toValue = @(self.bounds.size.width);
        _leftAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _leftAnimation.repeatCount = INFINITY;
        _leftAnimation.removedOnCompletion = false; // 保持运行进入后台的时候
    }
    return _leftAnimation;
}

- (CABasicAnimation *)rightAnimation {
    if (!_rightAnimation) {
        _rightAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        _rightAnimation.fromValue = @(self.bounds.size.width);
        _rightAnimation.toValue = @(-self.bounds.size.width);
        _rightAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        _rightAnimation.repeatCount = INFINITY;
        _rightAnimation.removedOnCompletion = false; // 保持运行进入后台的时候
    }
    return _rightAnimation;
}

- (void)startAnimating {
    self.animating = YES;
    
    self.leftAnimation.duration = self.duration;
    [self.leftGradientLayer addAnimation:self.leftAnimation forKey:@"leftAnimation"];
    
    self.rightAnimation.duration = self.duration;
    self.rightAnimation.timeOffset = 0.5 * self.duration;
    [self.rightGradientLayer addAnimation:self.rightAnimation forKey:@"rightAnimation"];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)stopAnimating {
    self.animating = false;
    [self.leftGradientLayer removeAllAnimations];
    [self.rightGradientLayer removeAllAnimations];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    if ([self isAnimating]) {
        [self startAnimating];
    } else {
        [self startAnimating];
        [self stopAnimating];
    }
}

- (BOOL)isAnimating {
    return self.animating;
}

@end
