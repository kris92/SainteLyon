//
//  ViewController.m
//  SainteLyon
//
//  Created by Christophe Janot on 26/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import "ViewController.h"
#import "Race.h"
#import "RaceCell.h"
#import "WebParser.h"

@interface ViewController ()

@end

@implementation ViewController

static Race *rm;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[_activityIndicator removeFromSuperview];
    //[_slImage removeFromSuperview];
    //[_slImage addSubview:_activityIndicator];
    [self.view sendSubviewToBack:_slImage];
    //[_activityIndicator setFrame:CGRectMake(0, 0, 100, 100)];
    //[_activityIndicator removeFromSuperview];
    //[[self tableView] addSubview:_activityIndicator];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"T1");
    rm = [Race racesManager];
    NSLog(@"T2");
    wp = [WebParser alloc];
    NSLog(@"T3");
    [wp setDelegate:self];
    NSLog(@"T4");
    
    
    /*NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                           selector:@selector(spin)
                                           object:nil];
    
    [myThread start];  // Actually create the thread*/
    
    
    [_activityIndicator setColor:[UIColor orangeColor]];
    [_activityIndicator setHidden:FALSE];
}

-(void)loading {
    [_activityIndicator startAnimating];
    [_activityIndicator setHidesWhenStopped:TRUE];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    
    /*UIActivityIndicatorView *activityIndicatorTemp = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicatorTemp setCenter:[[self tableView] center]];
    [self setActivityIndicator: activityIndicatorTemp];
    [[self tableView] addSubview:activityIndicatorTemp];
    [activityIndicatorTemp startAnimating];*/
    //[self setActivityIndicator:<#(UIActivityIndicatorView *)#>]
    
    [self readSainteLyon];
}

- (void)readSainteLyon {
    NSLog(@"readSainteLyon");
    [wp readUrl:@"http://sport16.valraiso.info/inscription-sport16/participer/resultats"];
    //[_activityIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark WebParserDelegate

-(void)pageLoaded:(char)pageId {
    NSLog(@"pageLoaded %c",pageId);
    [_tableView reloadData];
}

-(void)loadDone {
    NSLog(@"loadDone");
    NSLog(@"************************** STOP ***********************");
    [_activityIndicator stopAnimating];
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Race racesCount]-1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 58;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"RaceCell";
    RaceCell *cell = (RaceCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RaceCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if( [currentObject isKindOfClass:[UITableViewCell class]] ) {
                cell = (RaceCell *) currentObject;
                [cell init];
				break;
			}
		}
    }
    
    int rid = [indexPath indexAtPosition:1] + 1;
    Race *race = [Race getRace:rid];
    /*if(race != nil) {
        NSLog(@"raceName=%@ count=%d",race.raceName,[race participantsCount]);
    }*/
    //NSLog(@"IndexPath %@ %d",indexPath,[indexPath indexAtPosition:1]);
    
    cell.raceNameLabel.text = race.raceName;
    cell.runnersCountLabel.text = [NSString stringWithFormat:@"%d",[race participantsCount]];
    [cell.raceRatioView setPieRatio:[race raceRatio]];
    [cell setNeedsDisplay];
    [cell setNeedsLayout];
    
    return cell;
}

#pragma mark -

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -

- (IBAction)load:(id)sender {
    [self readSainteLyon];
    [_tableView reloadData];
}
@end
