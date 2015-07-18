//
//  FB.h
//  Finance Budget
//
//  Created by Kristian Matthews on 03/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "FBConsts.h"
#import "FBTypes.h"

typedef NS_OPTIONS(NSInteger, FBTab) {
	FBTabSummary = 1,
	FBTabExpenses = 2,
	FBTabIncome = 3,
	FBTabSettings = 4
};