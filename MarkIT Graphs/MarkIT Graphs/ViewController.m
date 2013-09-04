//
//  ViewController.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/26/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "ViewController.h"
#import "LookupParser.h"
#import "Lookup.h"
#import "Quote.h"
#import "TimeSeriesViewController.h"
#import "SVProgressHUD.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize companyTableView;
@synthesize searchBar;
@synthesize resultList;
@synthesize indexPathRow;
@synthesize compareList;


-(IBAction)quotePressed:(id)sender
{
    UITableViewCell *owningCell = (UITableViewCell*)[sender superview];
	
    
	NSIndexPath *pathToCell = [self.companyTableView indexPathForCell:owningCell];
    Lookup *companyObject = (Lookup *)[self.resultList objectAtIndex:pathToCell.row];
    [self loadCompanyQuote:companyObject];
    
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"LinePlotSegue"])
    {
        
        // Get reference to the destination view controller
        
        // Pass any objects to the view controller here, like...
        
    }
    
}*/
-(IBAction)plotLinePressed:(id)sender
{
    UITableViewCell *owningCell = (UITableViewCell*)[sender superview];
    
    NSIndexPath *pathToCell = [self.companyTableView indexPathForCell:owningCell];
    Lookup *companyObject = (Lookup *)[self.resultList objectAtIndex:pathToCell.row];
    TimeSeriesViewController *vc = [[TimeSeriesViewController alloc]initWithNibName:@"PlotView" bundle:nil];
    [vc loadTimeSeriesValues:companyObject];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)getCompanyQuote:(Lookup*)companyObj
{
    QuoteParser *parser = [[QuoteParser alloc]initCompanyObject:companyObj];
    [SVProgressHUD showWithStatus:@"GETTING QUOTE"];
    //CREATING WEAK INSTANCE OF SELF TO AVOID RETAIN CYCLE
    __weak ViewController *controller = self;
    [parser loadQuoteJSONDataDone:^ (Quote *companyQuote){
        controller.companyQuoteObj = companyQuote;
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"DONE"];
            NSString *compSym = controller.companyQuoteObj.companyObj.symbol;
            NSString *compLP = controller.companyQuoteObj.lastPrice;
            compareList = [[NSMutableDictionary alloc]init];
            [compareList setObject:compLP forKey:compSym];
            NSLog(@"%@",[compareList valueForKey:compSym]);
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:compareList forKey:@"COMPARE"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"ADDED COMPANY TO COMPARE" message: controller.companyQuoteObj.companyObj.name delegate: nil cancelButtonTitle:@"GO BACK" otherButtonTitles:nil];
            [alert show];
            
        });
    }NotDone:^(NSString *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"ERROR!!"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: error delegate: nil cancelButtonTitle:@"GO BACK" otherButtonTitles:nil];
            [alert show];
        });
        
    }];

}
-(IBAction)addToComparePressed:(id)sender
{
    
    UITableViewCell *owningCell = (UITableViewCell*)[sender superview];
	NSIndexPath *pathToCell = [self.companyTableView indexPathForCell:owningCell];
    Lookup *companyDetails = (Lookup *)[self.resultList objectAtIndex:pathToCell.row];
    [self getCompanyQuote:companyDetails];
    
}
-(IBAction)pieBarButtonPressed:(id)sender
{
    TimeSeriesViewController *vc = [[TimeSeriesViewController alloc]initWithNibName:@"PiePlotView" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];

}
-(IBAction)aboutButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"MARK IT GRAPHS VERSION 1.0" message: @"SEARCH FOR YOUR FAVOURITE COMPANY" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    LookupParser *parser = [[LookupParser alloc]initSearchString:self.searchBar.text];
    [SVProgressHUD showWithStatus:@"PARSING DATA"];
    //CREATING WEAK INSTANCE OF SELF TO AVOID RETAIN CYCLE
    __weak ViewController *controller = self;
    [parser loadJSONDataDone:^(NSMutableArray *resultArray) {
        controller.resultList  = resultArray;
         dispatch_async(dispatch_get_main_queue(), ^{
             [SVProgressHUD showSuccessWithStatus:@"DONE"];
             [controller.companyTableView reloadData];
             [controller.searchBar resignFirstResponder];
             }); 
         }
                        NotDone:^(NSString *error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [SVProgressHUD showSuccessWithStatus:@"ERROR!!"];
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: error delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                [alert show];
                            });
                            
                        }];
    
}
-(NSString *)makeQuoteDetailsString
{
    NSString *quoteDetails = [NSString stringWithFormat:@"SYMBOL: %@ \rPRICE: %@ \rCHANGE: %@ \rCHANGE%% : %@ \rTIMESTAMP: %@ \rMARKET CAP: %@ \rVOLUME: %@ \rCHANGE YTD: %@ \rCHANGE%% YTD: %@ \rHIGH: %@ \rLOW: %@ \rOPEN: %@ ",self.companyQuoteObj.companyObj.symbol,self.companyQuoteObj.lastPrice,self.companyQuoteObj.change,self.companyQuoteObj.changePercentage,self.companyQuoteObj.timeStamp,self.companyQuoteObj.marketCap,self.companyQuoteObj.volume,self.companyQuoteObj.changeYTD,self.companyQuoteObj.changePercentageYTD,self.companyQuoteObj.high,self.companyQuoteObj.low,self.companyQuoteObj.open];
    return quoteDetails;
}
-(void)loadCompanyQuote:(Lookup*)companyObject
{
    QuoteParser *parser = [[QuoteParser alloc]initCompanyObject:companyObject];
    [SVProgressHUD showWithStatus:@"PARSING DATA"];
    //CREATING WEAK INSTANCE OF SELF TO AVOID RETAIN CYCLE
    __weak ViewController *controller = self;
    [parser loadQuoteJSONDataDone:^ (Quote *companyQuote){
        controller.companyQuoteObj = companyQuote;
        NSString *companyQuoteAlert = [controller makeQuoteDetailsString];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *st = controller.companyQuoteObj.companyObj.name;
            [SVProgressHUD showSuccessWithStatus:@"DONE"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: st message: companyQuoteAlert delegate: nil cancelButtonTitle:@"GO BACK" otherButtonTitles:nil];
            [alert show];
        });
    }NotDone:^(NSString *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"ERROR!!!"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert" message: error delegate: nil cancelButtonTitle:@"GO BACK" otherButtonTitles:nil];
            [alert show];
        });
        
    }];
    
    
}
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.resultList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Lookup *companyDetails = (Lookup *)[self.resultList objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"CompanyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    // Set up the cell..
    
    UIButton *plotLine = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [plotLine addTarget:self
                     action:@selector(plotLinePressed:)
           forControlEvents:UIControlEventTouchDown];
    [plotLine setTitle:@"PLOT GRAPH" forState:UIControlStateNormal];
    plotLine.frame = CGRectMake(630.0f, 5.0f, 120.0f, 30.0f);
    [cell addSubview:plotLine];
    
    UIButton *showQuote = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [showQuote addTarget:self
                 action:@selector(quotePressed:)
       forControlEvents:UIControlEventTouchDown];
    showQuote.frame = CGRectMake(575.0f, 5.0f, 30.0f, 30.0f);
    
    [cell addSubview:showQuote];

    
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    cell.textLabel.text = companyDetails.name;
    cell.detailTextLabel.text = companyDetails.exchange;
    UIImage *image = [UIImage imageNamed:@"73-radar.png"];
    [[cell imageView] setImage:image];

    return cell;
}

/*
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Lookup *companyObject = (Lookup *)[self.resultList objectAtIndex:indexPath.row];
    [self loadCompanyQuote:companyObject];
}*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// open a alert with an OK and cancel button
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"MARK IT GRAPHS";
    [self.searchBar becomeFirstResponder];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"LOW MEMORY!!!");
    // Dispose of any resources that can be recreated.
}

@end
