//
//  ComparePlotViewController.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/28/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "ComparePlotViewController.h"

@interface ComparePlotViewController ()

@end

@implementation ComparePlotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"WORKS HERE TOO");
    self.title = @"PIE BAR PLOT";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults valueForKey:@"COMPARE"]);

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"LOW MEMORY!!!");
    // Dispose of any resources that can be recreated.
}

@end
