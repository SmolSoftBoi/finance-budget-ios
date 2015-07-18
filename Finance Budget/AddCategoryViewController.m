//
//  AddCategoryViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 29/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "AddCategoryViewController.h"

@interface AddCategoryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *categoryCellTextField;
@property (weak, nonatomic) IBOutlet UISwitch *expenseCellSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *incomeCellSwitch;

@end

@implementation AddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:@selector(done:)];

	self.navigationItem.rightBarButtonItem.enabled = NO;

	self.categoryCellTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)categoryCellTextFieldEditingChanged:(id)sender {
	if (self.categoryCellTextField.text.length == 0) {
		self.navigationItem.rightBarButtonItem.enabled = NO;
	} else {
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];

	return YES;
}

- (IBAction)done:(id)sender {
	[self passHolderBack];

	[self.navigationController popViewControllerAnimated:YES];
}

- (void)passHolderBack {
	FinanceCategoryHolder* holder = [[FinanceCategoryHolder alloc] init];

	holder.category = self.categoryCellTextField.text;
	holder.expense = [NSNumber numberWithBool:self.expenseCellSwitch.on];
	holder.income = [NSNumber numberWithBool:self.incomeCellSwitch.on];

	[self.delegate passCategoryHolderBack:holder];
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