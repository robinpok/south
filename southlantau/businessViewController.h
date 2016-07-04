//
//  businessViewController.h
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface businessViewController : UIViewController
@property NSString* category;
@property NSMutableArray* nameList;
@property NSMutableArray* locationList;
@property (weak, nonatomic) IBOutlet UITableView *businessTable;
@end
