//
//  TimeSeriesViewController.h
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/28/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeSeries.h"
#import "TimeSeriesParser.h"
#import "CorePlot-CocoaTouch.h"

@interface TimeSeriesViewController : UIViewController <CPTPlotDataSource, CPTAxisDelegate>
{
    CPTXYGraph *graph;
    
    
}
@property (nonatomic, retain) IBOutlet CPTGraphHostingView *graphHost;
@property(nonatomic,strong) TimeSeries *timeSeriesObj;
@property(nonatomic,strong) NSString *viewTitle;



-(void)loadTimeSeriesValues:(Lookup*)companyObject;
@end
