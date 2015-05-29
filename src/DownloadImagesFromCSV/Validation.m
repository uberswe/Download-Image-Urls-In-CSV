//
//  Validation.m
//  DownloadImagesFromCSV
//
//  Created by Markus Tenghamn on 29/05/15.
//  Copyright (c) 2015 Markus Tenghamn. All rights reserved.
//

#import "Validation.h"

@implementation Validation

- (BOOL)validateUrl:(NSString *)candidate {
    NSURL *candidateURL = [NSURL URLWithString:candidate];
    if (candidateURL && candidateURL.scheme && candidateURL.host) {
        if ([candidate rangeOfString:@".jpg"].location == NSNotFound) {
            if ([candidate rangeOfString:@".png"].location == NSNotFound) {
                if ([candidate rangeOfString:@".gif"].location == NSNotFound) {
                    if ([candidate rangeOfString:@".jpeg"].location == NSNotFound) {
                        return false;
                    } else {
                        return true;
                    }
                } else {
                    return true;
                }
            } else {
                return true;
            }
        } else {
            return true;
        }
        return false;
    }
    return false;
}

@end
