//
//  EPButton.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 15.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "EPButton.h"

@interface EPButton () {
    EPLayer *_epLayer;
}

@end

@interface EPButton (PrivateMethods)

- (void)setupLayer;

@end

@implementation EPButton

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

- (void)setBackgroundLayerCornerRadius:(CGFloat)backgroundLayerCornerRadius
{
    _backgroundLayerCornerRadius = backgroundLayerCornerRadius;
    [_epLayer setBackgroundLayerCornerRadius:backgroundLayerCornerRadius];
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
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}
- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = [[borderColor retain] CGColor];
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

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (self.rippleLocation == EPRippleLocationTapLocation) {
        [_epLayer didChangeTapLocation:[touch locationInView:self]];
    }
    
    // rippleLayer animation
    [_epLayer animateScaleForCircleLayer:0.45 toScale:1.0 withTimingFunction:self.rippleAniTimingFunction withDuration:self.aniDuration];
    
    // backgroundLayer animation
    if (self.backgroundAniEnabled) {
        [_epLayer animateAlphaForBackgroundLayer:self.backgroundAniTimingFunction withDuration:self.aniDuration];
    }
    
    // shadow animation for self
    if (self.shadowAniEnabled) {
        CGFloat shadowRadius = self.layer.shadowRadius;
        CGFloat shadowOpacity = self.layer.shadowOpacity;
        [_epLayer animateSuperLayerShadow:10 toRadius:shadowRadius fromOpacity:0 toOpacity:shadowOpacity withTimingFunction:self.shadowAniTimingFunction withDuration:self.aniDuration];
    }
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

#pragma mark - Private methods

- (void)setupLayer
{
    _epLayer = [[EPLayer alloc] initWithSuperLayer:self.layer];
    self.adjustsImageWhenHighlighted = FALSE;
    self.maskEnabled = TRUE;
    self.rippleLocation = EPRippleLocationTapLocation;
    self.ripplePercent = 0.9f;
    self.backgroundLayerCornerRadius = 0.0f;
    self.shadowAniEnabled = TRUE;
    self.backgroundAniEnabled = TRUE;
    self.aniDuration = 0.65f;
    self.rippleAniTimingFunction = EPTimingFunctionLinear;
    self.backgroundAniTimingFunction = EPTimingFunctionLinear;
    self.shadowAniTimingFunction = EPTimingFunctionEaseOut;
    self.cornerRadius = 2.5;
    self.rippleLayerColor = [UIColor colorWithWhite:0.45f alpha:0.5f];
    self.backgroundLayerColor = [UIColor colorWithWhite:0.75f alpha:0.25f];
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
