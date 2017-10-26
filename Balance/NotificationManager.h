//
//  NotificationManager.h
//  Balance
//
//  Created by Andrew on 2017-10-25.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Balance+CoreDataModel.h"


@interface NotificationManager : NSObject

@property (strong, nonatomic) NSFetchedResultsController<MoodLog *> *fetchedResultsController;

+ (instancetype)sharedNotificationManager;

+ (void)requestMoodLog;

@end
