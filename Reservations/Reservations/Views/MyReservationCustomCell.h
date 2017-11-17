//
//  MyReservationCustomCell.h
//  Reservations
//
//  Created by Vishal on 11/16/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyReservationCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *reservationLabel;
@property (weak, nonatomic) IBOutlet UILabel *reservationNameLabel;

@end
