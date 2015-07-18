//
//  RepeatSpan+CoreDataProperties.h
//  Finance Budget
//
//  Created by Kristian Matthews on 26/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "RepeatSpan.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepeatSpan (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *span;
@property (nullable, nonatomic, retain) NSSet<Expense *> *expenses;
@property (nullable, nonatomic, retain) NSSet<Income *> *incomes;

@end

@interface RepeatSpan (CoreDataGeneratedAccessors)

- (void)addExpensesObject:(Expense *)value;
- (void)removeExpensesObject:(Expense *)value;
- (void)addExpenses:(NSSet<Expense *> *)values;
- (void)removeExpenses:(NSSet<Expense *> *)values;

- (void)addIncomesObject:(Income *)value;
- (void)removeIncomesObject:(Income *)value;
- (void)addIncomes:(NSSet<Income *> *)values;
- (void)removeIncomes:(NSSet<Income *> *)values;

@end

NS_ASSUME_NONNULL_END
