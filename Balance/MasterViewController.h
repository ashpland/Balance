//
//  MasterViewController.h
//  Balance
//
//  Created by Andrew on 2017-10-25.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Balance+CoreDataModel.h"
@import UserNotifications;

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController<MoodLog *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

