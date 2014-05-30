//
//  RSSNewsSetting.h
//  BestRSSParser
//
//  Created by Andrey Starostenko on 29.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSNewsSetting : NSObject <NSCoding>

@property (nonatomic, copy) NSString *titleNews;
@property (nonatomic, copy) NSString *fullLink;
@property (nonatomic, assign) BOOL isFavorits;
@property (nonatomic, assign) BOOL isOpen;

@end
