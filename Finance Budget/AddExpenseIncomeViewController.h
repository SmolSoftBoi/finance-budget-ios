//
//  AddExpenseIncomeViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 21/06/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "Tab.h"
#import "Expense.h"
#import "Income.h"
#import "AddExpenseIncomeCategoryViewController.h"

@protocol AddExpenseIncomeHolderDelegate <NSObject>

@required -(void)passHolderBack:(ExpenseIncomeHolder *)holder;

@end

@interface AddExpenseIncomeViewController : UITableViewController <AddExpenseIncomeCategoryDataDelegate>

@property (nonatomic, weak) id <AddExpenseIncomeHolderDelegate> delegate;

@property (nonatomic, strong) Settings *settings;

@property (nonatomic, strong) Tab *tab;

@end