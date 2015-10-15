//
//  EPButton.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 15.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPLayer.h"

@interface EPButton : UIButton {

}

@property (nonatomic, assign) IBInspectable BOOL maskEnabled;
@property (nonatomic, assign) IBInspectable EPRippleLocation rippleLocation;
@property (nonatomic, assign) IBInspectable CGFloat ripplePercent;
@property (nonatomic, assign) IBInspectable CGFloat backgroundLayerCornerRadius;
@property (nonatomic, assign) IBInspectable BOOL shadowAniEnabled;
@property (nonatomic, assign) IBInspectable BOOL backgroundAniEnabled;
@property (nonatomic, assign) IBInspectable CGFloat aniDuration;
@property (nonatomic, assign) IBInspectable EPTimingFunction rippleAniTimingFunction;
@property (nonatomic, assign) IBInspectable EPTimingFunction backgroundAniTimingFunction;
@property (nonatomic, assign) IBInspectable EPTimingFunction shadowAniTimingFunction;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic,assign) IBInspectable UIColor *borderColor;
@property (nonatomic, strong) IBInspectable UIColor *rippleLayerColor;
@property (nonatomic, strong) IBInspectable UIColor *backgroundLayerColor;

@end
