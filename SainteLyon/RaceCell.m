//
//  RaceCell.m
//  SainteLyon
//
//  Created by Christophe Janot on 26/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import "RaceCell.h"

@implementation RaceCell

@synthesize delegate;
@synthesize row, section;

-(id)init {
    if ( self = [super init] ) {
        [_raceRatioView init];
        NSLog(@"------------- YES");
    } else {
        NSLog(@"------------- NOT");
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    NSLog(@"xxxxxxxxxxxxxxxxxxxxx");
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}

- (IBAction) click
{
	NSLog(@"Clicked");
	[delegate cellClicked:row section:section];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
