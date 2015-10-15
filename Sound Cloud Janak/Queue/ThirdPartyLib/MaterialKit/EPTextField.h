//
//  EPTextField.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 05.06.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPLayer.h"

@interface EPTextField : UITextField {

}

@property (nonatomic, assign) IBInspectable CGSize padding;
@property (nonatomic, assign) IBInspectable CGFloat floatingLabelBottomMargin;
@property (nonatomic, assign) IBInspectable BOOL floatingPlaceholderEnabled;
@property (nonatomic, assign) IBInspectable EPRippleLocation rippleLocation;
@property (nonatomic, assign) IBInspectable CGFloat aniDuration;
@property (nonatomic, assign) IBInspectable EPTimingFunction rippleAniTimingFunction;
@property (nonatomic, assign) IBInspectable BOOL shadowAniEnabled;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *rippleLayerColor;
@property (nonatomic, strong) IBInspectable UIColor *backgroundLayerColor;
@property (nonatomic, strong) IBInspectable UIFont *floatingLabelFont;
@property (nonatomic, strong) IBInspectable UIColor *floatingLabelTextColor;
@property (nonatomic, assign) IBInspectable BOOL bottomBorderEnabled;
@property (nonatomic, assign) IBInspectable CGFloat bottomBorderWidth;
@property (nonatomic, strong) IBInspectable UIColor *bottomBorderColor;
@property (nonatomic, strong) IBInspectable UIColor *placeHolderColor;
@property (nonatomic, assign) IBInspectable CGFloat bottomBorderHighlightWidth;

@end
