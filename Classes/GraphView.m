//
//  GraphView.m
//  iAccelGraph
//
//  Created by Giuseppe Tropea on 1/27/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "GraphView.h"


@implementation GraphView

@synthesize graphFrame;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
		graphFrame = CGRectMake(20, 20, self.frame.size.width - 30, self.frame.size.height - 30);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	//Disegno i bordi dell'area del grafo
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextSetLineWidth(context, 2.0);
	CGContextAddRect(context, graphFrame);
	CGContextStrokePath(context);
	
	//Coloro di grigio l'area del grafo
	CGContextSetRGBFillColor(context, 0.9, 0.9, 0.9, 1.0);
	CGContextAddRect(context, graphFrame);
	CGContextFillPath(context);
	
	//Disegno le righe del grafo
	CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
	CGContextSetLineWidth(context, 1.0);
	for (int i = 0; i < 7; i++) {
		CGContextMoveToPoint(context, graphFrame.origin.x, graphFrame.origin.y + graphFrame.size.height / 6 * i);
		CGContextAddLineToPoint(context, graphFrame.origin.x + graphFrame.size.width, graphFrame.origin.y + graphFrame.size.height / 6 * i);
	}
	CGContextStrokePath(context);
	
	//Scrivo la scala dei G
	NSString *text;
	UIFont *font = [UIFont systemFontOfSize:10];
	CGRect textRect;
	text = @" g";
	textRect.size = [text sizeWithFont:font];
	textRect.origin.x = 15.0;
	textRect.origin.y = 5.0;
	[[UIColor blueColor] setFill];
	[text drawInRect:textRect withFont:font];
	
	text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"_SECONDS_", @"")];
	textRect.size = [text sizeWithFont:font];
	textRect.origin.x = graphFrame.origin.x + graphFrame.size.width - 35;
	textRect.origin.y = graphFrame.origin.y + graphFrame.size.height;
	[[UIColor blueColor] setFill];
	[text drawInRect:textRect withFont:font];
	
	textRect.origin.x = 0.0;
	textRect.origin.y = 5.0;
	for (int i = 0; i < 7; i++) {
		if (i < 3) {
			text = [NSString stringWithFormat:@" +%d", 3 - i];
		} else if (i == 3) {
			text = [NSString stringWithFormat:@"  %d", 3 - i];
		} else {
			text = [NSString stringWithFormat:@" %d", 3- i];
		}
		textRect.size = [text sizeWithFont:font];
		textRect.origin.y = (graphFrame.origin.y + graphFrame.size.height / 6 * i) - 6;
		[text drawInRect:textRect withFont:font];
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
