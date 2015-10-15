//
//  ViewController.h
//  UITest
//
//  Created by Ketan Raval on 22/09/15.
//  Copyright (c) 2015 Ketan Raval. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"
#import "Common.h"
#import "Manager.h"
#import "Helper.h"
#import "RESideMenu.h"
@interface ViewController : UIViewController
{
    Manager *objMan;
    NSMutableDictionary *post;
    
    IBOutlet EPTextField *txtEmail;
    IBOutlet EPTextField *txtPassword;
}
@end

