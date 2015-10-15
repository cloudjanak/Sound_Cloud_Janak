//
//  Helper.h
//  GenderTimerPro
//
//  Created by Mac User12 on 01/04/15.
//  Copyright (c) 2015 iossolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "AsyncImageView.h"
#import "MHFacebookImageViewer.h"
#import "PAAImageView.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
typedef void(^addressCompletion)(NSString *);
@interface Helper : NSObject
{
}
//+(int)getStartingXforCenter:(int)width;

+(BOOL)validateEmailWithString:(NSString*)checkString;

+(NSString *)getIPAddress;

+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;

+ (void)dismissGlobalHUD;

+(NSArray*)getSortingListOption;

+(NSArray*)sortArray:(NSString*)key array:(NSArray*)arrayToSort;

+(void)preventScreenLocking:(BOOL)lockFlag;

+(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews;

+(NSString *)localIPAddress;

+(NSString *) hostname;

+ (UIImage*)scaleImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+(void)globalAlert:(NSString*)msg;

+(NSString*)removeSpecialChar:(NSString*)str;

+(NSArray*)sortArray:(NSArray*)arr accordingToKey:(NSString*)key;

+(UIColor *)colorFromHexString:(NSString *)hexString;

+(BOOL)isEmpty:(NSString *)str;

+(BOOL)validateMultipleTextFields:(UIView*)view1;

+(void)emptyMultipleTextFields:(UIView*)view1;

+(NSAttributedString *)randomAlphanumericStringWithLength:(NSInteger)length;

+(CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width;

+(NSString*)getCurrentDate;

+(NSArray*)GetHours;

+(BOOL)isLoggedIN;

+(void) displayImage:(AsyncImageView*)imageView withImage:(NSString*)imagePath;

+(void)openUrlInSafari:(NSString*)url;

+(void)setNsuserValue:(NSString*)key value:(NSString*)value;

+(NSString*)getNsuserValue:(NSString*)key;

+(void)getAddressFromLocation:(CLLocation *)location complationBlock:(addressCompletion)completionBlock;

@end
