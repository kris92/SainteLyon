//
//  WebParser.m
//  SainteLyon
//
//  Created by Christophe Janot on 26/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import "WebParser.h"
#import "TFHpple.h"
#import "Participant.h"

@implementation WebParser

static NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//static NSString *alphabet = @"ABCDEFGHIJKLMN";

- (Boolean)readUrl:(NSString *)anUrl {
    webUrl = anUrl;
    NSURL *url = [NSURL URLWithString:[webUrl stringByAppendingString:@"?code=saintelyon"]];
    NSData *tmpData = [NSData dataWithContentsOfURL:url];
    NSLog([@"FirstPage read: " stringByAppendingFormat:@"%d",[tmpData length]]);
    
    runners = [[NSMutableArray alloc] init];
    
    
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    
    dispatch_async(myQueue, ^{
        // Perform long running process
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [_delegate loading];
        });
        for(int i=0;i<alphabet.length;i++) {
            [self readPage:[alphabet characterAtIndex:i]];
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                [_delegate pageLoaded:[alphabet characterAtIndex:i]];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [_delegate loadDone];
        });
    });
    
    return true;
}

- (Boolean)readPage:(char)aPageId {
    NSURL *url = [NSURL URLWithString:[webUrl stringByAppendingFormat:@"?lettre=%c",aPageId]];
    NSData *tmpData = [NSData dataWithContentsOfURL:url];
    NSLog([@"SecondPage read: " stringByAppendingFormat:@"%d",[tmpData length]]);
    
    TFHpple *slParser = [TFHpple hppleWithHTMLData:tmpData];
    NSString *slXpathQueryString = @"//tr";
    NSArray *slNodes = [slParser searchWithXPathQuery:slXpathQueryString];
    for (TFHppleElement *element in slNodes) {
        int fieldId = 0;
        Participant *runner = [[Participant alloc] init];
        [runners addObject:runner];
        for (TFHppleElement *child in element.children) {
            if([[child tagName] isEqualToString:@"td"]) {
                //NSLog(@"v[%d]=%@",fieldId,[[child firstChild] content]);
                if(fieldId == FIELD_NOM) {
                    [runner setNom:[[child firstChild] content]];
                    //NSLog(@"Nom=%@",[[child firstChild] content]);
                } else if(fieldId == FIELD_PRENOM) {
                    [runner setPrenom:[[child firstChild] content]];
                    //NSLog(@"Prenom=%@",[[child firstChild] content]);
                } else if(fieldId == FIELD_VILLE) {
                    [runner setVille:[[child firstChild] content]];
                    //NSLog(@"Ville=%@",[[child firstChild] content]);
                } else if(fieldId == FIELD_SEXE) {
                    [runner setSexe:[[child firstChild] content]];
                    //NSLog(@"Sexe=%@",[[child firstChild] content]);
                } else if(fieldId == FIELD_NAISSANCE) {
                    [runner setAge:[[child firstChild] content]];
                    //NSLog(@"Date=%@",[[child firstChild] content]);
                } else if(fieldId == FIELD_COURSE) {
                    [runner setCourse:[[child firstChild] content]];
                    //NSLog(@"Coursee=%@",[[child firstChild] content]);
                } else if(fieldId == FIELD_COMMENT) {
                    [runner setDossier:[[child firstChild] content]];
                    //NSLog(@"Dossier=%@",[[child firstChild] content]);
                }
            } else {
                fieldId--;
            }
            fieldId++;
        }
        //NSLog(@"Runner is %@",[runner runnerIs]);
        /*NSString *test1 = [element content];
        NSLog(@"1=%@",test1);*/
        //NSString *test2 = [[element firstChild] content];
        //NSLog(@"2=%@",test2);
        /*NSString *nom = [[element firstChild] content];
        NSLog(@"nom=%@",nom);
        NSString *test = [[element objectForKey:@"td"] content];
        NSLog(@"nom=%@",test);*/
    }
    
    return true;
}

@end
