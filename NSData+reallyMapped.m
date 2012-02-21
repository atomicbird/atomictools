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
#import "NSObject+deallocBlock.h"

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
        munmap(mappedFile, [fileSize intValue]);
    }];
    return mappedData;
}

@end
