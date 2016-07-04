//
//  transDayViewController.h
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface transDayViewController : UIViewController
@property NSArray *dayList;
@property NSString *transType;
@property NSString *transRoute;
@property (weak, nonatomic) IBOutlet UITableView *transdaylist;
@property NSInteger *tranRouteId;
@end
