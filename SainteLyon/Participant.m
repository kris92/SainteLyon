//
//  Participant.m
//  SainteLyon
//
//  Created by Christophe Janot on 26/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import "Participant.h"
#import "Race.h"

@implementation Participant

@synthesize nom = _nom;
@synthesize prenom = _prenom;
@synthesize ville = _ville;

- (Participant *)initWithNom:(NSString *)nom prenom:(NSString *)prenom sexe:(NSString *)sexe ville:(NSString *)ville date:(NSString *)date comment:(NSString *)comment course:(NSString *)course {
    _nom = nom;
    _prenom = prenom;
    _ville = ville;
    [self setCourse:course];
    [self setAge:date];
    [self setDossier:comment];
    [self setSexe:sexe];
    
    return self;
}

- (id *)setCourse:(NSString *)course {
    RaceId raceId = SL_unknown;
    if([course isEqualToString:@"Relais 2 coureurs"]) {
        raceId = SL_Two;
    } else if([course isEqualToString:@"Relais 3 coureurs"]) {
        raceId = SL_Three;
    } else if([course isEqualToString:@"Relais 4 coureurs"]) {
        raceId = SL_Four;
    } else if([course isEqualToString:@"SaintéLyon 75 km - Chrono"]) {
        raceId = SL_75km;
    } else if([course isEqualToString:@"SaintéSprint 21 km - Chrono"]) {
        raceId = SL_21km;
    } else if([course isEqualToString:@"SaintExpress 45 km - Chrono"]) {
        raceId = SL_45km;
    }
    //NSLog(@"T1");
    Race *race = [Race assignRace:raceId participant:self];
    //NSLog(@"T2");
    if(race == nil) {
        NSLog(@"Can't assign to:%@",race.raceName);
    }
        
    return nil;
}

- (Boolean)setDossier:(NSString *)comment {
    if([comment hasPrefix:@"Pour compléter"]) {
        _dossierComplet = false;
    }
    _dossierComplet = true;
    
    return _dossierComplet;
}

- (int)setAge:(NSString *)date {
    return _age;
}

- (char)setSexe:(NSString *)sexe {
    if([sexe isEqualToString:@"Homme"]) {
        _sexe = 'H';
    }
    _sexe = 'F';
    
    return _sexe;
}

- (NSString *)runnerIs {
    return [@"" stringByAppendingFormat:@"%@ %@",_nom,_prenom];
}

@end
