//
//  routeInfoViewController.h
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface routeInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *InfoTextScroll;
@property NSString* transType;
@property NSInteger* routeType;
@end
