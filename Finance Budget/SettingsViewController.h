//
//  SettingsViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 13/06/2015.
//  Copyright (c) 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface SettingsViewController : UITableViewController

@property (nonatomic, strong) Settings *settings;

@property (weak, nonatomic) IBOutlet UITableViewCell *currencyCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *sortCell;

@end