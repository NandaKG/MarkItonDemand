//
//  QuoteParser.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/28/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "QuoteParser.h"
#import "Lookup.h"
#import "Quote.h"
#import "ParsingFunctions.h"

@implementation QuoteParser
-(id)initCompanyObject:(Lookup*)object
{
    self = [super init];
    if (self) {
        self.companyObject = object;
    }
    return self;
}
-(void)loadQuoteJSONDataDone:(void (^)(Quote *companyQuote))parse_success NotDone:(void (^)(NSString *error))parse_failure
{
    NSError *error = nil;
    NSString *urlString = [NSString stringWithFormat:@"http://dev.markitondemand.com/Api/Quote/jsonp?symbol=%@&callback=myfunction",self.companyObject.symbol];
    NSURL *url = [NSURL URLWithString:urlString];
    // CREATE NEW THREAD FOR PARSING JSON DATA
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSData *JSONData = [[ParsingFunctions alloc]returnNSDataFromURL:url];
        
        NSError *e = nil;
        
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&e];
        
        // ERROR HANDLING
        if(error != nil ){
                parse_failure([error localizedDescription]);
            }
        else{
            Quote *companyQuote = [[Quote alloc]initLookupObject:self.companyObject andQuoteDictionary:[resultDict objectForKey:@"Data"]];
            parse_success(companyQuote);
        }
        
    });

}

@end
