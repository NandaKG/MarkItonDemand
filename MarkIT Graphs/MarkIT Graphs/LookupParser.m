//
//  LookupParser.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/27/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "LookupParser.h"
#import "Lookup.h"
#import "ParsingFunctions.h"

@implementation LookupParser
@synthesize searchString;
-(id)initSearchString:(NSString *)sString
{
    self = [super init];
    if (self) {
        self.searchString = sString;
    }
    return self;
}
-(void)loadJSONDataDone:(void (^)(NSMutableArray *resultArray))parse_success NotDone:(void (^)(NSString *error))parse_failure

{
    NSError *error = nil;
    NSString *urlString = [NSString stringWithFormat:@"http://dev.markitondemand.com/Api/Lookup/jsonp?input=%@&callback=myfunction",searchString];
    NSURL *url = [NSURL URLWithString:urlString];
    // CREATE NEW THREAD FOR PARSING JSON DATA
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
    NSData *JSONData = [[ParsingFunctions alloc]returnNSDataFromURL:url];
         NSError *e = nil;
        NSMutableArray *resultList = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&e];
        //NSLog(@"%@",companyArray);
         NSMutableArray *companyList = [NSMutableArray array];
        Lookup *temp;
        for (id company  in resultList) {
            temp = [[Lookup alloc]initCompanyLookupDictionary:company];
            [companyList addObject:temp];
        }
        
    // ERROR HANDLING
        if(error != nil || [companyList count]== 0){
            if ([companyList count]== 0){
                
                parse_failure(@"Company not found");
                
            }else{
                parse_failure([error localizedDescription]);
            }
        }else{
            parse_success(companyList);
        }

    });
                   }

@end
