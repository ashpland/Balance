//
//  DetailViewController.m
//  Balance
//
//  Created by Andrew on 2017-10-25.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSString *moodLevelString;
        switch (self.detailItem.moodLevel) {
            case 0:
                moodLevelString = @"Low";
                break;
            case 1:
                moodLevelString = @"Balanced";
                break;
            case 2:
                moodLevelString = @"High";
                break;
            default:
                break;
        }
        
        self.detailDescriptionLabel.text = [NSString stringWithFormat:@"%@ - %@", moodLevelString, self.detailItem.timestamp.description];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(MoodLog *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}


@end
