//
//  SettingViewController.h
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSNewsSetting.h"

@interface SettingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

- (IBAction)addHubButton:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *hubArray;

@end
