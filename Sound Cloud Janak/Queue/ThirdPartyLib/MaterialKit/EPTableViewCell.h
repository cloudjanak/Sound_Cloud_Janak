//
//  EPTableViewCell.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.05.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPLayer.h"

@interface EPTableViewCell : UITableViewCell {

}

@property (nonatomic, assign) IBInspectable EPRippleLocation rippleLocation;
@property (nonatomic, assign) IBInspectable CGFloat rippleAniDuration;
@property (nonatomic, assign) IBInspectable CGFloat backgroundAniDuration;
@property (nonatomic, assign) IBInspectable EPTimingFunction rippleAniTimingFunction;
@property (nonatomic, assign) IBInspectable BOOL shadowAniEnabled;
@property (nonatomic, strong) IBInspectable UIColor *rippleLayerColor;
@property (nonatomic, strong) IBInspectable UIColor *backgroundLayerColor;

@end
