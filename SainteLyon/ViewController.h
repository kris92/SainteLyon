//
//  ViewController.h
//  SainteLyon
//
//  Created by Christophe Janot on 26/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebParser.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,WebParserDelegate> {
    WebParser *wp;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *slImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)load:(id)sender;

@end
