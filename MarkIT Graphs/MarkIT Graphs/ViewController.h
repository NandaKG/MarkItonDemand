//
//  ViewController.h
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/26/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuoteParser.h"
#import "Quote.h"

@interface ViewController : UIViewController


@property(nonatomic,strong) NSDictionary *resultDict;

@property(nonatomic, strong)Quote *companyQuoteObj;

@property(nonatomic,weak) IBOutlet UITableView *companyTableView;

@property(nonatomic,weak) IBOutlet UISearchBar *searchBar;

@property(nonatomic,strong) NSMutableArray *resultList;

@property (nonatomic) NSInteger indexPathRow;

@property(nonatomic,strong) NSMutableDictionary *compareList;

-(IBAction)pieBarButtonPressed:(id)sender;
-(IBAction)quotePressed:(id)sender;
-(IBAction)plotLinePressed:(id)sender;
-(IBAction)aboutButtonPressed:(id)sender;
-(IBAction)addToComparePressed:(id)sender;
-(void)getCompanyQuote:(Lookup*)companyObj;
-(void)loadCompanyQuote:(Lookup*)companyObject;
-(NSString *)makeQuoteDetailsString;
@end
