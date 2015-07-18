//
//  AddExpenseIncomeViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 21/06/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import "AddExpenseIncomeViewController.h"
#import "FinanceCategory.h"

@interface AddExpenseIncomeViewController ()

@property (strong, nonatomic) FinanceCategory *category;

@property (weak, nonatomic) IBOutlet UITableViewCell *categoryCell;
@property (weak, nonatomic) IBOutlet UITextField *amountCellTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionCellTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateCellLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerCellDatePicker;

@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation AddExpenseIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	id delegate = [[UIApplication sharedApplication] delegate];
	self.settings = [delegate settings];

	self.dateFormatter = [[NSDateFormatter alloc] init];

	self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
	self.dateFormatter.dateStyle = NSDateFormatterLongStyle;

	self.categoryCell.detailTextLabel.text = @"";

	self.amountCellTextField.placeholder = [NSString stringWithFormat:@"%@", [self.settings.getCurrency.currencyFormatter stringFromNumber:[NSNumber numberWithInt:0]]];

	[self datePickerCellDatePickerEditingChanged:self.datePickerCellDatePicker];

	if (self.settings.getCurrency.formatter.maximumFractionDigits == 0) {
		self.amountCellTextField.keyboardType = UIKeyboardTypeNumberPad;
	} else {
		self.amountCellTextField.keyboardType = UIKeyboardTypeDecimalPad;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)amountCellTextFieldEditingChanged:(UITextField *)sender {}

- (IBAction)datePickerCellDatePickerEditingChanged:(UIDatePicker *)sender {
	self.dateCellLabel.text = [NSString stringWithFormat:@"%@", [self.dateFormatter stringFromDate:sender.date]];
}

- (IBAction)done:(id)sender {
	[self passHolderBack];

	[self.navigationController popViewControllerAnimated:YES];
}

- (void)passCategoryDataBack:(FinanceCategory *)category {
	self.categoryCell.detailTextLabel.text = category.category;

	self.category = category;
}

- (void)passHolderBack {
	ExpenseIncomeHolder* holder = [[ExpenseIncomeHolder alloc] init];

    holder.amount = [NSDecimalNumber decimalNumberWithString:self.amountCellTextField.text];
    holder.timestamp = self.datePickerCellDatePicker.date;
    holder.transaction = self.descriptionCellTextField.text;
	holder.category = self.category;

	[self.delegate passHolderBack:holder];
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	#warning Incomplete implementation, return the number of sections
	return 0;
}
 */

/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	#warning Incomplete implementation, return the number of rows
	return 0;
}
 */

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];

 // Configure the cell...

 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	AddExpenseIncomeCategoryViewController *controller = (AddExpenseIncomeCategoryViewController *)[segue destinationViewController];

	controller.delegate = self;

	controller.tab = self.tab;
}

@end