//
//  NSObject+deallocBlock.m
//  MapTest
//
//  Created by Tom Harrington on 2/5/12.
//  Copyright (c) 2012 Atomic Bird, LLC. All rights reserved.
//

#import "NSObject+deallocBlock.h"
#import <objc/runtime.h>

static char *deallocArrayKey = "deallocArrayKey";

// This class exists for the sole purpose of holding a block that it executes before getting deallocated.
@interface DeallocHandler : NSObject
@property (readwrite, copy) void (^theBlock)(void);
@end

@implementation DeallocHandler
@synthesize theBlock;

- (void)dealloc
{
    if (theBlock != nil) {
        theBlock();
    }
}
@end

@implementation NSObject (deallocBlock)

- (void)addDeallocBlock:(void (^)(void))theBlock;
{
    NSMutableArray *deallocBlocks = objc_getAssociatedObject(self, &deallocArrayKey);
    if (deallocBlocks == nil) {
        deallocBlocks = [NSMutableArray array];
        objc_setAssociatedObject(self, &deallocArrayKey, deallocBlocks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    DeallocHandler *handler = [[DeallocHandler alloc] init];
    [handler setTheBlock:theBlock];
    [deallocBlocks addObject:handler];
}
@end
