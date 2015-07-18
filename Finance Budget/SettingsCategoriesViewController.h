//
//  SettingsCategoriesViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 27/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SettingsCategoryViewController.h"
#import "AddCategoryViewController.h"

@class SettingsCategoryViewController;

@interface SettingsCategoriesViewController : UITableViewController <NSFetchedResultsControllerDelegate, CategoryDataDelegate, AddCategoryHolderDelegate>

@property (strong, nonatomic) SettingsCategoryViewController *settingsCategoryViewController;
@property (strong, nonatomic) AddCategoryViewController *addCategoryViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end