//
//  MyCalendarCollectionViewCell.h
//  Reservations
//
//  Created by Vishal on 11/16/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCalendarCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIView *calendarCellView;
@property (weak, nonatomic) IBOutlet UIImageView *calendarCheckImg;

@end
