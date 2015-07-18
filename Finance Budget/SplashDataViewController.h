//
//  SplashDataViewController.h
//  Finance Budget
//
//  Created by Kristian Matthews on 01/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface SplashDataViewController : UIViewController

@property (strong, nonatomic) id dataObject;

@property (nonatomic, strong) Settings *settings;

@end