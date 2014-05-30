//
//  InternetGateway.h
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InternetGateway : NSObject

+(void)getFeedsForURL:(NSString *)url success:(void (^)(NSArray *array))goodNews failure:(void (^)(NSError *error))badNews;

@end
