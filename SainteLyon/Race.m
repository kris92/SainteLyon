//
//  Race.m
//  SainteLyon
//
//  Created by Christophe Janot on 29/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import "Race.h"

@implementation Race

static Race *RacesManager = nil;
static NSMutableArray *races;

@synthesize raceName = _raceName;
@synthesize raceMaxParticipants = _raceMaxParticipants;

- (id)initWithName:(NSString *)aName maxParticipants:(int)max {
    _raceName = aName;
    _raceMaxParticipants = max;
    participants = [[NSMutableArray alloc] init];
    NSLog(@"alloc %@",aName);
    NSLog(@" parts %d",[participants count]);
    
    return self;
}

- (void)addParticipant:(Participant *)aParticipant {
    if(participants != nil) {
        [participants addObject:aParticipant];
    } else {
        NSLog(@"participants is nil");
    }
}

+ (int)racesCount {
    return [races count];
}

- (int)participantsCount {
    return [participants count];
}

- (float)raceRatio {
    if(_raceMaxParticipants > 0) {
        return ((float)[self participantsCount]) / _raceMaxParticipants;
    }
    return 0.0;
}

+ (Race *)getRace:(RaceId)raceId {
    if(raceId >= [races count]) {
        return [races objectAtIndex:0];
    }
    return [races objectAtIndex:raceId];
}

+ (Race *)assignRace:(RaceId)raceId participant:(Participant *)aParticipant {
    Race *race;
    
    if(raceId >= [races count]) {
        race = [races objectAtIndex:0];
    } else {
        race = [races objectAtIndex:raceId];
    }
    
    if(race != nil) {
        [race addParticipant:aParticipant];
    } else {
         NSLog(@"NO Race");
    }
    
    return race;
}

+ (Race *)racesManager {
    if(!RacesManager) {
        NSLog(@"racesManager");
        RacesManager = [[self allocWithZone:NULL] init];
        races = [[NSMutableArray alloc] init];
        [races addObject:[[Race alloc] initWithName:@"???" maxParticipants:0]];
        [races addObject:[[Race alloc] initWithName:@"SaintéLyon" maxParticipants:6000]];
        [races addObject:[[Race alloc] initWithName:@"SaintéSprint" maxParticipants:1500]];
        [races addObject:[[Race alloc] initWithName:@"Relais 2" maxParticipants:250]];
        [races addObject:[[Race alloc] initWithName:@"Relais 3" maxParticipants:250]];
        [races addObject:[[Race alloc] initWithName:@"Relais 4" maxParticipants:550]];
        [races addObject:[[Race alloc] initWithName:@"SaintExpress" maxParticipants:2500]];
    }
    NSLog(@"racesManager passed");
    
    return RacesManager;
}

@end
