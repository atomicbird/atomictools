//
//  main.m
//  SetJSONDemo
//
//  Created by Tom Harrington on 2/21/12.
//  Copyright (c) 2012 Atomic Bird, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+setValuesForKeysWithJSONDictionary.h"
#import "TestClass.h"

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        TestClass *test = [[TestClass alloc] init];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'H:mm:ss"];
        
        NSDictionary *dictionary;
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      [NSNumber numberWithInt:27], @"string",

                      @"foo", @"bar",
                      
                      @"1.23", @"floatNumber",
                      
                      @"23", @"unsignedInteger",
                      
                      @"2011-12-29T17:36:27", @"date",
                      
                      @"xyz", @"character",
                      nil];
        
        [test setValuesForKeysWithJSONDictionary:dictionary dateFormatter:dateFormatter];
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      // Use the ivar name this time instead of the property name.
                      [NSNumber numberWithInt:27], @"string_",
                      
                      [NSNumber numberWithFloat:2.34], @"floatNumber",
                      
                      [NSNumber numberWithInt:24], @"unsignedInteger",
                      
                      @"2011-12-29T17:36:27", @"date",
                      nil];
        
        [test setValuesForKeysWithJSONDictionary:dictionary dateFormatter:dateFormatter];
        
    }
    return 0;
}

