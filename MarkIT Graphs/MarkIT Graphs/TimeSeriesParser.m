//
//  TimeSeriesParser.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 9/3/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "TimeSeriesParser.h"
#import "ParsingFunctions.h"
#define FUNCTIONNAME @"myfunction"
@implementation TimeSeriesParser

-(id)initCompanyObject:(Lookup*)object
{
    self = [super init];
    if (self) {
        self.companyObject = object;
    }
    return self;
}

-(void)loadTimeSeriesJSONDataDone:(void (^)(TimeSeries *companyTimeSeries))parse_success NotDone:(void (^)(NSString *error))parse_failure
{
    NSString *urlString = [NSString stringWithFormat:@"http://dev.markitondemand.com/Api/Timeseries/jsonp?symbol=%@&callback=myfunction",self.companyObject.symbol];
    NSURL *url = [NSURL URLWithString:urlString];
    // CREATE NEW THREAD FOR PARSING JSON DATA
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        
        NSError *error = nil;
        NSData *data = [[NSData alloc]initWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        if (error) {
            parse_failure([error localizedDescription ]);
            
        }else{
            
            NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            dataString = [dataString substringWithRange:NSMakeRange(FUNCTIONNAME.length+1, dataString.length -1 - (FUNCTIONNAME.length+1))];
            
            NSData *JSONData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *e = nil;
            
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&e];
            
            
            
            if(error != nil || ![resultDict objectForKey:@"Matches"]){
                if (![resultDict objectForKey:@"Matches"]) {
                    parse_failure(@"No matches found");
                    
                }else{
                    parse_failure([error localizedDescription ]);
                }
                
                }
            else{
                TimeSeries *companyTimeSeries = [[TimeSeries alloc]initLookupObject:self.companyObject andTimeSeriesDictionary:[resultDict objectForKey:@"Data"]];
                parse_success(companyTimeSeries);
            }
            
        }
        
    });
    
}

@end
