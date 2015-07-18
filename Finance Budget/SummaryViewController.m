//
//  SummaryViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 02/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "SummaryViewController.h"
#import "ExpensesIncomeMasterViewController.h"
#import "Tab.h"

@interface SummaryViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *expensesCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *incomeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *totalCell;

@property (nonatomic) NSString *entityForName;

@end

@implementation SummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	id delegate = [[UIApplication sharedApplication] delegate];
	self.managedObjectContext = [delegate managedObjectContext];
	self.settings = [delegate settings];

	ExpensesIncomeMasterViewController *controller = [[ExpensesIncomeMasterViewController alloc] init];

	Tab *tab = [Tab alloc];

	tab.tab = FBTabExpenses;

	controller.tab = tab;

	NSNumber *expensesTotal = [NSNumber numberWithDouble:[[controller.fetchedResultsController.fetchedObjects valueForKeyPath:@"@sum.amount"] doubleValue]];

	controller.fetchedResultsController = nil;

	tab.tab = FBTabIncome;

	controller.tab = tab;

	NSNumber *incomeTotal = [NSNumber numberWithDouble:[[controller.fetchedResultsController.fetchedObjects valueForKeyPath:@"@sum.amount"] doubleValue]];

	NSNumber *total = [NSNumber numberWithDouble:incomeTotal.doubleValue - expensesTotal.doubleValue];

	self.expensesCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.settings.getCurrency.currencyFormatter stringFromNumber:expensesTotal]];
	self.incomeCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.settings.getCurrency.currencyFormatter stringFromNumber:incomeTotal]];
	self.totalCell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.settings.getCurrency.currencyFormatter stringFromNumber:total]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end