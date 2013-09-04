//
//  TimeSeries.h
//  MarkIT Graphs
//
//  Created by Nanda kishore on 9/3/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lookup.h"
#import "StockValues.h"
@interface TimeSeries : NSObject
@property(nonatomic, strong) Lookup *companyObj;
@property(nonatomic, strong)StockValues *open;
@property(nonatomic, strong)StockValues *high;
@property(nonatomic, strong)StockValues *low;
@property(nonatomic, strong)StockValues *close;
@property(nonatomic, strong)NSArray *seriesLabels;
@property(nonatomic, strong)NSArray *seriesLabelCoordinates;
@property(nonatomic, strong)NSString *seriesDuration;
@property(nonatomic, strong)NSArray *seriesDates;

-(id)initLookupObject:(Lookup*)company andTimeSeriesDictionary:(NSDictionary*)tSDict;
@end
