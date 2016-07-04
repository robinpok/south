//
//  transportViewController.m
//  southlantau
//
//  Created by Mac on 22/10/14.
//  Copyright (c) 2014 com.gerard.Mylife. All rights reserved.
//

#import "transportViewController.h"
#import "transportfirstViewController.h"

@interface transportViewController ()

@end

@implementation transportViewController

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
    self.data = [[NSArray alloc] initWithObjects:@"Bus",@"Ferry",@"Taxi",nil];
    
//    [self.transportlist registerClass:[UITableViewCell class] forCellReuseIdentifier:@"translistcell"];
    self.transportlist.backgroundColor = [UIColor clearColor];
    
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.font = [UIFont fontWithName:@"Billabong" size:25];
    titleView.text = @"Transport Info";
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
-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView{
    return 1;
}
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"translistcell" forIndexPath:indexPath];
    
    
    /*
    CGSize itemsize = CGSizeMake(32, 32);
    UIGraphicsBeginImageContext(itemsize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemsize.width, itemsize.height);
    
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.data[indexPath.row]]];
    
    [image drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    */

    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.data[indexPath.row]]];
/*
    if(indexPath.row % 3==0)
        cell.imageView.image = [UIImage imageNamed:@"Kids1.png"];
    else if(indexPath.row % 3==1)
        cell.imageView.image = [UIImage imageNamed:@"Bakery1.png"];
    else
        cell.imageView.image = [UIImage imageNamed:@"Announcements.png"];
*/
//    cell.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    cell.textLabel.text = self.data[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Bariol" size:20];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.contentMode = UIViewContentModeCenter;
    cell.imageView.contentScaleFactor=2.0f;
    return cell;
}
/*
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.routeType = self.data[indexPath.row];
    
}*/

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    transportfirstViewController *recordView = [segue destinationViewController];
    NSIndexPath *selected = [[self transportlist] indexPathForSelectedRow];
    recordView.rType = self.data[selected.row];
}
- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
    UIImage* img = [UIImage imageNamed:@"controls_play_back_32.png"];    //[UIImage imageWithContentsOfFile:@"bac"]
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(onBack:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.18 green:0.68 blue:0.14 alpha:1];;
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
