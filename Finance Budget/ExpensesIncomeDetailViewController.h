//
//  ExpensesIncomeDetailViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 14/06/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface ExpensesIncomeDetailViewController : UITableViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, strong) Settings *settings;

@end

