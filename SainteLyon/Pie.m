//
//  Pie.m
//  SainteLyon
//
//  Created by Christophe Janot on 29/04/13.
//  Copyright (c) 2013 Christophe Janot. All rights reserved.
//

#import "Pie.h"
#import <QuartzCore/QuartzCore.h>

@implementation Pie

static CGFloat bgFillColour[4] = {1.0,1.0,1.0,0.0};
static CGFloat shadowFillColour[4] = {0.5,0.5,0.5,1.0};
static CGFloat redColour[4] = {1.0,0.0,0.0,1.0};
static CGFloat orangeColour[4] = {1.0,0.8,0.0,1.0};
static CGFloat greenColour[4] = {0.0,1.0,0.0,1.0};

#define PI 3.14159265358979323846
static inline float radians(double degrees) { return degrees * PI / 180; }

//@synthesize ratio = _ratio;

-(id)init {
    if ( self = [super init] ) {
        [self.layer setCornerRadius:8.0f];
        self.layer.borderColor = [UIColor blueColor].CGColor;
        self.layer.borderWidth = 1.0f;
        [self.layer setMasksToBounds:YES];
        NSLog(@">>>>>>>>>>>>> YES");
    } else {
        NSLog(@">>>>>>>>>>>>> NOT");
    }
    return self;
}

-(void)setPieRatio:(float)aRatio {
    angleRatio = aRatio;
    NSLog(@"setPieRatio=%f",angleRatio);
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGRect parentViewBounds = self.bounds;
    CGFloat x = CGRectGetWidth(parentViewBounds)/2;
	CGFloat y = CGRectGetHeight(parentViewBounds)/2;
    NSLog(@"bounds:%f,%f",x,y);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSetFillColor(ctx, bgFillColour);
    CGContextFillRect(ctx, rect);
    
    CGContextSetFillColor(ctx, shadowFillColour);
    CGContextMoveToPoint(ctx, x+2, y+2);
    float r = (360*angleRatio) - 90;
    NSLog(@"angle ratio=%f",angleRatio);
    NSLog(@"r=%f",r);
    CGContextAddArc(ctx, x+2, y+2, 20, radians(-90), radians(r), 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    if(angleRatio < 0.6) {
        CGContextSetFillColor(ctx, greenColour);
    } else if(angleRatio < 0.8) {
        CGContextSetFillColor(ctx, orangeColour);
    } else {
        CGContextSetFillColor(ctx, redColour);
    }
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddArc(ctx, x, y, 20, radians(-90), radians(r), 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
}

@end
