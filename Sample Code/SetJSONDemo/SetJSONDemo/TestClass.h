//
//  TestClass.h
//  SafeSetDemo
//
//  Created by Tom Harrington on 12/29/11.
//  Copyright (c) 2011 Atomic Bird, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject

@property (readwrite, strong) NSDate *date;
@property (readwrite, strong) NSString *string;
@property (readwrite, strong) NSNumber *floatNumber;

@property (readwrite, assign) NSUInteger unsignedInteger;

@property (readwrite, assign) char character;
@end
