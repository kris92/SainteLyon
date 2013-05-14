//
//  Race.h
//  SainteLyon
//
//  Created by Christophe Janot on 29/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Participant.h"

typedef enum {
    SL_unknown  = 0,
    SL_75km     = 1,
    SL_21km     = 2,
    SL_Three    = 3,
    SL_Four     = 4,
    SL_Two      = 5,
    SL_45km     = 6
} RaceId;

@interface Race : NSObject {
    RaceId raceId;
    int maxParticipants;
    NSMutableArray *participants;
}

@property (nonatomic, retain)	NSString		*raceName;
@property int			raceMaxParticipants;

- (void)addParticipant:(Participant *)aParticipant;
+ (int)racesCount;
- (int)participantsCount;
- (float)raceRatio;
+ (Race *)getRace:(RaceId)raceId;
+ (Race *)assignRace:(RaceId)raceId participant:(Participant *)aParticipant;
+ (Race *)racesManager;

@end
