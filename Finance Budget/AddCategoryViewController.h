//
//  AddCategoryViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 29/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinanceCategoryHolder.h"

@protocol AddCategoryHolderDelegate <NSObject>

@required -(void)passCategoryHolderBack:(FinanceCategoryHolder *)category;

@end

@interface AddCategoryViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <AddCategoryHolderDelegate> delegate;

@end