//
//  NotificationManager.m
//  Balance
//
//  Created by Andrew on 2017-10-25.
//

#import "NotificationManager.h"


@implementation NotificationManager

+ (instancetype)sharedNotificationManager {
    static NotificationManager *theNotificationManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theNotificationManager = [self new];
    });
    return theNotificationManager;
}

+ (void)requestMoodLog {
    NSLog(@"request fired");
    [[NotificationManager sharedNotificationManager] createMoodLog];
    
}

- (void)createMoodLog {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    MoodLog *newMoodLog = [[MoodLog alloc] initWithContext:context];
    
    // If appropriate, configure the new managed object.
    newMoodLog.timestamp = [NSDate date];
    
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}





@end
