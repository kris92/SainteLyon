//
//  Participant.h
//  SainteLyon
//
//  Created by Christophe Janot on 26/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Participant : NSObject {
    char _sexe;
    int _age;
    Boolean _dossierComplet;
}

@property NSString *nom;
@property NSString *prenom;
@property NSString *ville;

- (Participant *)initWithNom:(NSString *)nom prenom:(NSString *)prenom ville:(NSString *)ville date:(NSString *)date comment:(NSString *)comment course:(NSString *)course;
- (id *)setCourse:(NSString *)course;
- (Boolean)setDossier:(NSString *)comment;
- (int)setAge:(NSString *)date;
- (char)setSexe:(NSString *)sexe;

- (NSString *)runnerIs;
@end
