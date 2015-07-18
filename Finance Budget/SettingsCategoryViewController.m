//
//  SettingsCategoryViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 27/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "SettingsCategoryViewController.h"

@interface SettingsCategoryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *categoryCellTextField;
@property (weak, nonatomic) IBOutlet UISwitch *expenseCellSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *incomeCellSwitch;
@property (weak, nonatomic) IBOutlet UITableViewCell *deleteCell;

@end

@implementation SettingsCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

	[self configureView];

	self.categoryCellTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
	[self passDataBack];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];

	return YES;
}

- (IBAction)categoryCellTextFieldEditingChanged:(id)sender {
	self.detailItem.category = self.categoryCellTextField.text;

	[self configureView];
}

- (void)passDataBack {
	self.detailItem.category = self.categoryCellTextField.text;
	self.detailItem.expense = [NSNumber numberWithBool:self.expenseCellSwitch.on];
	self.detailItem.income = [NSNumber numberWithBool:self.incomeCellSwitch.on];

	[self.delegate passCategoryDataBack:self.detailItem];
}

- (void)deleteObject:(FinanceCategory *)category {
	NSManagedObjectContext *context = category.managedObjectContext;

	[context deleteObject:category];

	// Save the context.
	NSError *error = nil;
	if (![context save:&error]) {
		// Replace this implementation with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}
}

#pragma mark - Managing the Detail Item

- (void)setDetailItem:(FinanceCategory *)newDetailItem {
	if (_detailItem != newDetailItem) {
		_detailItem = newDetailItem;
	}
}

- (void)configureView {
	// Update the user interface for the detail item.
	if (self.detailItem) {
		self.title = self.detailItem.category;
		self.categoryCellTextField.text = self.detailItem.category;
		self.expenseCellSwitch.on = [self.detailItem.expense boolValue];
		self.incomeCellSwitch.on = [self.detailItem.income boolValue];

		if ([self.detailItem.expenses count] > 0) self.expenseCellSwitch.enabled = NO;
		if ([self.detailItem.incomes count] > 0) self.incomeCellSwitch.enabled = NO;

		if ([self.detailItem.expenses count] > 0 || [self.detailItem.incomes count] > 0) self.deleteCell.hidden = YES;
	}
}

#pragma mark - Table View Data Source

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

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

	if ([cell.reuseIdentifier isEqual:@"DeleteCell"]) {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
		UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete Category" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
			[self deleteObject:self.detailItem];

			[self.navigationController popViewControllerAnimated:YES];
		}];

		[alert addAction:cancelAction];
		[alert addAction:deleteAction];

		[self presentViewController:alert animated:YES completion:nil];
	}
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end