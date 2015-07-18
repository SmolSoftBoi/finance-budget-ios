//
//  SettingsCategoryViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 27/06/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinanceCategory.h"

@protocol CategoryDataDelegate <NSObject>

@required -(void)passCategoryDataBack:(FinanceCategory *)category;

@end

@interface SettingsCategoryViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <CategoryDataDelegate> delegate;

@property (strong, nonatomic) FinanceCategory *detailItem;

@end