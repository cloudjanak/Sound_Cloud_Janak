//
//  EPImageView.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPLayer.h"

@interface EPImageView : UIImageView {

}

@property (nonatomic, assign) IBInspectable BOOL maskEnabled;
@property (nonatomic, assign) IBInspectable EPRippleLocation rippleLocation;
@property (nonatomic, assign) IBInspectable CGFloat ripplePercent;
@property (nonatomic, assign) IBInspectable BOOL backgroundAniEnabled;
@property (nonatomic, assign) IBInspectable CGFloat aniDuration;
@property (nonatomic, assign) IBInspectable EPTimingFunction rippleAniTimingFunction;
@property (nonatomic, assign) IBInspectable EPTimingFunction backgroundAniTimingFunction;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *rippleLayerColor;
@property (nonatomic, strong) IBInspectable UIColor *backgroundLayerColor;

- (void)animateRipple:(CGPoint)location;

@end
