//
//  MyTimeCollectionViewCell.m
//  Reservations
//
//  Created by Vishal on 11/16/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "MyTimeCollectionViewCell.h"
#import <IonIcons.h>

@implementation MyTimeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImage *checkMarkIcon = [IonIcons imageWithIcon:ion_ios_checkmark_outline
                                           iconColor:[UIColor whiteColor]
                                            iconSize:30.0f
                                           imageSize:CGSizeMake(28.0f, 28.0f)];
    self.timeCheckImg.image = checkMarkIcon;
}

@end
