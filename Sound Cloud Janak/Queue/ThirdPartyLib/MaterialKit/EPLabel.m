//
//  EPLabel.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "EPLabel.h"

@interface EPLabel () {
    EPLayer *_epLayer;
}

@end

@interface EPLabel (PrivateMethods)

- (void)setupLayer;

@end

@implementation EPLabel

#pragma mark - Designated initializers

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupLayer];
    }
    return self;
}

#pragma mark - Setters

- (void)setMaskEnabled:(BOOL)maskEnabled
{
    _maskEnabled = maskEnabled;
    [_epLayer enableMask:maskEnabled];
}

- (void)setRippleLocation:(EPRippleLocation)rippleLocation
{
    _rippleLocation = rippleLocation;
    [_epLayer setRippleLocation:rippleLocation];
}

- (void)setRipplePercent:(CGFloat)ripplePercent
{
    _ripplePercent = ripplePercent;
    [_epLayer setRipplePercent:ripplePercent];
}

- (void)setBackgroundAniEnabled:(BOOL)backgroundAniEnabled
{
    _backgroundAniEnabled = backgroundAniEnabled;
    if (!backgroundAniEnabled) {
        [_epLayer enableOnlyCircleLayer];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    [_epLayer setMaskLayerCornerRadius:cornerRadius];
}

- (void)setRippleLayerColor:(UIColor *)rippleLayerColor
{
    [_rippleLayerColor release];
    _rippleLayerColor = [rippleLayerColor retain];
    [_epLayer setCircleLayerColor:rippleLayerColor];
}

- (void)setBackgroundLayerColor:(UIColor *)backgroundLayerColor
{
    [_backgroundLayerColor release];
    _backgroundLayerColor = [backgroundLayerColor retain];
    [_epLayer setBackgroundLayerColor:backgroundLayerColor];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [_epLayer superLayerDidResize];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [_epLayer superLayerDidResize];
}

#pragma mark - Touches handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *firstTouch = [touches anyObject];
    if (firstTouch != nil) {
        CGPoint location = [firstTouch locationInView:self];
        [self animateRipple:location];
    }
}

#pragma mark - Public methods

- (void)animateRipple:(CGPoint)location
{
    if (!CGPointEqualToPoint(location, CGPointZero)) {
        [_epLayer didChangeTapLocation:location];
//    } else if (self.rippleLocation == EPRippleLocationTapLocation) {
//        self.rippleLocation = EPRippleLocationCenter;
    }

    [_epLayer animateScaleForCircleLayer:0.65f toScale:1.0f withTimingFunction:self.rippleAniTimingFunction withDuration:self.aniDuration];
    [_epLayer animateAlphaForBackgroundLayer:self.backgroundAniTimingFunction withDuration:self.aniDuration];
}

#pragma mark - Private methods

- (void)setupLayer
{
    _epLayer = [[EPLayer alloc] initWithSuperLayer:self.layer];
    self.maskEnabled = TRUE;
    self.rippleLocation = EPRippleLocationTapLocation;
    self.ripplePercent = 0.9f;
    self.backgroundAniEnabled = TRUE;
    self.aniDuration = 0.65f;
    self.rippleAniTimingFunction = EPTimingFunctionLinear;
    self.backgroundAniTimingFunction = EPTimingFunctionLinear;
    self.cornerRadius = 2.5;
    self.rippleLayerColor = [UIColor colorWithWhite:0.45f alpha:0.5f];
    self.backgroundLayerColor = [UIColor colorWithWhite:0.75f alpha:0.25f];
    [_epLayer setMaskLayerCornerRadius:self.cornerRadius];
}

#pragma mark - Memory management

- (void)dealloc
{
    [_epLayer release];
    [_rippleLayerColor release];
    [_backgroundLayerColor release];
    [super dealloc];
}

@end
