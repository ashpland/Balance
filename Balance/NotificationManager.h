//
//  NotificationManager.h
//  Balance
//
//  Created by Andrew on 2017-10-25.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Balance+CoreDataModel.h"
@import UserNotifications;


typedef NS_ENUM(NSUInteger, MoodLevel) {
    Low,
    Middle,
    High,
};

@interface NotificationManager : NSObject <UNUserNotificationCenterDelegate>

@property (strong, nonatomic) NSFetchedResultsController<MoodLog *> *fetchedResultsController;

+ (instancetype)sharedNotificationManager;

+ (void)requestMoodLog;

+ (void)requestScheduledNotifications;

@end
