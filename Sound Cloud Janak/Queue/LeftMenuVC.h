//
//  LeftMenuVC.h
//  Queue
//
//  Created by Ketan Raval on 28/09/15.
//  Copyright (c) 2015 Ketan Raval. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "UIViewController+RESideMenu.h"
@interface LeftMenuVC : UIViewController<UITableViewDataSource,UITableViewDelegate,RESideMenuDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
