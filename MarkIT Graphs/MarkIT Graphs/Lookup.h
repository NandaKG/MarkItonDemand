//
//  Lookup.h
//  MarkIT Graphs
//
//  Created by Nanda kishore on 8/27/13.
//  Copyright (c) 2013 Nanda Kishore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lookup : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *symbol;
@property(nonatomic,strong) NSString *exchange;
-(id)initCompanyLookupDictionary:(NSDictionary*)lookupDict;
@end
