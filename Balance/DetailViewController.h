//
//  DetailViewController.h
//  Balance
//
//  Created by Andrew on 2017-10-25.
//

#import <UIKit/UIKit.h>
#import "Balance+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

