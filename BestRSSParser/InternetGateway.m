//
//  InternetGateway.m
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import "InternetGateway.h"

@implementation InternetGateway

+(void)getFeedsForURL:(NSString *)url success:(void (^)(NSArray *))goodNews failure:(void (^)(NSError *))badNews
{
    AFKissXMLRequestOperation *operation = [AFKissXMLRequestOperation XMLDocumentRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] success:^
                                            (NSURLRequest *request, NSHTTPURLResponse *response, DDXMLDocument *XMLDocument) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSString *title;
        NSArray *result = [XMLDocument nodesForXPath:@"rss/channel/item" error:nil];
        NSArray *titleNews = [XMLDocument nodesForXPath:@"rss/channel/image" error:nil];
        for (DDXMLElement *news in titleNews) {
            for (int i = 0; i < [news childCount]; i ++) {
                DDXMLNode *node = [news childAtIndex:i];
                if ([[node name] isEqual:@"title"]) {
                    title = [NSString stringWithString:[node stringValue]];
                } 
            }
        }
        for (DDXMLElement *news in result) {
            RSSNews *rssNews = [[RSSNews alloc] init];
            for (int i = 0; i < [news childCount]; i ++) {
                DDXMLNode *node = [news childAtIndex:i];
                if ([[node name] isEqual:@"title"]) {
                    rssNews.newsTitle = [node stringValue];
                } else if ([[node name] isEqual:@"link"]) {
                    rssNews.newsLink = [node stringValue];
                } else if ([[node name] isEqual:@"description"]) {
                    rssNews.newsDescription = [node stringValue];
                } else if ([[node name] isEqual:@"fulltext"]) {
                    rssNews.newsFullText = [node stringValue];
                } else if ([[node name] isEqual:@"pubDate"]) {
                    rssNews.newsDate = [node stringValue];
                }
            }
            rssNews.rssTitle = title;
            [array addObject:rssNews];
        }
        goodNews(array);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, DDXMLDocument *XMLDocument) {
        badNews(error);
    }];
    [operation start];
}

@end
