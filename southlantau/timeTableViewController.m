//
//  timeTableViewController.m
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import "timeTableViewController.h"
#import "routeInfoViewController.h"

@interface timeTableViewController ()

@end

@implementation timeTableViewController

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
    titleView.text = self.transDayText;
    titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
    titleView.textColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1]; // Your color here
    
    self.navigationItem.titleView = titleView;
    
    [titleView sizeToFit];
    
    NSString *endpoint;
    
    
    [self.label1 setFrame:CGRectMake(0,0,self.view.frame.size.width/2,25)];
    self.label1.font = [UIFont fontWithName:@"Bariol" size:15];
    self.label1.tintColor = [UIColor blackColor];
    self.label1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //self.label1.titleLabel.textAlignment = NSTextAlignmentJustified;
    self.label2.font = [UIFont fontWithName:@"Bariol" size:15];
    self.label2.tintColor = [UIColor blackColor];
    self.label2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    endpoint = [NSString stringWithFormat:@"http://pax-port.com//southlantau/transport/gettimelist.php?type=%@&route_id=%lu&daytype=%lu",self.transType,self.transRouteId,self.transDayType];
    NSString* encodedString = [endpoint stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURL *url = [NSURL URLWithString:encodedString];
    NSLog(@"URL = %@", url);
    //[self setTitle:[NSString stringWithFormat:@"%@ Routes",self.rType]];
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
                                          self.popData = tmp;
                                          NSArray* key= [tmp allKeys];
                                          NSLog(@"%@",key);
                                          if(key.count>0)
                                          {
                                              [self.label2 setTitle:key[0] forState:UIControlStateNormal];
                                              NSArray *tmpArray;
                                              if(key.count>1)
                                              {
                                                  if(![key[1] isEqualToString:@""])
                                                      tmpArray = [self.popData objectForKey:key[1]];
                                                  else
                                                      tmpArray = [self.popData objectForKey:key[0]];
                                              }
                                              else
                                              {
                                                  tmpArray = [self.popData objectForKey:key[0]];
                                              }
                                              self.timeList = [[NSMutableArray alloc] init];
                                              for(int i=0; i<tmpArray.count;i++)
                                              {
                                                  if(![tmpArray[i] isEqualToString:@""])
                                                      [self.timeList addObject:tmpArray[i]];
                                              }
                                              if(self.timeList.count == 0)
                                                  self.timeList[0] = @"Contact Store for Details";
                                              [self.timetableview reloadData];
                                          }
                                          else
                                              [self.label2 setTitle:@"" forState:UIControlStateDisabled];
                                          if(key.count>1)
                                              [self.label1 setTitle:key[1] forState:UIControlStateNormal];
                                          else
                                              [self.label1 setTitle:@"" forState:UIControlStateDisabled];
                                          NSLog(@"%@",tmp);
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
    if(self.timeList.count>0)
        return 1;
    else
        return 0;
}
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"timelistcell" forIndexPath:indexPath];
    cell.textLabel.text = self.timeList[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.font = [UIFont fontWithName:@"Bariol" size:20];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    self.routeType = (NSString*)[self.data objectAtIndex:indexPath.row];
//}


- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.timeList count];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    routeInfoViewController *infoController = [segue destinationViewController];
    infoController.transType = self.transType;
    infoController.routeType = self.transRouteId;
}

- (IBAction)label1touch:(id)sender {
    NSString* key = self.label1.titleLabel.text;
    NSArray *tmpArray = [self.popData objectForKey:key];
    self.timeList = [[NSMutableArray alloc] init];
    for(int i=0; i<tmpArray.count;i++)
    {
        if(![tmpArray[i] isEqualToString:@""])
            [self.timeList addObject:tmpArray[i]];
            
        
    }
    [self.timetableview reloadData];
}

- (IBAction)label2touch:(id)sender {
    NSString* key = self.label2.titleLabel.text;
    NSArray *tmpArray = [self.popData objectForKey:key];
    self.timeList = [[NSMutableArray alloc] init];
    for(int i=0; i<tmpArray.count;i++)
    {
        if(![tmpArray[i] isEqualToString:@""])
            [self.timeList addObject:tmpArray[i]];
 
    }

    [self.timetableview reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
    UIImage* img = [UIImage imageNamed:@"controls_play_back_32.png"];    //[UIImage imageWithContentsOfFile:@"bac"]
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleBordered target:self action:@selector(onBack:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];
}

- (IBAction)onBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
