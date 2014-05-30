//
//  RSSTableViewCell.h
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *rssTitle;
@property (weak, nonatomic) IBOutlet UILabel *rssDescription;
@property (weak, nonatomic) IBOutlet UILabel *rssDate;


@end
