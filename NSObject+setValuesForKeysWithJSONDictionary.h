//
//  NSObject+setValuesForKeysWithJSONDictionary.h
//  SafeSetDemo
//
//  Created by Tom Harrington on 12/29/11.
//  Copyright (c) 2011 Atomic Bird, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (setValuesForKeysWithJSONDictionary)

- (void)setValuesForKeysWithJSONDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter;

@end
