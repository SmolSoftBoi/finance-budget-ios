//
//  AppDelegate.h
//  Finance Budget
//
//  Created by Kristian Matthews on 13/06/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Settings.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// Settings object
@property (nonatomic, strong) Settings *settings;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end