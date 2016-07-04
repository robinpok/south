//
//  localCategoryViewController.h
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface localCategoryViewController : UIViewController
@property NSMutableArray* categoryList;
@property NSMutableArray* categoryImg;
@property (weak, nonatomic) IBOutlet UITableView *categoryTBView;
@end
