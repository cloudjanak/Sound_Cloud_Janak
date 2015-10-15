//
//  EPLayer.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.04.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "EPLayer.h"

@interface EPLayer (PrivateMethods)

- (void)setCircleLayerLocationAt:(CGPoint)center;
- (void)animateShadowForLayer:(CALayer *)layer
                   fromRadius:(CGFloat)fromRadius
                     toRadius:(CGFloat)toRadius
                  fromOpacity:(CGFloat)fromOpacity
                    toOpacity:(CGFloat)toOpacity
           withTimingFunction:(EPTimingFunction)timingFunction
                 withDuration:(CFTimeInterval)duration;

@end

@implementation EPLayer

#pragma mark - Static methods

+ (CAMediaTimingFunction *)timingFunctionForFunctionType:(EPTimingFunction)functionType
{
    switch (functionType) {
        case EPTimingFunctionLinear:
            return [CAMediaTimingFunction functionWithName:@"linear"];
        case EPTimingFunctionEaseIn:
            return [CAMediaTimingFunction functionWithName:@"easeIn"];
        case EPTimingFunctionEaseOut:
            return [CAMediaTimingFunction functionWithName:@"easeOut"];
        default:
            return nil;
    }
}

#pragma mark - Instance and view lifetime methods

- (id)initWithSuperLayer:(CALayer *)superLayer
{
    self = [super init];
    if (self) {
        _superLayer = [superLayer retain];
        
        CGFloat superLayerWidth = CGRectGetWidth(superLayer.bounds);
        CGFloat superLayerHeight = CGRectGetHeight(superLayer.bounds);
        
        // background layer
        _backgroundLayer = [[CALayer layer] retain];
        _backgroundLayer.frame = superLayer.bounds;
        _backgroundLayer.opacity = 0.0;
        [_superLayer addSublayer:_backgroundLayer];
        
        // circlelayer
        self.ripplePercent = 0.9;
        self.rippleLocation = EPRippleLocationTapLocation;
        CGFloat circleSize = (CGFloat)(MAX(superLayerWidth, superLayerHeight) * self.ripplePercent);
        CGFloat circleCornerRadius = circleSize / 2;
        
        _rippleLayer = [[CALayer layer] retain];
        _rippleLayer.opacity = 0.0;
        _rippleLayer.cornerRadius = circleCornerRadius;
        [self setCircleLayerLocationAt:CGPointMake(superLayerWidth / 2, superLayerHeight / 2)];
        [_backgroundLayer addSublayer:_rippleLayer];
        
        // mask layer
        _maskLayer = [[CAShapeLayer layer] retain];
        [self setMaskLayerCornerRadius:superLayer.cornerRadius];
        [_backgroundLayer setMask:_maskLayer];
    }
    return self;
}

#pragma mark - Setters

- (void)setMaskLayerCornerRadius:(CGFloat)cornerRadius
{
    _maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:_backgroundLayer.bounds cornerRadius:cornerRadius].CGPath;
}

- (void)setRippleLocation:(EPRippleLocation)rippleLocation
{
    _rippleLocation = rippleLocation;
    CGPoint origin = CGPointZero;
    switch (rippleLocation)
    {
        case EPRippleLocationCenter:
            origin = CGPointMake(_superLayer.bounds.size.width / 2, _superLayer.bounds.size.height / 2);
            break;
        case EPRippleLocationLeft:
            origin = CGPointMake(_superLayer.bounds.size.width * 0.25, _superLayer.bounds.size.height / 2);
            break;
        case EPRippleLocationRight:
            origin = CGPointMake(_superLayer.bounds.size.width * 0.75, _superLayer.bounds.size.height / 2);
            break;
        default:
            break;
    }
    if (!CGPointEqualToPoint(origin, CGPointZero)) {
        [self setCircleLayerLocationAt:origin];
    }
}

- (void)setRipplePercent:(CGFloat)ripplePercent
{
    _ripplePercent = ripplePercent;
    if (self.ripplePercent > 0) {
        CGFloat width = CGRectGetWidth(_superLayer.bounds);
        CGFloat height = CGRectGetHeight(_superLayer.bounds);
        CGFloat circleSize = (CGFloat)(MAX(width, height) * self.ripplePercent);
        _rippleLayer.cornerRadius = circleSize / 2;
        [self setCircleLayerLocationAt:CGPointMake(width / 2, height / 2)];
    }
}

- (void)superLayerDidResize
{
    [CATransaction begin];
    [CATransaction setDisableActions:true];
    _backgroundLayer.frame = _superLayer.bounds;
    [self setMaskLayerCornerRadius:_superLayer.cornerRadius];
    [CATransaction commit];
    [self setRippleLocation:self.rippleLocation];
//    [self setCircleLayerLocationAt:CGPointMake(_superLayer.bounds.size.width / 2, _superLayer.bounds.size.height / 2)];
}

