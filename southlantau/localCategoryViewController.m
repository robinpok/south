//
//  localCategoryViewController.m
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import "localCategoryViewController.h"
#import "businessViewController.h"
@interface localCategoryViewController ()

@end

@implementation localCategoryViewController

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
    endpoint = [NSString stringWithFormat:@"http://pax-port.com/southlantau/localbusiness/getlist.php"];
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
                                      self.categoryList = [[NSMutableArray alloc] init];
                                      self.categoryImg = [[NSMutableArray alloc] init];
                                      if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                          //                                          NSLog(@"Response HTTP Status code: %ld\n", (long)[(NSHTTPURLResponse *)response statusCode]);
                                          //                                          NSLog(@"Response HTTP Headers:\n%@\n", [(NSHTTPURLResponse *)response allHeaderFields]);
                                      }
                                      
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          NSArray *tmp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                          for (int i =0 ;i<tmp.count ;i++)
                                          {
                                              [self.categoryList addObject:[tmp[i] objectForKey:@"category"]];
                                              [self.categoryImg addObject:[tmp[i] objectForKey:@"img"]];
                                          }
                                          
                                          [self.categoryTBView reloadData];
                                          //[self.textScroll setTextAlignment:NSTextAlignmentCenter];
                                          self.categoryTBView.tableHeaderView.backgroundColor = [UIColor clearColor];

                                      });
                                      
                                      
                                  }];
    
    [task resume];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Billabong" size:25];
    titleView.text = @"Local Stores";
    titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
    titleView.textColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1]; // Your color here
    
    self.navigationItem.titleView = titleView;
    
    [titleView sizeToFit];
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
    cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
    cell.textLabel.text = self.categoryList[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"Bariol" size:20];
    
    /*
    
    CGSize itemsize = CGSizeMake(25, 25);
    UIGraphicsBeginImageContext(itemsize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemsize.width, itemsize.height);
    
    UIImage* image = [UIImage imageNamed:self.categoryImg[indexPath.row]];
    
    [image drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
     */
    
    cell.imageView.image = [UIImage imageNamed:self.categoryImg[indexPath.row]];
    cell.imageView.autoresizingMask = UIViewAutoresizingNone;
    //NSLog(@"%@",self.categoryList[indexPath.row]);
    //cell.imageView.image = nil;
    cell.imageView.contentMode = UIViewContentModeCenter;
    cell.imageView.contentScaleFactor=2.0f;
    return cell;
}

//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    self.routeType = (NSString*)[self.data objectAtIndex:indexPath.row];
//}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    businessViewController *busiview = [segue destinationViewController];
    
    NSIndexPath *selectedr= [[self categoryTBView] indexPathForSelectedRow];
    busiview.category = self.categoryList[selectedr.row];
    
}
- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryList count];
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
