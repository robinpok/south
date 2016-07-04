//
//  transportfirstViewController.h
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface transportfirstViewController : UIViewController
@property NSString* rType;
@property (weak, nonatomic) IBOutlet UITableView *routeList;
@property NSArray* routeDataList;
@property (weak, nonatomic) IBOutlet UITextView *txtScroll;
@end
