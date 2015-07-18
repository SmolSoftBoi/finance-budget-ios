//
//  SettingsCurrencyViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 26/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "SettingsCurrencyViewController.h"
#import "SettingsViewController.h"
#import "Currency.h"

@interface SettingsCurrencyViewController ()

@property NSMutableArray *currencyCodes;

@end

@implementation SettingsCurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	id delegate = [[UIApplication sharedApplication] delegate];
	self.settings = [delegate settings];

    // Uncomment the following line to preserve selection between presentations.
	//self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

	self.currencyCodes = [[NSMutableArray alloc] init];

	[self.currencyCodes addObjectsFromArray:[[NSLocale commonISOCurrencyCodes] sortedArrayUsingFunction:currencySort context:NULL]];
	[self.currencyCodes removeObject:[[NSLocale currentLocale] objectForKey:NSLocaleCurrencyCode]];
	[self.currencyCodes insertObject:[[NSLocale currentLocale] objectForKey:NSLocaleCurrencyCode] atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

NSInteger currencySort(id currencyCode1, id currencyCode2, void *context)
{
	Currency *object1 = [Currency alloc];
	Currency *object2 = [Currency alloc];

	object1.code = currencyCode1;
	object2.code = currencyCode2;

	return [object1.currency compare:object2.currency];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return 1;
			break;

		case 1:
			return self.currencyCodes.count;
			break;

		default:
			return 0;
			break;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;

	Currency *object = [Currency alloc];

	switch (indexPath.section) {
		case 0:
			cell = [tableView dequeueReusableCellWithIdentifier:@"SelectedCell" forIndexPath:indexPath];
			break;

		case 1:
		default:
			object.code = self.currencyCodes[indexPath.row];

			if (self.settings.getCurrencyCode == object.code) {
				cell = [tableView dequeueReusableCellWithIdentifier:@"SelectedCell" forIndexPath:indexPath];
			} else {
				cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
			}

			break;
	}

    // Configure the cell...
	[self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
	Currency *object = [Currency alloc];

	switch (indexPath.section) {
		case 1:
			object.code = self.currencyCodes[indexPath.row];
			break;

		case 0:
		default:
			[self.navigationController popViewControllerAnimated:YES];
			break;
	}

	[self.settings setCurrencyCode:object.code];

	[self.navigationController popViewControllerAnimated:YES];
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

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	Currency *object = [Currency alloc];

	switch (indexPath.section) {
		case 0:
			object.code = self.settings.getCurrencyCode;
			break;

		default:
			object.code = self.currencyCodes[indexPath.row];
			break;
	}

	cell.textLabel.text = object.currency;
	cell.detailTextLabel.text = object.symbol;
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