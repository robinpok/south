//
//  transportViewController.h
//  southlantau
//
//  Created by Mac on 22/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface transportViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *transportlist;
@property NSArray *data;
@property NSString *routeType;
- (IBAction)onBack:(id)sender;
@end
