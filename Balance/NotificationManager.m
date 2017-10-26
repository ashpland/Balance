//
//  NotificationManager.m
//  Balance
//
//  Created by Andrew on 2017-10-25.
//

#import "NotificationManager.h"
@import UserNotifications;


@interface NotificationManager ()

@property (strong, nonatomic) UNUserNotificationCenter *notificationCenter;

@end


@implementation NotificationManager

+ (instancetype)sharedNotificationManager {
    static NotificationManager *theNotificationManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theNotificationManager = [self new];
    });
    return theNotificationManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupNotificationCenter];
    }
    return self;
}

- (void)setupNotificationCenter {
    self.notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    self.notificationCenter.delegate = self;
    
    [self.notificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                          }];
    
    [self setupNotificationResponses];
    
    
    
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    completionHandler(UNNotificationPresentationOptionAlert);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    
    if ([response.notification.request.content.categoryIdentifier isEqualToString:@"REQUEST_LOG"]) {

        if ([response.actionIdentifier isEqualToString:@"HIGH_ACTION"])
        {
            [self createMoodLog:High];
        }
        else if ([response.actionIdentifier isEqualToString:@"MIDDLE_ACTION"])
        {
            [self createMoodLog:Middle];
        }
        else if ([response.actionIdentifier isEqualToString:@"LOW_ACTION"])
        {
            [self createMoodLog:Low];
        }
        
    }

    completionHandler();
}

- (void)setupNotificationResponses
{
    
    // Create the custom actions for expired timer notifications.
    UNNotificationAction *highAction = [UNNotificationAction
                                        actionWithIdentifier:@"HIGH_ACTION"
                                        title:@"▲ High"
                                        options:UNNotificationActionOptionNone];
    
    UNNotificationAction *middleAction = [UNNotificationAction
                                        actionWithIdentifier:@"MIDDLE_ACTION"
                                        title:@"● Balanced"
                                        options:UNNotificationActionOptionNone];
    
    UNNotificationAction *lowAction = [UNNotificationAction
                                        actionWithIdentifier:@"LOW_ACTION"
                                        title:@"▼ Low"
                                        options:UNNotificationActionOptionNone];
    
    // Create the category with the custom actions.
    UNNotificationCategory *requestLogCategory = [UNNotificationCategory
                                               categoryWithIdentifier:@"REQUEST_LOG"
                                               actions:@[highAction, middleAction, lowAction]
                                               intentIdentifiers:@[]
                                               options:UNNotificationCategoryOptionCustomDismissAction];
    
    // Register the notification categories.
    [self.notificationCenter setNotificationCategories:[NSSet setWithObjects:requestLogCategory,nil]];
    
}


- (void)startRegularMoodLogRequests {
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:360
                                                  repeats:YES];
    
    [self scheduleMoodLogNotificaiton:@"RepeatingMoodRequest"
                          withTrigger:trigger];
}



+ (void)requestMoodLog {
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:0.5
                                                  repeats:NO];
    
    [[NotificationManager sharedNotificationManager] scheduleMoodLogNotificaiton:@"InstantMoodRequest"
                                                                     withTrigger:trigger];
}



- (void)scheduleMoodLogNotificaiton:(NSString *)identifier
                        withTrigger:(UNTimeIntervalNotificationTrigger *)trigger
{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"How is your mood?";
//    content.body = @"This is body text";
    content.categoryIdentifier = @"REQUEST_LOG";
    content.sound = [UNNotificationSound defaultSound];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    [self.notificationCenter addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}





- (void)createMoodLog:(MoodLevel)moodLevel {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    MoodLog *newMoodLog = [[MoodLog alloc] initWithContext:context];
    
    // If appropriate, configure the new managed object.
    newMoodLog.timestamp = [NSDate date];
    newMoodLog.moodLevel = moodLevel;
    
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
