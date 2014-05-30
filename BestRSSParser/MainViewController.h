//
//  ViewController.h
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *rssNewsArray;
@property (strong, nonatomic) NSMutableArray *grandpaNewsArray;
@property (strong, nonatomic) NSMutableArray *indexPathsToInsert;
@property (strong, nonatomic) NSMutableArray *hubArray;
@property (assign, nonatomic) BOOL isOpen;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end
