//
//  LegendView.m
//  iAccelGraph
//
//  Created by Giuseppe Tropea on 1/28/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "LegendView.h"


@implementation LegendView

#pragma mark -
#pragma mark Inizialization

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
		
		// Label "Asse X"
		UILabel *xAxis = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 70, 20)];
		[xAxis setText:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_AXIS_X_", @"")]];
		[self addSubview:xAxis];
		[xAxis release];
		
		// Label "Asse Y"
		UILabel *yAxis = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 30, 5, 70, 20)];
		[yAxis setText:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_AXIS_Y_", @"")]];
		[self addSubview:yAxis];
		[yAxis release];
		
		// Label "Asse Z"
		UILabel *zAxis = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 90, 5, 70, 20)];
		[zAxis setText:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_AXIS_Z_", @"")]];
		[self addSubview:zAxis];
		[zAxis release];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	// Ottengo il contesto grafico
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Disegno il quadratino dell'asse x (rosso)
	CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
	CGContextAddRect(context, CGRectMake(20, 5, 20, 20));
	CGContextFillPath(context);
	
	// Disegno il quadratino dell'asse y (verde)
	CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
	CGContextAddRect(context, CGRectMake(self.frame.size.width / 2 - 60, 5, 20, 20));
	CGContextFillPath(context);
	
	// Disegno il quadratino dell'asse z (blu)
	CGContextSetFillColorWithColor(context, [[UIColor blueColor] CGColor]);
	CGContextAddRect(context, CGRectMake(self.frame.size.width - 120, 5, 20, 20));
	CGContextFillPath(context);
	
	
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [super dealloc];
}


@end
