//
//  ViewController.h
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"

@protocol MainViewDelegate <NSObject>

-(void)updateLink:(NSString *)url;

@end

@class DetailViewController;

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSArray *rssNewsArray;
@property (strong, nonatomic) NSMutableArray *allNewsFeed;
@property (strong, nonatomic) NSMutableArray *indexPathsToInsert;
@property (strong, nonatomic) NSMutableArray *hubArray;
@property (assign, nonatomic) BOOL isOpen;

@property (assign) id <MainViewDelegate> delegate;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end
