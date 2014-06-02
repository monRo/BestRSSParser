//
//  RSSNews.h
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSNews : NSObject

@property (nonatomic, copy) NSString *rssTitle;
@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *newsLink;
@property (nonatomic, copy) NSString *newsDescription;
@property (nonatomic, copy) NSString *newsFullText;
@property (nonatomic, copy) NSString *newsDate;

-(id)initWithNewsTitle:(NSString *)titleString
              newsLink:(NSString *)linkString
        newsDescriptor:(NSString *)descriptorString
          newsFullText:(NSString *)fullTextString
              newsDate:(NSString *)date;

@end
