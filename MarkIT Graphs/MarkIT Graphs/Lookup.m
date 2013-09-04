//
//  Lookup.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/27/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "Lookup.h"
//REUSABLE KEYS
#define exchangeKey @"Exchange"
#define nameKey @"Name"
#define symbolKey @"Symbol"

@implementation Lookup
@synthesize name;
@synthesize symbol;
@synthesize exchange;
-(id)initCompanyLookupDictionary:(NSDictionary*)lookupDict
{
    self = [super init];
    if(self)
    {
        if ([lookupDict objectForKey:exchangeKey]) {
            self.exchange =   [lookupDict objectForKey:exchangeKey];
        }else{
            self.exchange = exchangeKey;
        }
        if ([lookupDict objectForKey:nameKey]) {
            self.name =   [lookupDict objectForKey:nameKey];
        }else{
            self.name = nameKey;
        }
        if ([lookupDict objectForKey:symbolKey]) {
            self.symbol =   [lookupDict objectForKey:symbolKey];
        }else{
            self.symbol = symbolKey;
        }

    }
    return self;
}
@end
