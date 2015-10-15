//
//  Helper.m
//  GenderTimerPro
//
//  Created by Mac User12 on 01/04/15.
//  Copyright (c) 2015 iossolution. All rights reserved.
//

#import "Helper.h"


@implementation Helper

+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = title;
    return hud;
}

+ (void)dismissGlobalHUD {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
}

+(NSArray*)getSortingListOption
{
    static dispatch_once_t pred;
    static NSArray * sortingList = nil;
    
    dispatch_once(&pred, ^{
        sortingList = @[@"Time",@"Session",@"Name",@"Score"];
    });
    return sortingList;
}
+(NSArray*)sortArray:(NSString*)key array:(NSArray*)arrayToSort
{
   NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    NSArray *array = [NSArray arrayWithObject:sortDesc];
    return [arrayToSort sortedArrayUsingDescriptors:array];
}
//+(int)getStartingXforCenter:(int)width
//{
//    return (screenWidth/2)-(width/2);
//}
+(void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
    }
    else if ([view isKindOfClass:[UIButton class]]){
        UIButton *btn = (UIButton*)view;
        [btn.titleLabel setFont:[UIFont fontWithName:fontFamily size:[[btn font] pointSize]]];
    }
    else if ([view isKindOfClass:[UITextField class]]){
        UITextField *txt = (UITextField*)view;
        [txt setFont:[UIFont fontWithName:fontFamily size:[[txt font] pointSize]]];
    }
    else if ([view isKindOfClass:[UITextView class]]){
        UITextView *tv = (UITextView*)view;
        [tv setFont:[UIFont fontWithName:fontFamily size:[[tv font] pointSize]]];
    }
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES];
        }
    }
}

+(void)preventScreenLocking:(BOOL)lockFlag
{
    [[UIApplication sharedApplication] setIdleTimerDisabled: lockFlag];
}


+(NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}
+ (NSString *) hostname
{
    char baseHostName[256];
    int success = gethostname(baseHostName, 255);
    if (success != 0) return nil;
    baseHostName[255] = '\0';
    
#if !TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s.local", baseHostName];
#else
    return [NSString stringWithFormat:@"%s", baseHostName];
#endif
}

// return IP Address
+ (NSString *)localIPAddress
{
    struct hostent *host = gethostbyname([[self hostname] UTF8String]);
    if (!host) {herror("resolv"); return nil;}
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
    return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
}

+ (UIImage*)scaleImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    if (image.size.width != newSize.width || image.size.height != newSize.height)
    {
        UIGraphicsBeginImageContext( newSize );
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    return image;
}
+(void)globalAlert:(NSString*)msg{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Queue" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}
+(NSString*)removeSpecialChar:(NSString*)str{
    
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789$"] invertedSet];
    NSString *resultString = [[str componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    return resultString;
}
+(NSArray*)sortArray:(NSArray *)arr accordingToKey:(NSString *)key{
    arr = [arr sortedArrayUsingDescriptors:[NSArray arrayWithObjects:key,nil]];
    return arr;
}
+(UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
+(BOOL)validateEmailWithString:(NSString*)checkString{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
+(BOOL)isEmpty:(NSString *)str{
    if (str == nil || str == (id)[NSNull null] || [[NSString stringWithFormat:@"%@",str] length] == 0 || [[[NSString stringWithFormat:@"%@",str] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
        return YES;
    }
    return NO;
}
+(BOOL)validateMultipleTextFields:(UIView*)view1{
    for (UIView *view in view1.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            if([textField.text length]==0){
                NSLog(@"Please fill...");
                [Helper globalAlert:@"Please provide all values"];
                return NO;
            }
        }
    }
    return YES;
}
+(void)emptyMultipleTextFields:(UIView*)view1{
    for (UIView *view in view1.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.text=@"";
        }
    }
}
+ (NSAttributedString *)randomAlphanumericStringWithLength:(NSInteger)length{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:randomString];
    
    float spacing = 5.0f;
    [attributedString addAttribute:NSKernAttributeName
                             value:@(spacing)
                             range:NSMakeRange(0, [randomString length])];
    return attributedString;
}
+(CGFloat)heightForText:(NSString*)text font:(UIFont*)font withinWidth:(CGFloat)width {
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat area = size.height * size.width;
    CGFloat height = roundf(area / width);
    return ceilf(height / font.lineHeight) * font.lineHeight;
}
+(NSString*)getCurrentDate{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    return [dateFormat stringFromDate:today];
}
+(NSArray*)GetHours{
    static dispatch_once_t pred;
    static NSArray * arrHours = nil;
    
    dispatch_once(&pred, ^{
        arrHours = @[@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00",@"09:00",@"10:00",@"11:00",@"12:00"];
    });
    return arrHours;
}
+(BOOL)isLoggedIN{
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"LoggedIn"] != nil)
        return YES;
    else return NO;
}
+(void)displayImage:(AsyncImageView*)imageView withImage:(NSString*)imagePath{
    imageView.imageURL=[NSURL URLWithString:imagePath];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setupImageViewer];
    imageView.clipsToBounds = YES;
}
+(void)addGradientEffect:(UIImageView*)imgView{

    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = imgView.bounds;
    gradientMask.colors = @[(id)[UIColor whiteColor].CGColor,
                            (id)[UIColor clearColor].CGColor];
    imgView.layer.mask = gradientMask;
}
+(void)openUrlInSafari:(NSString *)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
+(void)setNsuserValue:(NSString*)key value:(NSString*)value{
    if(![Helper isEmpty:value]){
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
+(NSString*)getNsuserValue:(NSString*)key{
   return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}
+(void)getAddressFromLocation:(CLLocation *)location complationBlock:(addressCompletion)completionBlock{
    __block CLPlacemark* placemark;
    __block NSString *address = nil;
    
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
         if (error == nil && [placemarks count] > 0){
             placemark = [placemarks lastObject];
             address = [NSString stringWithFormat:@"%@",placemark.locality];
             completionBlock(address);
         }
     }];
}
@end
