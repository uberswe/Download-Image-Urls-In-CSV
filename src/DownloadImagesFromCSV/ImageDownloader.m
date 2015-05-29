//
//  ImageDownloader.m
//  DownloadImagesFromCSV
//
//  Created by Markus Tenghamn on 29/05/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

-(void)saveImagesInLocalDirectory:(NSString *)directory imageUrls:(NSMutableArray *)imageUrls
{
    for (NSString *imgUrl in imageUrls) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *img = [imgUrl lastPathComponent];
        NSString *writablePath = [directory stringByAppendingPathComponent:img];
    
        if(![fileManager fileExistsAtPath:writablePath]){
            // file doesn't exist
            NSLog(@"Downloading image");
            if (imgUrl) {
            //save Image From URL
            [self getImageFromURLAndSaveItToLocalData:img fileURL:imgUrl inDirectory:directory];
            }
        }
        else{
            // file exist
            NSLog(@"file exist");
        }
    }
}

-(void) getImageFromURLAndSaveItToLocalData:(NSString *)imageName fileURL:(NSString *)fileURL inDirectory:(NSString *)directoryPath {
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    NSError *error = nil;
    [data writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]] options:NSAtomicWrite error:&error];
    
    if (error) {
        NSLog(@"Error Writing File : %@",error);
    }else{
        NSLog(@"Image %@ Saved SuccessFully",imageName);
    }
}

@end
