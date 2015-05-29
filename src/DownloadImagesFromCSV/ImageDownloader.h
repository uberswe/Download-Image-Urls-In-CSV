//
//  ImageDownloader.h
//  DownloadImagesFromCSV
//
//  Created by Markus Tenghamn on 29/05/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownloader : NSObject

-(void)saveImagesInLocalDirectory:(NSString *)directory imageUrls:(NSMutableArray *)imageUrls;

@end
