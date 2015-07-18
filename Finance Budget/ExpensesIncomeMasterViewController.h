//
//  ExpensesIncomeMasterViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 14/06/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AddExpenseIncomeViewController.h"
#import "Settings.h"
#import "Tab.h"

@class ExpensesIncomeDetailViewController, AddExpenseIncomeViewController;

@interface ExpensesIncomeMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, AddExpenseIncomeHolderDelegate>

@property (nonatomic, strong) Tab *tab;

@property (nonatomic, strong) Settings *settings;

@property (strong, nonatomic) ExpensesIncomeDetailViewController *detailViewController;
@property (strong, nonatomic) AddExpenseIncomeViewController *addViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end