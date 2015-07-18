//
//  AddExpenseIncomeCategoryViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 26/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FinanceCategory.h"
#import "Tab.h"

@protocol AddExpenseIncomeCategoryDataDelegate <NSObject>

@required -(void)passCategoryDataBack:(FinanceCategory *)category;

@end

@interface AddExpenseIncomeCategoryViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) id <AddExpenseIncomeCategoryDataDelegate> delegate;

@property (nonatomic, strong) Tab *tab;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end