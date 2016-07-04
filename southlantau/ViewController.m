//
//  ViewController.m
//  southlantau
//
//  Created by Mac on 22/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    bool _bannerIsVisible;
    ADBannerView *iAdBanner;
}
@end

@implementation ViewController

int countSec ;
- (void) viewDidAppear:(BOOL)animated
{
//    NSLog(@"%@",self.images);
//    NSInteger xPos = 0;
//    
//    //self.scrollView = nil;
//    NSLog(@"%f,%f",self.scrollView.contentSize.width,self.scrollView.contentSize.height);
//    
//    if(self.images.count>0)
//    {
//        for(int i=0; i<self.images.count;i++)
//        {
//            //UIImageView *img = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:self.images[i]]];
//            UIImageView *img = self.images[i];
//            [img setFrame:CGRectMake(xPos, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
//            [img setContentMode:UIViewContentModeScaleAspectFit];
//            [img setAlpha:1.0f];
//            //[img setHidden:YES];
//            //[img sizeToFit];
//            xPos += img.frame.size.width;
//            [self.scrollView addSubview:img];
//        }
//        self.scrollView.contentSize = CGSizeMake(xPos, self.scrollView.bounds.size.height);
//    }
//    
    //    NSLog(@"SDFDS");
//    UIImageView *img;
//
//        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bakery1.png" ]];
//    img.contentMode=UIViewContentModeCenter;
//    img.center = CGPointMake(10,200);
//    [self.view addSubview:img];
    
    iAdBanner = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    iAdBanner.delegate = self;
}
- (void) viewDidLayoutSubviews{
    
    self.scrollView.contentSize = CGSizeMake(self.scwidth,self.scrollView.bounds.size.height);
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //NSInteger width = self.scrollView.bounds.size.width;
    NSLog(@"%f",self.scrollView.contentSize.height);
    //ratingLabel.font = [UIFont systemFontOfSize:20];
    //anounceLabel.text = text;
    self.navigationItem.leftBarButtonItem = nil;
    NSString *endpoint;
    countSec =0;
    endpoint = [NSString stringWithFormat:@"http://pax-port.com//southlantau/getScrollList.php"];
    NSString* encodedString = [endpoint stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURL *url = [NSURL URLWithString:encodedString];
    NSLog(@"URL = %@", url);
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    //[request setValue:@"text/HTML"   forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (error) {
                                          NSLog(@"ERROR = %@", error);
                                          // Handle error...
                                          return;
                                      }
                                      
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          //                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          //                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
                                      if(!self.images)
                                      {
                                          self.images = [[NSMutableArray alloc] init];
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                          NSDictionary *tmp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                          NSArray *imgs = (NSArray *) [tmp objectForKey:@"images"];
                                          NSString *imageBaseUrlString = @"http://pax-port.com//southlantau/scroll/";
                                          NSInteger xPos = 0;
                                          
                                          for(int i=2; i<imgs.count;i++)
                                          {
                                              NSString *imageUrl = [imageBaseUrlString stringByAppendingPathComponent:imgs[i]];
                                              NSData *imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                                              
                                              UIImageView *img = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:imgdata]];
                                              NSLog(@"A");
                                              [self.images addObject:img];
                                                                                            NSLog(@"B");
                                              [img setFrame:CGRectMake(xPos, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
                                              [img setContentMode:UIViewContentModeScaleAspectFit];
                                              [img setAlpha:1.0f];
                                              //[img setHidden:YES];
                                              //[img sizeToFit];
                                              xPos += img.frame.size.width;
                                              [self.scrollView addSubview:img];
                                              
                                          }
                                          self.scwidth = xPos;
                                          self.scrollView.contentSize = CGSizeMake(xPos, self.scrollView.bounds.size.height);
                                          //[self.scrollTimer fire];
                                          self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval: 5 target: self selector: @selector(scrollChange:) userInfo: nil repeats: YES];
                                          self.loadLabel.hidden = true;
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                  
                                              });
                                     
                                      });
                                      }
                                      
                                  }];
    
    [task resume];
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Billabong" size:25];
    for (int i=0; i<[[UIFont familyNames] count]; i++) {
        if ([[UIFont familyNames][i] isEqualToString:@"Bariol"])
        {
            for (int j =0; j < [[UIFont fontNamesForFamilyName:@"Bariol"] count]; j++) {
                NSLog(@"***    %@          ", [UIFont fontNamesForFamilyName:@"Bariol"][j]  );
            }
        }
    }
    titleView.text = @"Locale : South Lantau Edition";
    
    titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
    titleView.textColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1]; // Your color here
    //titleView.backgroundColor = [UIColor blackColor];
    //self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    //self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    //self.navigationController.navigationBar.translucent = NO;
    
    //self.navigationController.navigationBar.t
    self.navigationItem.titleView = titleView;
    
    [titleView sizeToFit];
    
    
    //[self setNeedsStatusBarAppearanceUpdate];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"Ad succeed");
    if (!_bannerIsVisible)
    {
        if (iAdBanner.superview == nil)
        {
            [self.view addSubview:iAdBanner];
        }
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        
        [UIView commitAnimations];
        
        _bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.scrollTimer invalidate];
}
- (void) scrollChange :(NSTimer *)timer {
    //NSLog(@"H");
    
    int posX = self.scrollView.contentOffset.x + self.scrollView.bounds.size.width;
    if(posX > self.scrollView.bounds.size.width*4)
        posX = 0;
    
    self.scrollView.contentOffset = CGPointMake(posX, 0);

}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.scrollTimer invalidate];
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval: 5 target: self selector: @selector(scrollChange:) userInfo: nil repeats: YES];
}
@end
