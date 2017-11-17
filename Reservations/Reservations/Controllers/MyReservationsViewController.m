//
//  MyReservationsViewController.m
//  Reservations
//
//  Created by Vishal on 11/16/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "MyReservationsViewController.h"
#import "MyReservationCustomCell.h"
#import <IonIcons.h>

@interface MyReservationsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *reservationTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;
@property (assign)  NSInteger reservationCount;
@end

@implementation MyReservationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //ion-ios-plus-empty
    
    UIImage *plusIcon = [IonIcons imageWithIcon:ion_ios_plus_empty
                                  iconColor:[UIColor whiteColor]
                                   iconSize:30.0f
                                  imageSize:CGSizeMake(30.0f, 30.0f)];
    
    self.rightBarButton.image = plusIcon;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"ReserveNotification" object:nil];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Reservation Count
    self.reservationCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"reservationCount"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.reservationTableView reloadData];
    });
}


#pragma mark TableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.reservationCount > 0){
        return self.reservationCount+1;
    } else {
        return 1; //Default Dummy cell
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reserveTableIdentifier = @"ReservationCell";
    
    MyReservationCustomCell *cell = (MyReservationCustomCell *)[tableView dequeueReusableCellWithIdentifier:reserveTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyReservationCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if(indexPath.row != 0){
        NSMutableDictionary *cellData = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        
        cell.reservationNameLabel.text = [[cellData allValues] objectAtIndex:0];
        cell.dateLabel.text = [[cellData allValues] objectAtIndex:2];
        cell.timeLabel.text = [[cellData allValues] objectAtIndex:3];
        cell.reservationLabel.text = [[cellData allValues] objectAtIndex:4];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Notification Handler

-(void) triggerAction:(NSNotification*)notification
{
    if ([notification.name isEqualToString:@"ReserveNotification"])
    {
        NSDictionary* userInfo = notification.userInfo;
        NSLog(@"Dict %@",userInfo);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userInfo forKey:[[userInfo allValues] objectAtIndex:1]];
        [defaults synchronize];
    }
}

@end
