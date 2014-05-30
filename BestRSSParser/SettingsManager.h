//
//  SettingsManager.h
//  BestRSSParser
//
//  Created by Andrey Starostenko on 29.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSNewsSetting.h"

@interface SettingsManager : NSObject

+(instancetype)sharedSetting;

-(NSMutableArray*)getHubs;
-(void)saveHubs:(NSMutableArray *)hubs;

@end
