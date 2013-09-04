//
//  TimeSeries.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 9/3/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "TimeSeries.h"
#define seriesKey @"Series"
#define openKey @"open"
#define highKey @"high"
#define lowKey @"low"
#define closeKey @"close"
#define seriesLabelsKey @"SeriesLabels"
#define xKey @"x"
#define textKey @"text"
#define seriesLabelCoordinatesKey @"pos"
#define seriesDurationKey @"SeriesDuration"
#define seriesDatesKey @"SeriesDates"

@implementation TimeSeries
-(id)initLookupObject:(Lookup*)company andTimeSeriesDictionary:(NSDictionary*)tSDict
{
    self = [super init];
    if (self) {
        if (company) {
            self.companyObj = company;
        }

        if ([tSDict objectForKey:seriesKey]) {
            NSDictionary *allSeries = [tSDict objectForKey:seriesKey];
            if ([allSeries objectForKey:openKey ]) {
                self.open = [[StockValues alloc]initWithDict:[allSeries objectForKey:openKey]];
            }
            if ([allSeries objectForKey:highKey]) {
                
                self.high = [[StockValues alloc]initWithDict:[allSeries objectForKey:highKey]];
            }
            if ([allSeries objectForKey:lowKey ]) {
                
                self.low = [[StockValues alloc]initWithDict:[allSeries objectForKey:lowKey]];
            }
            if ([allSeries objectForKey:closeKey ]) {
                
                self.close = [[StockValues alloc]initWithDict:[allSeries objectForKey:closeKey]];
            }
            
        }
        if ([tSDict objectForKey:seriesLabelsKey]) {
            NSDictionary *seriesLabels = [tSDict objectForKey:seriesLabelsKey];
            if([seriesLabels objectForKey:xKey]){
                NSDictionary *x = [seriesLabels objectForKey:xKey];
                if ([x objectForKey:textKey]) {
                    self.seriesLabels = [x objectForKey:textKey];
                }
                if ([x objectForKey:seriesLabelCoordinatesKey]) {
                    self.seriesLabelCoordinates = [x objectForKey:seriesLabelCoordinatesKey];
                }
            }
        }
        
        if ([tSDict objectForKey:seriesDurationKey]) {
            self.seriesDuration = [tSDict objectForKey:seriesDurationKey];
        }
        if ([tSDict objectForKey:seriesDatesKey]) {
            self.seriesDates = [tSDict objectForKey:seriesDatesKey];
        }
        
    }
    return self;
}
@end
