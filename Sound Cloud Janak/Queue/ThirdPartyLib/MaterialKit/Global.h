//
//  Global.h
//  EPMaterialKit
//
//  Created by Eugene Pankratov on 29.04.15.
//  Copyright (c) 2015 ua.net.pankratov. All rights reserved.
//

#ifndef _Global_h_
#define _Global_h_

#import "AppDelegate.h"
#import "EPButton.h"
#import "EPTableViewCell.h"
#import "EPLabel.h"
#import "EPTextField.h"
#import "EPImageView.h"
#import "UIColor+Extra.h"

/**
 * Tags to return type of device
 */
typedef enum {
    kDeviceIPhone = 0,
    kDeviceIPad
} DeviceType;

/**
 * Gets device type
 */
CG_INLINE DeviceType deviceType()
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
	if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM())
		return kDeviceIPad;
	else
		return kDeviceIPhone;
#else
	return kDeviceIPhone;
#endif
}

/**
 * Returns true if device is an iPad
 */
CG_INLINE BOOL isPad()
{
	return (BOOL)(deviceType() == kDeviceIPad);
}

/**
 * Returns true if device is an iPhone or iPod touch
 */
CG_INLINE BOOL isPhone()
{
	return (BOOL)(deviceType() == kDeviceIPhone);
}

/**
 *  System versioning
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 * More verbose logger than standard use to output line number and function number
 * If DEBUG option specifiend in the build, it has meaning. Otherwise macros is empty
 */
#ifdef DEBUG
#define VLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define VLog(xx, ...) ((void)0)
#endif

/**
 * App delegate shortcut
 */
#define GLOBAL_APP_DELEGATE                         ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/**
 * Useful functions that create color by cpecifying all RGBA (reg-green-blue-alpha) values. In first
 * case the color has an byte integer value from 0 to 255. The second gives an opportunity to specify
 * floating values between 0 and 1.0
 */
#define RGBA_COLOR(r, g, b, a)                      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGB_COLOR(r, g, b)                          RGBA_COLOR(r, g, b, 1.0)
#define RGBA_FLOAT_COLOR(r, g, b, a)                [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:a]
#define RGB_FLOAT_COLOR(r, g, b)                    RGBA_FLOAT_COLOR(r, g, b, 1.0)
#define HEXA_COLOR(c, a)                            [UIColor colorWithRed:(((c >> 16) & 0xFF) / 255.0) green:(((c >> 8) & 0xFF) / 255.0) blue:(((c) & 0xFF)/ 255.0) alpha:a]
#define HEX_COLOR(c)                                HEXA_COLOR(c, 1.0)

/**
 * Global definitions for string keys, used overall the applications
 */
extern NSString *const kEmptyString;

/**
 * Global math definitions
 */
extern int sign(CGFloat x);
extern CGFloat degrees2radians(CGFloat x);

#endif // _Global_h_
