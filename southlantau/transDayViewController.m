//
//  transDayViewController.m
//  southlantau
//
//  Created by Mac on 23/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import "transDayViewController.h"
#import "timeTableViewController.h"
@interface transDayViewController ()

@end

@implementation transDayViewController

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
    if([self.transType isEqualToString:@"Ferry"] && self.tranRouteId!=1)
        self.dayList = [[NSArray alloc] initWithObjects:@"Monday to Sunday",nil];
    else
        self.dayList = [[NSArray alloc] initWithObjects:@"Monday to Saturday",@"Sunday and Public Holiday",nil];
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Billabong" size:25];
    titleView.text = self.transRoute;
    titleView.shadowColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    titleView.shadowOffset = CGSizeMake(0.0f, 1.0f);
    titleView.textColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];; // Your color here
    
    self.navigationItem.titleView = titleView;
    
    [titleView sizeToFit];
    
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    timeTableViewController *recordView1 = [segue destinationViewController];
    recordView1.transType = self.transType;
    NSIndexPath *selectedr= [[self transdaylist] indexPathForSelectedRow];
    
    recordView1.transRouteId = self.tranRouteId;
    recordView1.transDayType = selectedr.row + 1;
    recordView1.transDayText = self.dayList[selectedr.row];
    //recordView1.rType = self.routeType;
    
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
    cell = [tableView dequeueReusableCellWithIdentifier:@"transdaycell" forIndexPath:indexPath];
    cell.textLabel.text = self.dayList[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"Bariol" size:20];
    return cell;
}

//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    self.routeType = (NSString*)[self.data objectAtIndex:indexPath.row];
//}


- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dayList count];
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
