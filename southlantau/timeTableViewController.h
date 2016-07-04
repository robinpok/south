//
//  timeTableViewController.h
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface timeTableViewController : UIViewController
@property NSString* transType;
@property NSInteger* transRouteId;
@property NSInteger* transDayType;
@property NSString* transDayText;
@property NSMutableArray* timeList;

@property (weak, nonatomic) IBOutlet UITableView *timetableview;
@property (weak, nonatomic) IBOutlet UIButton *label1;


@property (weak, nonatomic) IBOutlet UIButton *label2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonwidth;
@property NSDictionary* popData;
- (IBAction)label1touch:(id)sender;
- (IBAction)label2touch:(id)sender;

@end
