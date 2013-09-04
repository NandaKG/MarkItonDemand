//
//  Quote.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/29/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "Quote.h"
//REUSABLE KEYS
#define lastPriceKey @"LastPrice"
#define changeKey @"Change"
#define changePercentageKey @"ChangePercent"
#define timeStampKey @"Timestamp"
#define marketCapKey @"MarketCap"
#define volumeKey @"Volume"
#define changeYTDKey @"ChangeYTD"
#define changeYTDPercentageKey @"ChangePercentYTD"
#define highKey @"High"
#define lowKey @"Low"
#define openKey @"Open"

@implementation Quote
@synthesize lastPrice;
@synthesize change;
@synthesize changeYTD;
@synthesize changePercentage;
@synthesize changePercentageYTD;
@synthesize timeStamp;
@synthesize marketCap;
@synthesize volume;
@synthesize high,low,open;

-(id)initLookupObject:(Lookup*)company andQuoteDictionary:(NSDictionary*)quoteDict
{
    self = [super init];
    if (self) {
        if (company) {
            self.companyObj = company;
        }
        if ([quoteDict objectForKey:lastPriceKey]) {
            self.lastPrice =  [NSString stringWithFormat:@"%@", [quoteDict objectForKey:lastPriceKey]];;
        }else{
            self.lastPrice = lastPriceKey;
        }
        
        if ([quoteDict objectForKey:changeKey]) {
            self.change =   [NSString stringWithFormat:@"%@", [quoteDict objectForKey:changeKey]];
        }else{
            self.change = changeKey;
        }
        
        if ([quoteDict objectForKey:changePercentageKey]) {
            self.changePercentage =   [NSString stringWithFormat:@"%@", [quoteDict objectForKey:changePercentageKey]];
        }else{
            self.changePercentage = changePercentageKey;
        }
        
        if ([quoteDict objectForKey:timeStampKey]) {
            self.timeStamp =   [quoteDict objectForKey:timeStampKey];
        }else{
            self.timeStamp = timeStampKey;
        }
        
        if ([quoteDict objectForKey:marketCapKey]) {
            self.marketCap =   [NSString stringWithFormat:@"%@", [quoteDict objectForKey:marketCapKey]];
        }else{
            self.marketCap = marketCapKey;
        }
        
        if ([quoteDict objectForKey:volumeKey]) {
            self.volume =   [NSString stringWithFormat:@"%@", [quoteDict objectForKey:volumeKey]];
        }else{
            self.volume = volumeKey;
        }
        
        
        if ([quoteDict objectForKey:changeYTDKey]) {
            self.changeYTD =   [NSString stringWithFormat:@"%@", [quoteDict objectForKey:changeYTDKey]];
        }else{
            self.changeYTD = changeYTDKey;
        }
        
        if ([quoteDict objectForKey:changeYTDPercentageKey]) {
            self.changePercentageYTD =   [NSString stringWithFormat:@"%@", [quoteDict objectForKey:changeYTDPercentageKey]];
        }else{
            self.changePercentageYTD = changeYTDPercentageKey;
        }
        
        if ([quoteDict objectForKey:lowKey]) {
            self.low =   [NSString stringWithFormat:@"%@", [quoteDict objectForKey:lowKey]];
        }else{
            self.low = lowKey;
        }
        
        if ([quoteDict objectForKey:highKey]) {
            self.high =   [NSString stringWithFormat:@"%@", [quoteDict objectForKey:highKey]];
        }else{
            self.high = highKey;
        }
        
        
        if ([quoteDict objectForKey:openKey]) {
            self.open =   [NSString stringWithFormat:@"%@", [quoteDict objectForKey:openKey]];
        }else{
            self.open = openKey;
        }
        

    }
    return self;
}
@end
