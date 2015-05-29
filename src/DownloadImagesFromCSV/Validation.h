//
//  Validation.h
//  DownloadImagesFromCSV
//
//  Created by Markus Tenghamn on 29/05/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validation : NSObject

- (BOOL)validateUrl:(NSString *)candidate;

@end
