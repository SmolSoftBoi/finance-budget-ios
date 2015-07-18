//
//  SummaryViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 02/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Settings.h"

@interface SummaryViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) Settings *settings;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end