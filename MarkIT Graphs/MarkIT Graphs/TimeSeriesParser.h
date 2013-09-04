//
//  TimeSeriesParser.h
//  MarkIT Graphs
//
//  Created by Nanda kishore on 9/3/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lookup.h"
#import "TimeSeries.h"

@interface TimeSeriesParser : NSObject
@property(nonatomic,strong) Lookup *companyObject;
-(id)initCompanyObject:(Lookup*)object;
-(void)loadTimeSeriesJSONDataDone:(void (^)(TimeSeries *companyTimeSeries))parse_success NotDone:(void (^)(NSString *error))parse_failure;
@end
