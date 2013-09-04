//
//  ParsingFunctions.h
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/27/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParsingFunctions : NSObject
@property(nonatomic,strong) NSData *jsondata;
-(NSData*)returnNSDataFromURL:(NSURL*)url;
@end
