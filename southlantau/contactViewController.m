//
//  contactViewController.m
//  southlantau
//
//  Created by Mac on 22/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import "contactViewController.h"

@interface contactViewController ()

@end

@implementation contactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *endpoint;
    endpoint = [NSString stringWithFormat:@"http://pax-port.com//southlantau/contact/getdata.php"];
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
                                      
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          NSDictionary *tmp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                          [self.contactScroll setText:(NSString*)[tmp objectForKey:@"text"]];
                                          //[self.textScroll setTextAlignment:NSTextAlignmentCenter];
                                          self.contactScroll.font = [UIFont fontWithName:@"Bariol" size:25];
                                      });
                                      
                                      
                                  }];
    
    [task resume];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Billabong" size:25];
    titleView.text = @"Contact/Feedback";
    titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
    titleView.textColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];; // Your color here
    
    self.navigationItem.titleView = titleView;
    
    [titleView sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
    UIImage* img = [UIImage imageNamed:@"controls_play_back_32.png"];    //[UIImage imageWithContentsOfFile:@"bac"]
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(onBack:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];
}

- (IBAction)onBack:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
