//
//  NSData+reallyMapped.h
//  MapTest
//
//  Created by Tom Harrington on 1/31/12.
//  Copyright (c) 2012 Atomic Bird, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (reallyMapped)

+ (NSData *)dataWithContentsOfReallyMappedFile:(NSString *)path;

@end
