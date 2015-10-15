//
//  Global.m
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.04.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#import "Global.h"

/**
 * Global definitions for string keys, used overall the applications
 */
NSString *const kEmptyString                    = @"";

/**
 * Global math definitions
 */
inline int sign(CGFloat x)
{
    if (x < 0)
        return -1;
    return 1;
}

inline CGFloat degrees2radians(CGFloat x)
{
    return (x * M_PI / 180.0f);
}
