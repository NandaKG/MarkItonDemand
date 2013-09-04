//
//  Quote.h
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/29/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lookup.h"

@interface Quote : NSObject
@property(nonatomic, strong) Lookup *companyObj;
@property(nonatomic, strong) NSString *lastPrice;
@property(nonatomic, strong) NSString *change;
@property(nonatomic, strong) NSString *changePercentage;
@property(nonatomic, strong) NSString *timeStamp;
@property(nonatomic, strong) NSString *marketCap;
@property(nonatomic, strong) NSString *volume;
@property(nonatomic, strong) NSString *changeYTD;
@property(nonatomic, strong) NSString *changePercentageYTD;
@property(nonatomic, strong) NSString *high;
@property(nonatomic, strong) NSString *low;
@property(nonatomic, strong) NSString *open;
-(id)initLookupObject:(Lookup*)company andQuoteDictionary:(NSDictionary*)quoteDict;
@end
