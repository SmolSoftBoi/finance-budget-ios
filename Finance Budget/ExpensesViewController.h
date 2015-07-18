//
//  ExpensesViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 13/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpensesViewController : UISplitViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end