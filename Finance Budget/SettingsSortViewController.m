//
//  SettingsSortViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 26/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "SettingsSortViewController.h"
#import "SettingsViewController.h"
#import "Sort.h"

@interface SettingsSortViewController ()

@property NSMutableArray *sorts;

@end

@implementation SettingsSortViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	id delegate = [[UIApplication sharedApplication] delegate];
	self.settings = [delegate settings];

	// Uncomment the following line to preserve selection between presentations.
	//self.clearsSelectionOnViewWillAppear = NO;

	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;

	self.sorts = [[NSMutableArray alloc] init];

	[self.sorts addObject:FBSortDate];
	[self.sorts addObject:FBSortCategory];
	[self.sorts addObject:FBSortAmount];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
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
			return self.sorts.count;
			break;

		default:
			return 0;
			break;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;

	Sort *object = [Sort alloc];

	switch (indexPath.section) {
		case 0:
			cell = [tableView dequeueReusableCellWithIdentifier:@"SelectedCell" forIndexPath:indexPath];
			break;

		case 1:
		default:
			object.sort = self.sorts[indexPath.row];

			if ([self.settings.getSortKey isEqualToString:object.sort]) {
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
	Sort *object = [Sort alloc];

	switch (indexPath.section) {
		case 1:
			object.sort = self.sorts[indexPath.row];
			break;

		case 0:
		default:
			[self.navigationController popViewControllerAnimated:YES];
			break;
	}

	[self.settings setSortKey:object.sort];

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
	Sort *object = [Sort alloc];

	switch (indexPath.section) {
		case 0:
			object.sort = self.settings.getSortKey;
			break;

		default:
			object.sort = self.sorts[indexPath.row];
			break;
	}

	cell.textLabel.text = object.textLabel;
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