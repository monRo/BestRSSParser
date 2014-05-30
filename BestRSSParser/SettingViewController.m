//
//  SettingViewController.m
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import "AppDelegate.h"
#import "SettingViewController.h"
#import "SettingsManager.h"

@interface SettingViewController ()

@property BOOL isEdit;
@property int indexPathRow;

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isEdit = NO;
    self.hubArray = [[SettingsManager sharedSetting] getHubs];
    
    // Gesture
    UISwipeGestureRecognizer *recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    [recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    [self.tableView addGestureRecognizer:recognizerRight];
    // End Gesture
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleSwipe:(UISwipeGestureRecognizer*)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        CGPoint location = [swipe locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
        if(indexPath)
        {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if (cell.accessoryType == UITableViewCellAccessoryNone) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [[self.hubArray objectAtIndex:indexPath.row] setIsFavorits:YES];
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [[self.hubArray objectAtIndex:indexPath.row] setIsFavorits:NO];
            }
        }
        [[SettingsManager sharedSetting] saveHubs:self.hubArray];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[self.hubArray objectAtIndex:indexPath.row] titleNews];
    cell.detailTextLabel.text = [[self.hubArray objectAtIndex:indexPath.row] fullLink];
    if ([[self.hubArray objectAtIndex:indexPath.row] isFavorits] == YES) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.hubArray count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (IBAction)addHubButton:(UIBarButtonItem *)sender {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"New feed" message:@"Please type site rss feed's" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    av.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    UITextField *titleRSS = [av textFieldAtIndex:0];
    UITextField *linkRSS = [av textFieldAtIndex:1];
    titleRSS.placeholder = @"Name of our feeds";
    linkRSS.placeholder = @"Type link without http://";
    [linkRSS setSecureTextEntry:NO];
    [av show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    RSSNewsSetting *setting = [RSSNewsSetting new];
    if (self.isEdit == NO) {
        if (buttonIndex == 1) {  //Login
            UITextField *titleRSS = [alertView textFieldAtIndex:0];
            UITextField *linkRSS = [alertView textFieldAtIndex:1];
            
            setting.titleNews = [NSString stringWithString:titleRSS.text];
            setting.fullLink = [NSString stringWithString:linkRSS.text];
            setting.isFavorits = NO;
            setting.isOpen = NO;
            [self.hubArray addObject:setting];
            [self.tableView reloadData];
        }
        self.isEdit = NO;
        [self.tableView reloadData];
    } else {
        if (buttonIndex == 1) {  //Login
            UITextField *titleRSS = [alertView textFieldAtIndex:0];
            UITextField *linkRSS = [alertView textFieldAtIndex:1];
 
            setting.titleNews = [NSString stringWithString:titleRSS.text];
            setting.fullLink = [NSString stringWithString:linkRSS.text];
            setting.isFavorits = NO;
            setting.isOpen = NO;
            [self.hubArray replaceObjectAtIndex:self.indexPathRow withObject:setting];
        }
        self.isEdit = NO;
        [self.tableView reloadData];
    }
    NSLog(@"%@", self.hubArray);
    [[SettingsManager sharedSetting] saveHubs:self.hubArray];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.isEdit = YES;
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Edit feed" message:@"Please edit youre rss feed if you want" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    av.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    UITextField *titleRSS = [av textFieldAtIndex:0];
    UITextField *linkRSS = [av textFieldAtIndex:1];
    titleRSS.text = [[self.hubArray objectAtIndex:indexPath.row] titleNews];
    linkRSS.text = [[self.hubArray objectAtIndex:indexPath.row] fullLink];
    self.indexPathRow = indexPath.row;

    [linkRSS setSecureTextEntry:NO];
    [av show];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        [self.hubArray removeObjectAtIndex:indexPath.row];
        [[SettingsManager sharedSetting] saveHubs:self.hubArray];
        [tableView reloadData]; // tell table to refresh now
    }
}
@end
