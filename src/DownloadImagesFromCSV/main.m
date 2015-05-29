//
//  main.m
//  DownloadImagesFromCSV
//
//  Created by Markus Tenghamn on 29/05/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Validation.h"
#import "ImageDownloader.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
        NSLog(@"Working directory: %@",bundleRoot);
        NSFileManager *filemgr = [NSFileManager defaultManager];
        NSArray *dirContents = [filemgr contentsOfDirectoryAtPath:bundleRoot error:nil];
        NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.csv'"];
        NSArray *CSVs = [dirContents filteredArrayUsingPredicate:fltr];
        NSMutableArray *urls = [NSMutableArray array];
        Validation *validator = [[Validation alloc] init];
        NSError *error = nil;
        for (NSString *csv in CSVs) {
            NSLog(@"Opening: %@",csv);
            NSString* fileContents = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",bundleRoot,csv] encoding:NSISOLatin1StringEncoding error:&error];
            if (error) {
            NSLog(@"Error: %@", error);
            } else {
            NSArray* rows = [fileContents componentsSeparatedByString:@"\n"];
            for (NSString *row in rows){
                NSArray* columns = [row componentsSeparatedByString:@";"];
                for (NSString *c in columns) {
                    NSLog(@"String: %@",c);
                    if ([validator validateUrl:c]) {
                        NSLog(@"Added: %@",c);
                        [urls addObject:c];
                    }
                }
            }
            }
        }
        if ([CSVs count] < 1) {
            NSLog(@"No files");
        }else if ([urls count] < 1) {
            NSLog(@"No urls found");
        } else {
            NSError *error2 = nil;
            NSString *directory = [NSString stringWithFormat:@"%@/%@",bundleRoot,@"images"];
            if(![filemgr createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error2]) {
                // An error has occurred, do something to handle it
                NSLog(@"Failed to create directory \"%@\". Error: %@", directory, error);
            }
            ImageDownloader *imgDwnl = [[ImageDownloader alloc] init];
            [imgDwnl saveImagesInLocalDirectory:directory imageUrls:urls];
        }
        
    }
    return 0;
}

