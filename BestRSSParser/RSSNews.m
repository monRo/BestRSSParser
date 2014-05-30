//
//  RSSNews.m
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import "RSSNews.h"

@implementation RSSNews

-(id)initWithNewsTitle:(NSString *)titleString newsLink:(NSString *)linkString newsDescriptor:(NSString *)descriptorString newsFullText:(NSString *)fullTextString newsDate:(NSString *)date
{
    if ((self =[super init])) {
        self.newsTitle = titleString;
        self.newsLink = linkString;
        self.newsDescription = descriptorString;
        self.newsFullText = fullTextString;
        self.newsDate = date;
    }
    return self;
}

@end
