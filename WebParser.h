//
//  WebParser.h
//  SainteLyon
//
//  Created by Christophe Janot on 26/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FIELD_NOM       = 0,
    FIELD_PRENOM    = 1,
    FIELD_SEXE      = 2,
    FIELD_NAISSANCE = 3,
    FIELD_VILLE     = 4,
    FIELD_COMMENT   = 5,
    FIELD_COURSE    = 6
} FieldId;

@protocol WebParserDelegate

-(void)loading;
-(void)pageLoaded:(char)pageId;
-(void)loadDone;

@end

@interface WebParser : NSObject {
    NSString *webUrl;
    NSMutableArray *runners;
}

@property (nonatomic, weak) id<WebParserDelegate> delegate;

- (Boolean)readUrl:(NSString *)anUrl;

@end
