//
//  TimeSeriesViewController.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/28/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "TimeSeriesViewController.h"
#import "TimeSeriesParser.h"
#import "SVProgressHUD.h"

@interface TimeSeriesViewController ()

@end

@implementation TimeSeriesViewController
@synthesize viewTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)loadTimeSeriesValues:(Lookup*)companyObject
{
    TimeSeriesParser *parser = [[TimeSeriesParser alloc]initCompanyObject:companyObject];
    [SVProgressHUD showWithStatus:@"PLOTTING..."];
    //CREATING WEAK INSTANCE OF SELF TO AVOID RETAIN CYCLE
    __weak TimeSeriesViewController *controller = self;
    [parser loadTimeSeriesJSONDataDone:^(TimeSeries *timeSeries) {
        
       
        dispatch_async(dispatch_get_main_queue(), ^{
            controller.timeSeriesObj  = timeSeries;
            [SVProgressHUD showSuccessWithStatus:@"DONE"];
            controller.title = controller.timeSeriesObj.companyObj.name;
            [controller loadData];
            [graph reloadData];
            });
        
        
    } NotDone:^(NSString *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: error delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        });
        
        
        
    }];

}
#pragma CORE-PLOT FUNCTIONS

-(void)loadData
{
    if ( !graph ) {
        graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
        CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
        [graph applyTheme:theme];
        graph.paddingTop    = 22.0;
        graph.paddingBottom = 0.0;
        graph.paddingLeft   = 0.0;
        graph.paddingRight  = 0.0;
        
        
        CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] initWithFrame:graph.bounds] ;
        dataSourceLinePlot.identifier = @"high";
        dataSourceLinePlot.plotSymbolMarginForHitDetection = 251.0;
        CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy] ;
        lineStyle.lineWidth              = 1.5f;
        lineStyle.lineColor              = [CPTColor greenColor];
        dataSourceLinePlot.dataLineStyle = lineStyle;
        
        dataSourceLinePlot.dataSource = self;
        dataSourceLinePlot.delegate = self;
        [graph addPlot:dataSourceLinePlot];
        
        CPTColor *areaColor1       = [CPTColor greenColor];
        CPTGradient *areaGradient1 = [CPTGradient gradientWithBeginningColor:areaColor1 endingColor:[CPTColor clearColor]];
        areaGradient1.angle = -90.0f;
        CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient1];
        
        CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
        symbolLineStyle.lineColor = [CPTColor blackColor];
        CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor greenColor]];
        plotSymbol.lineStyle     = symbolLineStyle;
        plotSymbol.size          = CGSizeMake(3.0, 3.0);
        dataSourceLinePlot.plotSymbol = plotSymbol;
        
        
        // Create a blue plot area
        CPTScatterPlot *boundLinePlot  = [[CPTScatterPlot alloc] init];
        lineStyle = [CPTMutableLineStyle lineStyle];
        lineStyle.miterLimit        = 1.0f;
        lineStyle.lineWidth         = 3.0f;
        lineStyle.lineColor         = [CPTColor redColor];
        boundLinePlot.dataLineStyle = lineStyle;
        boundLinePlot.identifier    = @"low";
        boundLinePlot.dataSource    = self;
        
        // Do a blue gradient
        areaColor1       = [CPTColor colorWithComponentRed:0.3 green:0.3 blue:1.0 alpha:0.8];
        areaGradient1 = [CPTGradient gradientWithBeginningColor:areaColor1 endingColor:[CPTColor clearColor]];
        areaGradient1.angle = -90.0f;
        areaGradientFill = [CPTFill fillWithGradient:areaGradient1];
        
        // Add plot symbols
        symbolLineStyle = [CPTMutableLineStyle lineStyle];
        symbolLineStyle.lineColor = [CPTColor blackColor];
        plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
        plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor redColor]];
        plotSymbol.lineStyle     = symbolLineStyle;
        plotSymbol.size          = CGSizeMake(3.0, 3.0);
        boundLinePlot.plotSymbol = plotSymbol;
        
        
        [(CPTXYPlotSpace *)graph.defaultPlotSpace scaleToFitPlots:[NSArray arrayWithObjects:dataSourceLinePlot, boundLinePlot, nil]];
        
        
    }
    
    self.graphHost.hostedGraph = graph;
    
    if ([self.timeSeriesObj.seriesLabels count] >0) {
        NSString *title = [NSString stringWithFormat:@"Change in stock Prices: %@ to %@",[self.timeSeriesObj.seriesLabels objectAtIndex:0],[self.timeSeriesObj.seriesLabels objectAtIndex:[self.timeSeriesObj.seriesLabels count]-1] ];
        graph.title = title;
        
        // 3 - Create and set text style
        CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
        titleStyle.color = [CPTColor whiteColor];
        titleStyle.fontName = @"Helvetica-Bold";
        titleStyle.fontSize = 16.0f;
        graph.titleTextStyle = titleStyle;
        graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
        graph.titleDisplacement = CGPointMake(0.0f, 18.0f);
        
    }
    
    
    NSDecimalNumber *high   = [NSDecimalNumber zero];
    NSDecimalNumber *low    =[NSDecimalNumber zero];
    NSDecimalNumber *length = [NSDecimalNumber zero];
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    if (self.timeSeriesObj) {
        high   =   [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.timeSeriesObj.high.max]];
        low    =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.timeSeriesObj.high.min]] ;
        length = [high decimalNumberBySubtracting:low];
        
        
    }

    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(0.0) length:CPTDecimalFromUnsignedInteger([self.timeSeriesObj.high.values count])];
    
    CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
    [xRange expandRangeByFactor:CPTDecimalFromCGFloat(1.3f)];
    plotSpace.xRange = xRange;
    
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:[low decimalValue] length:[length decimalValue]];
    CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
    [yRange expandRangeByFactor:CPTDecimalFromCGFloat(1.3f)];
    plotSpace.yRange = yRange;
    // Axes
    
    plotSpace.allowsUserInteraction = YES;
    
    
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    CPTXYAxis *x = axisSet.xAxis;
    x.majorIntervalLength         = CPTDecimalFromDouble(200.0);
    NSNumber *n = [ NSNumber numberWithFloat:[[NSString stringWithFormat:@"%f", round(2.0f * [low floatValue]) / 2.0f] floatValue ] ];
    
    float roundedValue = round(2.0f * [low floatValue]) / 2.0f;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:3];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];
    
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:roundedValue]];
    n = [ NSNumber numberWithFloat:[numberString floatValue]];
    
    x.orthogonalCoordinateDecimal = [n  decimalValue] ;//CPTDecimalFromInteger(0);
    
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [CPTColor whiteColor];
    
    x.minorTicksPerInterval       = 0;
    // x.title = @"Time";
    x.titleOffset = 10.0f;
    x.titleLocation = CPTDecimalFromString(@"-2.0");
    CPTMutableTextStyle *style = [CPTMutableTextStyle textStyle];
    style.color = [CPTColor whiteColor];
    x.titleTextStyle =      style;
    x.labelTextStyle = axisTitleStyle;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    x.labelTextStyle = style;
    x.majorTickLineStyle = axisLineStyle;
    x.minorTickLineStyle = axisLineStyle;
    
    CGFloat dateCount = [self.timeSeriesObj.seriesLabels count];
    NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount];
    NSInteger i = 0;
    for (NSString *date in self.timeSeriesObj.seriesLabels) {
        if (i %4 ==0) {
            CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:date  textStyle:x.labelTextStyle];
            label.tickLocation =  [[NSNumber numberWithFloat:(float)[self.timeSeriesObj.high.values count] * [[self.timeSeriesObj.seriesLabelCoordinates objectAtIndex:i] floatValue]] decimalValue];
            
            label.offset = x.majorTickLength;
            if (label) {
                [xLabels addObject:label];
                [xLocations addObject:[NSNumber numberWithFloat:(float)[self.timeSeriesObj.high.values count] * [[self.timeSeriesObj.seriesLabelCoordinates objectAtIndex:i] floatValue]]];
            }
            
        }
        ++i;
    }
    x.axisLabels = xLabels;
    x.majorTickLocations = xLocations;
    
    
    CPTXYAxis *y  = axisSet.yAxis;
    NSDecimal six = CPTDecimalFromInteger(6);
    y.majorIntervalLength         = CPTDecimalDivide([length decimalValue], six);
    y.majorTickLineStyle          = nil;
    y.minorTicksPerInterval       = 4;
    y.minorTickLineStyle          = nil;
    y.orthogonalCoordinateDecimal = CPTDecimalFromInteger(0);
    y.alternatingBandFills        = [NSArray arrayWithObjects:[[CPTColor whiteColor] colorWithAlphaComponent:0.1], [NSNull null], nil];
    // axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    y.labelOffset = -40.0f;
    
    y.labelTextStyle = axisTitleStyle;
    x.tickDirection = CPTSignNegative;
    y.majorTickLineStyle = axisLineStyle;
    
    y.tickDirection = CPTSignPositive;
    [graph reloadData];
    
    
}
#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self.timeSeriesObj.high.values count];
}


