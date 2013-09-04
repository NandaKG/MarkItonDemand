//
//  StockValues.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 9/3/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "StockValues.h"

@implementation StockValues
#define minKey @"min"
#define maxKey @"max"
#define valuesKey @"values"

- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        
        if ([dict objectForKey:minKey]) {
            self.min =   [dict objectForKey:minKey];
        }else{
            self.min = @0;
        }
        
        if ([dict objectForKey:maxKey]) {
            self.max =   [dict objectForKey:maxKey];
        }else{
            self.max = @0;
        }
        if ([dict objectForKey:valuesKey]) {
            self.values =   [dict objectForKey:valuesKey];
        }else{
            self.values = [NSArray array];
        }
    }
    return self;
}

@end
