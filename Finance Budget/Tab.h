//
//  Tab.h
//  Finance Budget
//
//  Created by Kristian Matthews on 03/07/2015.
//  Copyright © 2015 Kristian Matthews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FB.h"

@interface Tab : NSObject

@property FBTab tab;

- (NSString *)masterTitle;
- (NSString *)detailTitle;
- (NSString *)addTitle;
- (NSString *)entityForName;
- (NSString *)predicate;
- (NSString *)cacheName;

@end