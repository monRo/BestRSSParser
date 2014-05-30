//
//  ViewController.m
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import "MainViewController.h"
#import "RSSTableViewCell.h"
#import "DetailViewController.h"
#import "InternetGateway.h"
#import "SettingsManager.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isOpen = NO;
    [self.hubArray removeAllObjects];
    
    self.rssNewsArray = [[NSMutableArray alloc] init];
    self.grandpaNewsArray = [[NSMutableArray alloc] init];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = self.refreshControl;
    [self.refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.hubArray = [[SettingsManager sharedSetting] getHubs];
    [self startParse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleRefresh {
    [self.refreshControl beginRefreshing];
    [self startParse];
    [self.refreshControl endRefreshing];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.hubArray objectAtIndex:section] isOpen] ? [[self.grandpaNewsArray objectAtIndex:section] count] : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.grandpaNewsArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.grandpaNewsArray objectAtIndex:section] objectAtIndex:section] rssTitle];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    RSSTableViewCell *cell = (RSSTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[RSSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSArray *array = [self.grandpaNewsArray objectAtIndex:[indexPath section]];
    cell.rssTitle.text = [[array objectAtIndex:indexPath.row] newsTitle];
    cell.rssDescription.text = [[array objectAtIndex:indexPath.row] newsDescription];
    cell.rssDate.text = [[array objectAtIndex:indexPath.row] newsDate];
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [[[self.grandpaNewsArray objectAtIndex:section] objectAtIndex:section] rssTitle];
    NSString *arrowNmae = @"normalArrow";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    button.tag = section;
    button.backgroundColor = [UIColor colorWithRed:0/255.0f green:170/255.0f blue:255/255.0f alpha:1.0f];
    [button setTitle:[NSString stringWithFormat:@" %@", sectionTitle] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didSelectSection:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:arrowNmae] forState:UIControlStateNormal];
    return button;
}

- (void)didSelectSection:(UIButton*)sender {
//
//    self.indexPathsToInsert = [[NSMutableArray alloc] init];
//    for (NSMutableArray *array in [self.grandpaNewsArray objectAtIndex:sender.tag]) {
//        [self.indexPathsToInsert addObject:array];
//    }
//    NSLog(@"%@", self.indexPathsToInsert);
    if ([[self.hubArray objectAtIndex:sender.tag] isOpen]) {
        [[self.hubArray objectAtIndex:sender.tag] setIsOpen:NO];
    } else {
        [[self.hubArray objectAtIndex:sender.tag] setIsOpen:YES];
    }

    NSString *image = [[self.hubArray objectAtIndex:sender.tag] isOpen] ? @"dropdownArrow" : @"normalArrow";
    [sender setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRSSDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.link = [[[self.grandpaNewsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] newsLink];
    }
}

-(void)startParse
{
    [self.tableView reloadData];
    [self.grandpaNewsArray removeAllObjects];
    for (int i = 0; i < [self.hubArray count]; i ++) {
        //
        if ([[self.hubArray objectAtIndex:i] isFavorits] == YES) {
            [InternetGateway getFeedsForURL:[[self.hubArray objectAtIndex:i] fullLink] success:^(NSArray *array)
             {
                 [self.grandpaNewsArray addObject:array];
                 [self.tableView reloadData];
             } failure:^(NSError *error) {
                 NSLog(@"Failure: %@", error);
             }];
        } else {
            // Show message in table view
        }
        //
    }
    [self.tableView reloadData];
}

@end
