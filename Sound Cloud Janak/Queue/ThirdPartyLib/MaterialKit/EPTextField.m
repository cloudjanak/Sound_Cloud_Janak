//
//  EPTextField.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "EPTextField.h"
#import "Global.h"

@interface EPTextField () {
    EPLayer *_epLayer;
    UILabel *_floatingLabel;
    CALayer *_bottomBorderLayer;
}

@end

@interface EPTextField (PrivateMethods)

- (void)setupLayer;
- (void)setFloatingLabelOverlapTextField;
- (void)showFloatingLabel;
- (void)hideFloatingLabel;

@end

@implementation EPTextField

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

#pragma mark - Public methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.floatingPlaceholderEnabled) {
        return;
    }
    
    if (self.text.length) {
        _floatingLabel.textColor = [self isFirstResponder] ? self.tintColor : self.floatingLabelTextColor;
        if (_floatingLabel.alpha == 0) {
            [self showFloatingLabel];
        }
    } else {
        [self hideFloatingLabel];
    }

    _bottomBorderLayer.backgroundColor = [self isFirstResponder] ? self.tintColor.CGColor : self.bottomBorderColor.CGColor;
    CGFloat borderWidth = [self isFirstResponder] ? self.bottomBorderHighlightWidth : self.bottomBorderWidth;
    _bottomBorderLayer.frame = CGRectMake(0, self.layer.bounds.size.height - borderWidth, self.layer.bounds.size.width, borderWidth);
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    CGRect newRect = CGRectMake(rect.origin.x + self.padding.width, rect.origin.y, rect.size.width - 2 * self.padding.width, rect.size.height);
    
    if (!self.floatingPlaceholderEnabled) {
        return newRect;
    }
    
    if (self.text.length) {
        CGFloat dTop = _floatingLabel.font.lineHeight + self.floatingLabelBottomMargin;
        newRect = UIEdgeInsetsInsetRect(newRect, UIEdgeInsetsMake(dTop, 0.0, 0.0, 0.0));
    }
    return newRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

#pragma mark - Setters
-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
     [self setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setRippleLocation:(EPRippleLocation)rippleLocation
{
    _rippleLocation = rippleLocation;
    [_epLayer setRippleLocation:rippleLocation];
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

- (void)setFloatingLabelFont:(UIFont *)floatingLabelFont
{
    [_floatingLabelFont release];
    _floatingLabelFont = [floatingLabelFont retain];
    _floatingLabel.font = floatingLabelFont;
}

- (void)setFloatingLabelTextColor:(UIColor *)floatingLabelTextColor
{
    [_floatingLabelTextColor release];
    _floatingLabelTextColor = [floatingLabelTextColor retain];
    _floatingLabel.textColor = floatingLabelTextColor;
}

- (void)setBottomBorderEnabled:(BOOL)bottomBorderEnabled
{
    _bottomBorderEnabled = bottomBorderEnabled;
    [_bottomBorderLayer removeFromSuperlayer];
    [_bottomBorderLayer release];
    _bottomBorderLayer = nil;
    if (self.bottomBorderEnabled) {
        _bottomBorderLayer = [[CALayer layer] retain];
        _bottomBorderLayer.frame = CGRectMake(0, self.layer.bounds.size.height - 1, self.bounds.size.width, 1);
        _bottomBorderLayer.backgroundColor = [UIColor Grey].CGColor;
        [self.layer addSublayer:_bottomBorderLayer];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (placeholder && placeholder.length) {
        [super setPlaceholder:placeholder];
        _floatingLabel.text = placeholder;
        [_floatingLabel sizeToFit];
        [self setFloatingLabelOverlapTextField];
    }
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
    [_epLayer didChangeTapLocation:[touch locationInView:self]];
    [_epLayer animateScaleForCircleLayer:0.45 toScale:1.0 withTimingFunction:EPTimingFunctionLinear withDuration:0.75];
    [_epLayer animateAlphaForBackgroundLayer:EPTimingFunctionLinear withDuration:0.75];
    return [super beginTrackingWithTouch:touch withEvent:event];
}

#pragma mark - Private methods

- (void)setupLayer
{
    _epLayer = [[EPLayer alloc] initWithSuperLayer:self.layer];
    self.padding = CGSizeMake(5, 5);
    self.floatingLabelBottomMargin = 2.0;
    self.floatingPlaceholderEnabled = FALSE;
    self.rippleLocation = EPRippleLocationTapLocation;
    self.aniDuration = 0.65f;
    self.rippleAniTimingFunction = EPTimingFunctionLinear;
    self.shadowAniEnabled = TRUE;
    self.cornerRadius = 2.5;
    self.rippleLayerColor = [UIColor colorWithWhite:0.45f alpha:0.5f];
    self.backgroundLayerColor = [UIColor colorWithWhite:0.75f alpha:0.25f];
    self.floatingLabelFont = [UIFont boldSystemFontOfSize:10.0];
    self.floatingLabelTextColor = [UIColor lightGrayColor];
    self.bottomBorderEnabled = FALSE;
    self.bottomBorderWidth = 1.0;
    self.bottomBorderColor = [UIColor lightGrayColor];
    self.bottomBorderHighlightWidth = 1.75;
    self.layer.borderWidth = 1.0;
    self.borderStyle = UITextBorderStyleNone;
    _epLayer.ripplePercent = 1.0;
    [_epLayer setCircleLayerColor:self.rippleLayerColor];

    // Add floating label view
    _floatingLabel = [[UILabel alloc] init];
    _floatingLabel.font = self.floatingLabelFont;
    _floatingLabel.alpha = 0.0;
    [self addSubview:_floatingLabel];
}

- (void)setFloatingLabelOverlapTextField
{
    CGRect textRect = [self textRectForBounds:self.bounds];
    CGFloat originX = textRect.origin.x;
    switch (self.textAlignment)
    {
        case NSTextAlignmentCenter:
            originX += textRect.size.width / 2 - _floatingLabel.bounds.size.width / 2;
            break;
        case NSTextAlignmentRight:
            originX += textRect.size.width - _floatingLabel.bounds.size.width;
            break;
        default:
            break;
    }
    _floatingLabel.frame = CGRectMake(originX, self.padding.height, _floatingLabel.frame.size.width, _floatingLabel.frame.size.height);
}

- (void)showFloatingLabel
{
    CGRect curFrame = _floatingLabel.frame;
    _floatingLabel.frame = CGRectMake(curFrame.origin.x, self.bounds.size.height / 2, curFrame.size.width, curFrame.size.height);
    [UIView animateWithDuration:0.45
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _floatingLabel.alpha = 1.0;
                         _floatingLabel.frame = curFrame;
                     }
                     completion: nil];
}

- (void)hideFloatingLabel
{
    _floatingLabel.alpha = 0.0;
}

#pragma mark - Memory management

- (void)dealloc
{
    [_epLayer release];
    [_rippleLayerColor release];
    [_backgroundLayerColor release];
    [_floatingLabelFont release];
    [_floatingLabelTextColor release];
    [_bottomBorderColor release];
    [_floatingLabel release];
    [_bottomBorderLayer release];
    [super dealloc];
}

@end
