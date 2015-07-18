//
//  ExpensesIncomeMasterViewController.m
//  Finance Budget
//
//  Created by Kristian Matthews on 14/06/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import "ExpensesIncomeMasterViewController.h"
#import "ExpensesIncomeDetailViewController.h"
#import "AddExpenseIncomeViewController.h"
#import "Expense.h"
#import "Income.h"

@interface ExpensesIncomeMasterViewController ()

@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation ExpensesIncomeMasterViewController

- (instancetype)init {
	self = [super init];

	id delegate = [[UIApplication sharedApplication] delegate];
	self.managedObjectContext = [delegate managedObjectContext];
	self.settings = [delegate settings];

	return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
	id delegate = [[UIApplication sharedApplication] delegate];
	self.managedObjectContext = [delegate managedObjectContext];
	self.settings = [delegate settings];

	self.dateFormatter = [[NSDateFormatter alloc] init];

	self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
	self.dateFormatter.dateStyle = NSDateFormatterLongStyle;

    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    self.detailViewController = (ExpensesIncomeDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
	_fetchedResultsController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)passHolderBack:(ExpenseIncomeHolder *)holder {
    [self insertNewObject:holder];
}

- (void)insertNewObject:(ExpenseIncomeHolder *)holder {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];

	Expense *newExpenseManagedObject;
	Income *newIncomeManagedObject;

	switch (self.tab.tab) {
		case FBTabExpenses:
			newExpenseManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];

			newExpenseManagedObject.amount = holder.amount;
			newExpenseManagedObject.timestamp = holder.timestamp;
			newExpenseManagedObject.transaction = holder.transaction;
			newExpenseManagedObject.category = holder.category;

			break;

		case FBTabIncome:
			newIncomeManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];

			newIncomeManagedObject.amount = holder.amount;
			newIncomeManagedObject.timestamp = holder.timestamp;
			newIncomeManagedObject.transaction = holder.transaction;
			newIncomeManagedObject.category = holder.category;

			break;

		default:
			break;
	}

    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		// abort();
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        ExpensesIncomeDetailViewController *controller = (ExpensesIncomeDetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }

    if ([[segue identifier] isEqualToString:@"addExpense"]) {
        AddExpenseIncomeViewController *controller = (AddExpenseIncomeViewController *)[[segue destinationViewController] topViewController];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;

        controller.delegate = self;
		controller.tab = self.tab;

		controller.title = self.tab.addTitle;
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

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];

	Expense *expense = [sectionInfo objects][0];

	if ([self.settings.getSortKey isEqualToString:FBSortDate]) return [self.dateFormatter stringFromDate:expense.timestamp];
	if ([self.settings.getSortKey isEqualToString:FBSortCategory]) return expense.category.category;
	if ([self.settings.getSortKey isEqualToString:FBSortAmount]) return [NSString stringWithFormat:@"%@", [self.settings.getCurrency.currencyFormatter stringFromNumber:expense.amount]];

	return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

	// Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			// abort();
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Expense *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = object.transaction;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.settings.getCurrency.currencyFormatter stringFromNumber:object.amount]];
}

#pragma mark - Fetched Results Controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.tab.entityForName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:self.settings.getSortKey ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:self.settings.getSortKey cacheName:[NSString stringWithFormat:@"%@%@", self.tab.cacheName, self.settings.getSort.cacheName]];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		// abort();
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

@end