- (void)enableOnlyCircleLayer
{
    [_backgroundLayer removeFromSuperlayer];
    [_superLayer addSublayer:_rippleLayer];
}

- (void)setBackgroundLayerColor:(UIColor *)color
{
    _backgroundLayer.backgroundColor = color.CGColor;
}

- (void)setCircleLayerColor:(UIColor *)color
{
    _rippleLayer.backgroundColor = color.CGColor;
}

- (void)didChangeTapLocation:(CGPoint)location
{
    if (self.rippleLocation == EPRippleLocationTapLocation) {
        [self setCircleLayerLocationAt:location];
    }
}

- (void)enableMask:(BOOL)enable
{
    _backgroundLayer.mask = enable ? _maskLayer : nil;
}

- (void)setBackgroundLayerCornerRadius:(CGFloat)cornerRadius
{
    _backgroundLayer.cornerRadius = cornerRadius;
}

- (void)animateScaleForCircleLayer:(CGFloat)fromScale
                           toScale:(CGFloat)toScale
                withTimingFunction:(EPTimingFunction)timingFunction
                      withDuration:(CFTimeInterval)duration
{
    CABasicAnimation *rippleLayerAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    rippleLayerAnim.fromValue = @(fromScale);
    rippleLayerAnim.toValue = @(toScale);
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = @(1.0);
    opacityAnim.toValue = @(0.0);
    
    CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
    groupAnim.duration = duration;
    groupAnim.timingFunction = [EPLayer timingFunctionForFunctionType:timingFunction];
    groupAnim.removedOnCompletion = FALSE;
    groupAnim.fillMode = kCAFillModeForwards;
    groupAnim.animations = [NSArray arrayWithObjects:rippleLayerAnim, opacityAnim, nil];
    [_rippleLayer addAnimation:groupAnim forKey: nil];
}

- (void)animateAlphaForBackgroundLayer:(EPTimingFunction)timingFunction
                          withDuration:(CFTimeInterval)duration
{
    CABasicAnimation *backgroundLayerAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    backgroundLayerAnim.fromValue = @(1.0);
    backgroundLayerAnim.toValue = @(0.0);
    backgroundLayerAnim.duration = duration;
    backgroundLayerAnim.timingFunction = [EPLayer timingFunctionForFunctionType:timingFunction];
    [_backgroundLayer addAnimation:backgroundLayerAnim forKey: nil];
}

- (void)animateSuperLayerShadow:(CGFloat)fromRadius
                       toRadius:(CGFloat)toRadius
                    fromOpacity:(CGFloat)fromOpacity
                      toOpacity:(CGFloat)toOpacity
             withTimingFunction:(EPTimingFunction)timingFunction
                   withDuration:(CFTimeInterval)duration
{
    [self animateShadowForLayer:_superLayer
                     fromRadius:fromRadius
                       toRadius:toRadius
                    fromOpacity:fromOpacity
                      toOpacity:toOpacity
             withTimingFunction:timingFunction
                   withDuration:duration];
}

#pragma mark - Memory management

- (void)dealloc
{
    [_superLayer release];
    [_rippleLayer release];
    [_backgroundLayer release];
    [_maskLayer release];

    [super dealloc];
}

@end

#pragma mark - Private methods

@implementation EPLayer (PrivateMethods)

- (void)setCircleLayerLocationAt:(CGPoint)center
{
    CGFloat width = CGRectGetWidth(_superLayer.bounds);
    CGFloat height = CGRectGetHeight(_superLayer.bounds);
    CGFloat subSize = (CGFloat)(MAX(width, height) * self.ripplePercent);
    CGFloat subX = center.x - subSize/2;
    CGFloat subY = center.y - subSize/2;
    
    // disable animation when changing layer frame
    [CATransaction begin];
    [CATransaction setDisableActions:true];
    _rippleLayer.cornerRadius = subSize / 2;
    _rippleLayer.frame = CGRectMake(subX, subY, subSize, subSize);
    [CATransaction commit];
}

- (void)animateShadowForLayer:(CALayer *)layer
                   fromRadius:(CGFloat)fromRadius
                     toRadius:(CGFloat)toRadius
                  fromOpacity:(CGFloat)fromOpacity
                    toOpacity:(CGFloat)toOpacity
           withTimingFunction:(EPTimingFunction)timingFunction
                 withDuration:(CFTimeInterval)duration
{
    CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    radiusAnimation.fromValue = @(fromRadius);
    radiusAnimation.toValue = @(toRadius);
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    opacityAnimation.fromValue = @(fromOpacity);
    opacityAnimation.toValue = @(toOpacity);
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = duration;
    groupAnimation.timingFunction = [EPLayer timingFunctionForFunctionType:timingFunction];
    groupAnimation.removedOnCompletion = FALSE;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.animations = [NSArray arrayWithObjects:radiusAnimation, opacityAnimation, nil];
    [layer addAnimation:groupAnimation forKey:nil];
}

@end
