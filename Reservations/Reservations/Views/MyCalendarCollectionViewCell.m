//
//  MyCalendarCollectionViewCell.m
//  Reservations
//
//  Created by Vishal on 11/16/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "MyCalendarCollectionViewCell.h"
#import <IonIcons.h>

@implementation MyCalendarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIImage *checkMarkIcon = [IonIcons imageWithIcon:ion_ios_checkmark_outline
                                      iconColor:[UIColor whiteColor]
                                       iconSize:30.0f
                                      imageSize:CGSizeMake(30.0f, 30.0f)];
    self.calendarCheckImg.image = checkMarkIcon;
}

@end
