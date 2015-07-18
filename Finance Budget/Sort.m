//
//  Sort.m
//  Finance Budget
//
//  Created by Kristian Matthews on 03/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import "Sort.h"

@implementation Sort

- (NSString *)textLabel {
	if ([self.sort isEqual:FBSortDate]) return @"Date";
	if ([self.sort isEqual:FBSortCategory]) return @"Category";
	if ([self.sort isEqual:FBSortAmount]) return @"Amount";

	return @"";
}

- (NSString *)cacheName {
	if ([self.sort isEqual:FBSortDate]) return @"Date";
	if ([self.sort isEqual:FBSortCategory]) return @"Category";
	if ([self.sort isEqual:FBSortAmount]) return @"Amount";

	return @"";
}

@end