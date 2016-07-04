//
//  ViewController.h
//  southlantau
//
//  Created by Mac on 22/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <UIScrollViewDelegate, ADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property NSMutableArray  *images;
@property int scwidth;
@property NSTimer* scrollTimer;
- (IBAction)PageChange:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *loadLabel;
@end
