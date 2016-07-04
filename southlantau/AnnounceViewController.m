//
//  AnnounceViewController.m
//  southlantau
//
//  Created by Mac on 22/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import "AnnounceViewController.h"
#import "ViewController.h"
@interface AnnounceViewController ()
{
    UILabel *anounceLabel;
}
@end

@implementation AnnounceViewController

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
    
    
    NSInteger width = self.scrollView.bounds.size.width;
    anounceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, width-40, 0)];
    //ratingLabel.font = [UIFont systemFontOfSize:20];
    //anounceLabel.text = text;
    self.navigationItem.leftBarButtonItem = nil;
    NSString *endpoint;

    endpoint = [NSString stringWithFormat:@"http://pax-port.com//southlantau/anouncements/getdata.php"];
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
                                          anounceLabel.numberOfLines = 0;
                                          anounceLabel.lineBreakMode = NSLineBreakByCharWrapping;
                                          NSArray *imgs = (NSArray *) [tmp objectForKey:@"images"];
                                          [anounceLabel setText:(NSString*)[tmp objectForKey:@"text"]];
                                          [anounceLabel sizeToFit];
                                          anounceLabel.font = [UIFont fontWithName:@"Bariol" size:20];
                                          [self.scrollView addSubview:anounceLabel];
                                          NSString *imageBaseUrlString = @"http://pax-port.com//southlantau/anouncements/images/";
                                          NSInteger yPos = 10 + anounceLabel.frame.size.height+10;
                                          
                                          for(int i=2; i<imgs.count;i++)
                                          {
                                              NSString *imageUrl = [imageBaseUrlString stringByAppendingPathComponent:imgs[i]];
                                              NSData *imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                                              
                                              UIImageView *img = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:imgdata]];
                                              [img setFrame:CGRectMake(20, yPos, width-40, 0)];
                                              //[img setContentMode:UIViewContentModeScaleAspectFill];
                                              [img setAlpha:1.0f];
                                              //[img setHidden:YES];
                                              [img sizeToFit];
                                              yPos += 10 + img.frame.size.height;
                                              [self.scrollView addSubview:img];
                                              
                                          }
                                          NSLog(@"yPos = %d",yPos);
                                          
                                          self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, yPos);
                                          
                                      });
                                      
                                      
                                  }];
    
    [task resume];
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Billabong" size:25];
    titleView.text = @"Local Area Updates";
    titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
    titleView.textColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];; // Your color here

    self.navigationItem.titleView = titleView;

    [titleView sizeToFit];
    //anounceLabel.text = text;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
    UIImage* img = [UIImage imageNamed:@"controls_play_back_32.png"];    //[UIImage imageWithContentsOfFile:@"bac"]
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleBordered target:self action:@selector(onBack:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];
}

- (IBAction)onBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
