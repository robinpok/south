//
//  businessDetailViewController.h
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface businessDetailViewController : UIViewController
@property NSString* bCategory;
@property NSString* bName;
@property NSString* bLocation;
@property (weak, nonatomic) IBOutlet UITextView *DetailText;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
