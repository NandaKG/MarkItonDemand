//
//  LookupParser.h
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/27/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LookupParser : NSObject
@property(nonatomic,strong) NSString *searchString;
-(id)initSearchString:(NSString*)sString;
-(void)loadJSONDataDone:(void (^)(NSMutableArray *resultArray))parse_success NotDone:(void (^)(NSString *error))parse_failure;
@end
