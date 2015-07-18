//
//  SettingsCategoriesViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 27/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "SettingsCategoriesViewController.h"
#import "SettingsCategoryViewController.h"
#import "AddCategoryViewController.h"
#import "FinanceCategory.h"

@interface SettingsCategoriesViewController ()

@end

@implementation SettingsCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	id delegate = [[UIApplication sharedApplication] delegate];
	self.managedObjectContext = [delegate managedObjectContext];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCategory:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)passCategoryDataBack:(FinanceCategory *)category {
	[self updateObject:category];
}

- (void)passCategoryHolderBack:(FinanceCategoryHolder *)holder {
	[self insertNewObject:holder];
}

- (void)insertNewObject:(FinanceCategoryHolder *)category {
	NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
	NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
	FinanceCategory *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];

	newManagedObject.category = category.category;
	newManagedObject.expense = category.expense;
	newManagedObject.income = category.income;

	// Save the context.
	NSError *error = nil;
	if (![context save:&error]) {
		// Replace this implementation with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		// abort();
	}
}

- (void)updateObject:(FinanceCategory *)category {
	NSManagedObjectContext *context = category.managedObjectContext;

	// Save the context.
	NSError *error = nil;
	if (![context save:&error]) {
		// Replace this implementation with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		// abort();
	}
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
	return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    // Configure the cell...
	[self configureCell:cell atIndexPath:indexPath];

	return cell;
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
	FinanceCategory *object = [self.fetchedResultsController objectAtIndexPath:indexPath];

	cell.textLabel.text = object.category;
}

#pragma mark - Navigation & Segues

- (void)addCategory:(id)sender {
	[self performSegueWithIdentifier:@"addCategory" sender:sender];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

	if ([[segue identifier] isEqualToString:@"showCategory"]) {
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		FinanceCategory *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
		SettingsCategoryViewController *controller = (SettingsCategoryViewController *)[segue destinationViewController];
		[controller setDetailItem:object];

		controller.delegate = self;
	}

	if ([[segue identifier] isEqualToString:@"addCategory"]) {
		AddCategoryViewController *controller = (AddCategoryViewController *)[segue destinationViewController];

		controller.delegate = self;
	}
}

#pragma mark - Fetched Results Controller

- (NSFetchedResultsController *)fetchedResultsController
{
	if (_fetchedResultsController != nil) {
		return _fetchedResultsController;
	}

	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"FinanceCategory" inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];

	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];

	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"category" ascending:YES];
	NSArray *sortDescriptors = @[sortDescriptor];

	[fetchRequest setSortDescriptors:sortDescriptors];

	// Edit the section name key path and cache name if appropriate.
	// nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Categories"];
	aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;

	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
		// Replace this implementation with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		//abort();
	}

	return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
	[self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;

		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;

		default:
			return;
	}
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
	UITableView *tableView = self.tableView;

	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;

		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;

		case NSFetchedResultsChangeUpdate:
			[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
			break;

		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	[self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.

 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

@end