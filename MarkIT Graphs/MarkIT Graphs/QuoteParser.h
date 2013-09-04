//
//  QuoteParser.h
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/28/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lookup.h"
#import "Quote.h"

@interface QuoteParser : NSObject
@property(nonatomic,strong) Lookup *companyObject;
-(id)initCompanyObject:(Lookup*)object;
-(void)loadQuoteJSONDataDone:(void (^)(Quote *companyQuote))parse_success NotDone:(void (^)(NSString *error))parse_failure;
@end
