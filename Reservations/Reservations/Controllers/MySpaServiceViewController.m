//
//  MySpaServiceViewController.m
//  Reservations
//
//  Created by Vishal on 11/16/17.
//  Copyright © 2017 Vishal. All rights reserved.
//

#import "MySpaServiceViewController.h"
#import "MyScheduleViewController.h"

@interface MySpaServiceViewController ()
@property (weak, nonatomic) IBOutlet UITableView *spaTableView;

@property (strong, nonatomic) NSMutableArray *serviceArray;
@property (strong, nonatomic) NSMutableArray *imageArray;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *imgScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (assign) NSInteger scrollTotalSize;
@property (weak, nonatomic) IBOutlet UIButton *reserveButton;
@end

@implementation MySpaServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Arrays to retain Services and Images
    self.serviceArray = [[NSMutableArray alloc] initWithObjects:@"Swedish Massage",@"Deep Tissue Massage", @"Hot Stone Massage",@"Reflexology",@"Trigger Point Therapy", nil];
    
    self.imageArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"motherDay"],[UIImage imageNamed:@"hotstonesmassage"],[UIImage imageNamed:@"deepTissue"],[UIImage imageNamed:@"motherDay"],nil];
    
    
    self.spaTableView.layer.cornerRadius = 5.0;
    
    [self.view bringSubviewToFront:self.pageControl];
    [self.view bringSubviewToFront:self.spaTableView];
    [self.view bringSubviewToFront:self.reserveButton];
    
    for(int i = 0; i < _imageArray.count; i++)
    {
        CGRect frame;
        frame.origin.x = _imgScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = _imgScrollView.frame.size;
        UIImageView* imgView = [[UIImageView alloc] init];
        imgView.image = [_imageArray objectAtIndex:i];
        imgView.frame = frame;
        [_imgScrollView addSubview:imgView];
    }
    _scrollTotalSize = [_imageArray count]*[UIScreen mainScreen].bounds.size.width;
}

- (void)viewDidLayoutSubviews
{
    dispatch_async (dispatch_get_main_queue(), ^
                    {
                        _imgScrollView.contentSize = CGSizeMake(_scrollTotalSize, _imageView.frame.size.height);
                    });
}

/**
 * Action handler - Page Control
 */

- (IBAction)changeImage:(id)sender
{
    CGRect frame;
    frame.origin.x = self.imgScrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.imgScrollView.frame.size;
    [self.imgScrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark TableView Methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *spaTableIdentifier = @"SpaTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:spaTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:spaTableIdentifier];
    }
    
    cell.textLabel.text = [self.serviceArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"helvetica neue" size:12.0f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"ScheduleVC" sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ScrollView Methods

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = [UIScreen mainScreen].bounds.size.width;
//    int page = floor((_imgScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    _pageControl.currentPage = page;
    float page = self.imgScrollView.contentOffset.x/pageWidth;
    NSInteger currentPage = lround(page);
    self.pageControl.currentPage = currentPage;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    // The key is repositioning without animation
//    if (_imgScrollView.contentOffset.x == 0) {
//        // user is scrolling to the left from image 1 to image 10.
//        // reposition offset to show image 10 that is on the right in the scroll view
//        [_imgScrollView scrollRectToVisible:CGRectMake(_scrollTotalSize,0,[UIScreen mainScreen].bounds.size.width,_imageView.frame.size.height) animated:NO];
//    }
//    else
        if (_imgScrollView.contentOffset.x == [UIScreen mainScreen].bounds.size.width*3) {
        // user is scrolling to the right from image 10 to image 1.
        // reposition offset to show image 1 that is on the left in the scroll view
        [_imgScrollView scrollRectToVisible:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,_imageView.frame.size.height) animated:NO];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ScheduleVC"]) {
        //Pass data to ScheduleVC
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
