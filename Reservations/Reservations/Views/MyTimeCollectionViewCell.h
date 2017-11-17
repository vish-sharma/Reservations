//
//  MyTimeCollectionViewCell.h
//  Reservations
//
//  Created by Vishal on 11/16/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTimeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *timeCellView;
@property (weak, nonatomic) IBOutlet UIImageView *timeCheckImg;
@end
