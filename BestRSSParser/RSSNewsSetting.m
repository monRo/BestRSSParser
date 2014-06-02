//
//  RSSNewsSetting.m
//  BestRSSParser
//
//  Created by Andrey Starostenko on 29.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import "RSSNewsSetting.h"

@implementation RSSNewsSetting
@synthesize fullLink = _fullLink;
    
- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.titleNews = [coder decodeObjectForKey:@"title"];
        self.fullLink = [coder decodeObjectForKey:@"link"];
        self.isFavorits = [coder decodeBoolForKey:@"isFavirites"];
        self.isOpen = [coder decodeBoolForKey:@"isOpen"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject: self.titleNews forKey:@"title"];
    [coder encodeObject: self.fullLink forKey:@"link"];
    [coder encodeBool: self.isFavorits forKey:@"isFavirites"];
    [coder encodeBool:self.isOpen forKey:@"isOpen"];
}

-(void)setFullLink:(NSString *)fullLink {
    NSString *searchString = @"http://";
    if ([fullLink rangeOfString:searchString].location == NSNotFound) {
        _fullLink = [[NSString stringWithFormat:@"http://%@", fullLink] lowercaseString];
    } else {
        _fullLink = [[NSString stringWithString:fullLink] lowercaseString];
    }
}

@end
