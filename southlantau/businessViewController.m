//
//  businessViewController.m
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import "businessViewController.h"
#import "businessDetailViewController.h"
@interface businessViewController ()

@end

@implementation businessViewController

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
    titleView.text = self.category;
    titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
    //titleView.lineBreakMode = UILineBreakModeWordWrap;
    titleView.adjustsFontSizeToFitWidth = YES;
    titleView.textColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1]; // Your color here
    
    self.navigationItem.titleView = titleView;
    
    [titleView sizeToFit];

    
    NSString *endpoint;
    NSLog(@"%@",self.category);
    NSString* encoded = (NSString* ) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self.category,NULL,(CFStringRef) @"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    endpoint = [NSString stringWithFormat:@"http://pax-port.com/southlantau/localbusiness/getbusiness.php?category=%@",encoded];
    //NSString* encodedString = [endpoint stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURL *url = [NSURL URLWithString:endpoint];
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
                                          self.locationList = [[NSMutableArray alloc] init];
                                          self.nameList = [[NSMutableArray alloc] init];
                                          for(int i=0; i<tmp.count;i++)
                                          {
                                              [self.locationList addObject:[tmp[i] objectForKey:@"location"]];
                                              [self.nameList addObject:[tmp[i] objectForKey:@"name"]];
                                          }
//                                          self.locationList = [[NSMutableArray alloc] init];
//                                          self.nameList = [[NSMutableArray alloc] init];
//                                          self.locationList = (NSMutableArray *) [tmp objectForKey:@"location"];
//                                          self.nameList = (NSMutableArray *) [tmp objectForKey:@"name"];
                                          [self.businessTable reloadData];
                                          //[self.textScroll setTextAlignment:NSTextAlignmentCenter];

                                          
                                      });
                                      
                                      
                                  }];
    
    [task resume];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView{
    return 1;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *sectionName;
//    switch (section)
//    {
//        case 0:
//            sectionName = NSLocalizedString(@"Category", @"Category");
//            break;
//        default:
//            sectionName = @"";
//            break;
//    }
//    return sectionName;
//}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"businessCell" forIndexPath:indexPath];
    cell.textLabel.text = self.nameList[indexPath.row];
    cell.detailTextLabel.text =self.locationList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType =UITableViewCellAccessoryNone;
    cell.textLabel.font = [UIFont fontWithName:@"Bariol" size:20];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}

//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    self.routeType = (NSString*)[self.data objectAtIndex:indexPath.row];
//}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    businessDetailViewController *busiviewD = [segue destinationViewController];
    
    NSIndexPath *selectedr= [[self businessTable] indexPathForSelectedRow];
    busiviewD.bCategory = self.category;
    busiviewD.bName = self.nameList[selectedr.row];
    busiviewD.bLocation = self.locationList[selectedr.row];
    
}
- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.locationList count];
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
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
    UIImage* img = [UIImage imageNamed:@"controls_play_back_32.png"];    //[UIImage imageWithContentsOfFile:@"bac"]
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleBordered target:self action:@selector(onBack:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];
}

- (IBAction)onBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
