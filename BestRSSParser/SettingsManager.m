//
//  SettingsManager.m
//  BestRSSParser
//
//  Created by Andrey Starostenko on 29.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import "SettingsManager.h"


@implementation SettingsManager

+(instancetype)sharedSetting {
    static SettingsManager* _sharedSetting = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedSetting = [[SettingsManager alloc] init];
    });
    
    return _sharedSetting;
}

-(NSMutableArray*)getHubs {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];
    NSMutableArray *rootObject;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    } else {
        rootObject = [[NSMutableArray alloc] init];
    }
    return rootObject;
}

-(void)saveHubs:(NSMutableArray *)hubs {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData"];

    [NSKeyedArchiver archiveRootObject:hubs toFile: filePath];
}
@end
