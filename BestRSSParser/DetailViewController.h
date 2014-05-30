//
//  DetailViewController.h
//  BestRSSParser
//
//  Created by Andrey Starostenko on 28.05.14.
//  Copyright (c) 2014 nixsolution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) NSString *link;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
