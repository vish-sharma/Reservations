//
//  MyScheduleViewController.m
//  Reservations
//
//  Created by Vishal on 11/16/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "MyScheduleViewController.h"
#import "MyCalendarCollectionViewCell.h"
#import "MyTimeCollectionViewCell.h"

@interface MyScheduleViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *calendarCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *timeCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *partySizeBtn;
@property (strong, nonatomic) NSMutableArray *daysInMonth, *timeArray, *selectedDaysArray;
@property (strong, nonatomic) NSMutableDictionary *reservationDict;
@property (strong, nonatomic) NSString *selectedDay, *selectedTime, *reservationText, *reservationName;
@property (weak, nonatomic) IBOutlet UIButton *reserveBtn;
@end

@implementation MyScheduleViewController

NSUInteger numberOfDaysInMonth;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //View settings
    _partySizeBtn.layer.borderWidth=1.0f;
    _partySizeBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _partySizeBtn.layer.cornerRadius = 5.0f;
    _reserveBtn.alpha = 0.5;
    
    //Dictionary to hold reservation data
    self.reservationDict = [[NSMutableDictionary alloc] init];
    
    //Register custom collection view cell nibs.
    [self.calendarCollectionView registerNib:[UINib nibWithNibName:@"MyCalendarCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CalendarCell"];
    [self.calendarCollectionView setAllowsMultipleSelection:NO];
    
     [self.timeCollectionView registerNib:[UINib nibWithNibName:@"MyTimeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TimeCell"];
    [self.timeCollectionView setAllowsMultipleSelection:NO];
    
    [self calculateCurrentMonth];
    
    //Hardcoded data
    self.timeArray = [[NSMutableArray alloc] initWithObjects:@"9:00 AM",@"10:00 AM", @"11:00 AM",@"12:00 PM",@"1:00 PM", @"2:00 PM",@"3:00 PM",@"4:00 PM",@"5:00 PM",@"6:00 PM",@"7:00 PM",@"8:00 PM",@"9:00 PM",nil];
    self.reservationText = @"Massage focused on the deepest layer of muscles to target knots and release chronic muscle tension.";
    self.reservationName = @"Hot Stone Massage";
}

/**
 * Method to find days and dates in current month
 */
-(void) calculateCurrentMonth {
    //Days and Dates for current month
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    numberOfDaysInMonth = range.length;
    
    _daysInMonth = [[NSMutableArray alloc] init];
    _selectedDaysArray = [[NSMutableArray alloc] init];
    NSDateComponents *components = [cal components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:[NSDate date]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    for (NSInteger i = range.location; i<NSMaxRange(range); ++i) {
        [components setDay:i];
        NSDate *dayInMonth = [cal dateFromComponents:components];
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"EEE dd"];
        
        [_daysInMonth addObject: [formatter stringFromDate:dayInMonth] ]; // //dayInMonth
        
        [formatter setDateFormat:@"EEEE, MMMM dd, YYYY"];
        [_selectedDaysArray addObject:[formatter stringFromDate:dayInMonth]];
    }
    NSLog(@"array %@", _selectedDaysArray);
}

#pragma mark Collection View

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView*) collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _timeCollectionView)
        return self.timeArray.count;
    else
        return numberOfDaysInMonth;
}

- (CGSize) collectionView: (UICollectionView*)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (collectionView == _timeCollectionView)
        return CGSizeMake(80, 35);
    else
        return CGSizeMake(60, 70);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _timeCollectionView) {
        MyTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimeCell" forIndexPath:indexPath];
        cell.timeLabel.text = [_timeArray objectAtIndex:indexPath.row];
        return cell;
    }
    else {
        MyCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCell" forIndexPath:indexPath];
        cell.dayLabel.text = [_daysInMonth objectAtIndex:indexPath.row];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _timeCollectionView) {
        MyTimeCollectionViewCell *cell = (MyTimeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.timeCellView.backgroundColor = [UIColor lightGrayColor];
        cell.timeCheckImg.hidden = NO;
        _selectedTime = cell.timeLabel.text;
    } else {
        MyCalendarCollectionViewCell *cell = (MyCalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.calendarCellView.backgroundColor = [UIColor lightGrayColor];
        cell.calendarCheckImg.hidden = NO;
        _selectedDay = [_selectedDaysArray objectAtIndex: indexPath.row];
    }
    
    if((_selectedDay != nil) && (_selectedTime != nil)){
        _reserveBtn.userInteractionEnabled = YES;
        _reserveBtn.alpha = 1.0f;
        [_reservationDict setObject:_selectedDay forKey:@"day"];
        [_reservationDict setObject:_selectedTime forKey:@"time"];
        [_reservationDict setObject:_reservationText forKey:@"reservation"];
        [_reservationDict setObject:_reservationName forKey:@"reservationName"];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == _timeCollectionView) {
        MyTimeCollectionViewCell *cell = (MyTimeCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.timeCellView.backgroundColor = [UIColor whiteColor];
        cell.timeCheckImg.hidden = YES;
    } else {
        MyCalendarCollectionViewCell *cell = (MyCalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.calendarCellView.backgroundColor = [UIColor whiteColor];
        cell.calendarCheckImg.hidden = YES;
    }
    
}

#pragma mark Reserve Action

- (IBAction)reserveBtnAction:(id)sender {
    
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"reservationCount"];
    count = count+1;
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"reservationCount"];
    [self.reservationDict setObject:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"reservationIndex"];
     [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"ReserveNotification" object:self userInfo:self.reservationDict];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
