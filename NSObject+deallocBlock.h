//
//  NSObject+deallocBlock.h
//  MapTest
//
//  Created by Tom Harrington on 2/5/12.
//  Copyright (c) 2012 Atomic Bird, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (deallocBlock)

- (void)addDeallocBlock:(void (^)(void))theBlock;
@end
