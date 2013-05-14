//
//  RaceCell.h
//  SainteLyon
//
//  Created by Christophe Janot on 26/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pie.h"

@protocol RaceCellProtocol <NSObject>

- (void) cellClicked:(NSInteger)row section:(NSInteger)section;

@end

@interface RaceCell : UITableViewCell {
	NSInteger		row;
	NSInteger		section;
}
@property (weak, nonatomic) IBOutlet UILabel *raceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *runnersCountLabel;
@property (weak, nonatomic) IBOutlet Pie *raceRatioView;
@property	NSInteger		row;
@property	NSInteger		section;

@property	(assign)	id<RaceCellProtocol>	delegate;

- (IBAction) click;

@end
