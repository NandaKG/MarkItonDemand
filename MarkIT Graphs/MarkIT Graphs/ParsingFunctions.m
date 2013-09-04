//
//  ParsingFunctions.m
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/27/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import "ParsingFunctions.h"
#define Myfunction @"myfunction"
@implementation ParsingFunctions
@synthesize jsondata;
-(NSData*)returnNSDataFromURL:(NSURL *)url
{
        NSError *error = nil;
        NSData *data = [[NSData alloc]initWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
        NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        dataString = [dataString substringWithRange:NSMakeRange(Myfunction.length+1, dataString.length -1 - (Myfunction.length+1))];
        jsondata = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        return jsondata;
        
        
}
@end
