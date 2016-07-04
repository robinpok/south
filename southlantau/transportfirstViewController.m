//
//  transportfirstViewController.m
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import "transportfirstViewController.h"
#import "transportViewController.h"
#import "transDayViewController.h"
@interface transportfirstViewController ()

@end

@implementation transportfirstViewController

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
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Billabong" size:25];
    titleView.text = [NSString stringWithFormat:@"%@ Routes",self.rType];
    titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
    titleView.textColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];; // Your color here
    
    self.navigationItem.titleView = titleView;
    
    [titleView sizeToFit];
    if([self.rType isEqualToString:@"Taxi"])
    {
        self.routeList.hidden = true;
        self.txtScroll.hidden = false;
        self.txtScroll.font = [UIFont fontWithName:@"Bariol" size:20];
    }
    else
    {
        self.txtScroll.hidden = true;
        NSString *endpoint;
        endpoint = [NSString stringWithFormat:@"http://pax-port.com//southlantau/transport/getroutelist.php?type=%@",self.rType];
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
                                              NSArray *tmp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                              self.routeDataList = tmp;
                                              [self.routeList reloadData];
                                              //[self.textScroll setTextAlignment:NSTextAlignmentCenter];
                                              
                                          });
                                          
                                          
                                      }];
        
        [task resume];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView{
    return 1;
}
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"routelistcell" forIndexPath:indexPath];
    cell.textLabel.text = self.routeDataList[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Bariol" size:25];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    self.routeType = (NSString*)[self.data objectAtIndex:indexPath.row];
//}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    transDayViewController *recordView1 = [segue destinationViewController];
    recordView1.transType = self.rType;
    NSIndexPath *selectedr= [[self routeList] indexPathForSelectedRow];
    recordView1.transRoute = self.routeDataList[selectedr.row];
    recordView1.tranRouteId = selectedr.row + 1;
    
    //self.navigationItem.title  = @"back";
    //recordView1.rType = self.routeType;
    
}
- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.routeDataList count];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
    UIImage* img = [UIImage imageNamed:@"controls_play_back_32.png"];    //[UIImage imageWithContentsOfFile:@"bac"]
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleBordered target:self action:@selector(onBack:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];
}

- (IBAction)onBack:(id)sender{
    transportViewController *transview = [self.storyboard instantiateViewControllerWithIdentifier:@"transportview"];
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
