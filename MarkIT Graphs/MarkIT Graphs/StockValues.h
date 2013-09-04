//
//  StockValues.h
//  MarkIT Graphs
//
//  Created by Nanda kishore on 9/3/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockValues : NSObject

@property(nonatomic, strong)NSNumber *min;
@property(nonatomic, strong)NSNumber *max;
@property(nonatomic, strong)NSArray *values;

- (id)initWithDict:(NSDictionary*)dict;
@end