-(NSUInteger)numberOfRecords
{
    return [self.timeSeriesObj.high.values count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    
    NSDecimalNumber *num = [NSDecimalNumber zero];
    
    if ([(NSString *)plot.identifier isEqualToString:@"high"]) {
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            num = (NSDecimalNumber *)[NSDecimalNumber numberWithInt:index + 1];
        }
        else if ( fieldEnum == CPTScatterPlotFieldY ) {
            NSArray *financialData = self.timeSeriesObj.high.values;
            
            num = [NSDecimalNumber  decimalNumberWithDecimal:[[financialData objectAtIndex:index ] decimalValue] ];
            NSAssert([num isMemberOfClass:[NSDecimalNumber class]], @"yes");
        }
        
    }else if ([(NSString *)plot.identifier isEqualToString:@"low"]){
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            num = (NSDecimalNumber *)[NSDecimalNumber numberWithInt:index + 1];
        }
        else if ( fieldEnum == CPTScatterPlotFieldY ) {
            NSArray *financialData = self.timeSeriesObj.low.values;
            
            num = [NSDecimalNumber  decimalNumberWithDecimal:[[financialData objectAtIndex:index ] decimalValue] ];
            NSAssert([num isMemberOfClass:[NSDecimalNumber class]], @"yes");
        }
        
    }
    return num;
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"LOW MEMORY!!!");
    // Dispose of any resources that can be recreated.
}

@end
