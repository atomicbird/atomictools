//
//  NSData+reallyMapped.m
//  MapTest
//
//  Created by Tom Harrington on 1/31/12.
//  Copyright (c) 2012 Atomic Bird, LLC. All rights reserved.
//

#import "NSData+reallyMapped.h"
#import <sys/fcntl.h>
#import <sys/mman.h>
//#import <objc/runtime.h>
#import "NSObject+deallocBlock.h"
/*
static char *mappedFilePointerKey = "mappedFilePointer";

// This class exists to do an end-run around the problem of not being able to override -dealloc in a category.
@interface MappedFilePointerValue : NSObject
@property (readwrite, assign) void *mapPointer;
@property (readwrite, assign) NSInteger mapSize;
@end
@implementation MappedFilePointerValue
@synthesize mapSize = mapSize_;
@synthesize mapPointer = mapPointer_;

- (void)dealloc
{
	munmap([self mapPointer], [self mapSize]);
	[super dealloc];
}

@end
*/
@implementation NSData (reallyMapped)

+ (NSData *)dataWithContentsOfReallyMappedFile:(NSString *)path;
{
    // Get an fd
    int fd = open([path fileSystemRepresentation], O_RDONLY);
    if (fd < 0) {
        return nil;
    }
    
    // Get file size
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    if (fileAttributes == nil) {
        close(fd);
        return nil;
    }
    NSNumber *fileSize = [fileAttributes objectForKey:NSFileSize];
    
    // mmap
    void *mappedFile;
    mappedFile = mmap(0, [fileSize intValue], PROT_READ, MAP_FILE|MAP_PRIVATE, fd, 0);
	close(fd);
	if (mappedFile == MAP_FAILED) {
        NSLog(@"Map failed, errno=%d, %s", errno, strerror(errno));
        return nil;
	}

	// Create the NSData
	NSData *mappedData = [NSData dataWithBytesNoCopy:mappedFile length:[fileSize intValue] freeWhenDone:NO];
	
	[mappedData addDeallocBlock:^{
		NSLog(@"Runing dealloc block");
		munmap(mappedFile, [fileSize intValue]);
	}];
	[mappedData addDeallocBlock:^{
		NSLog(@"Gratuitous second dealloc block");
	}];
	/*
	// Save off important data so that the map will be cleaned up when the NSData deallocs.
	MappedFilePointerValue *mapValue = [[[MappedFilePointerValue alloc] init] autorelease];
	[mapValue setMapPointer:mappedFile];
	[mapValue setMapSize:[fileSize integerValue]];
	objc_setAssociatedObject(mappedData, &mappedFilePointerKey, mapValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
*/
    return mappedData;
}

@end
