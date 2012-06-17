//
//  LandscapeScrollView.m
//  iAccelGraph
//
//  Created by Giuseppe Tropea on 2/3/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "LandscapeGraphScrollView.h"

#import "GraphData.h"

@implementation LandscapeGraphScrollView

#pragma mark -
#pragma mark Inizializzation

- (id)initWithFrame:(CGRect)frame andGraphData:(GraphData *)aData {
	
    self = [super initWithFrame:frame];
    if (self) {
		//Setto lo sfondo trasparente in modo che si veda l'area del grafo
        [self setBackgroundColor:[UIColor clearColor]];
		
		//Inizializzo lo scroll
		self.contentSize = frame.size;
		self.showsHorizontalScrollIndicator = YES;
		self.showsVerticalScrollIndicator = NO;
		self.scrollEnabled = YES;
		self.decelerationRate = UIScrollViewDecelerationRateFast;
		self.delegate = self;
		
		// Inizializzo di graphData
		graphData = aData;
		
		zero = CGPointMake(0, self.frame.size.height / 2);
		
		if ([[graphData xValues] count] > NUMBEROFVALUESDISPLAYED) {
			//...aumento l'area del grafo...
			self.contentSize = CGSizeMake((self.frame.size.width / NUMBEROFVALUESDISPLAYED) * [[graphData xValues] count], self.frame.size.height);
			//...e sposto automaticamente il focus
			self.contentOffset = CGPointMake((self.frame.size.width / NUMBEROFVALUESDISPLAYED) * [[graphData xValues] count] - self.frame.size.width, self.contentOffset.y);
		}
    }
    return self;
}

- (void)drawRect:(CGRect)rect {	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetLineWidth(context, 1.0);
	
	for (int i = 1; i < [[graphData xValues] count]; i++) {
		// Traccio i valori di X
		CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
		CGContextMoveToPoint(context, zero.x + (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * (i - 1), zero.y + (self.frame.size.height / 6) * [[[graphData xValues] objectAtIndex:(i - 1)] floatValue]);
		CGContextAddLineToPoint(context, zero.x + (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * i, zero.y + (self.frame.size.height / 6) * [[[graphData xValues] objectAtIndex:i] floatValue]);
		CGContextStrokePath(context);
		
		// Traccio i valori di Y
		CGContextSetStrokeColorWithColor(context, [[UIColor greenColor] CGColor]);
		CGContextMoveToPoint(context, zero.x + (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * (i - 1), zero.y + (self.frame.size.height / 6) * [[[graphData yValues] objectAtIndex:(i - 1)] floatValue]);
		CGContextAddLineToPoint(context, zero.x + (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * i, zero.y + (self.frame.size.height / 6) * [[[graphData yValues] objectAtIndex:i] floatValue]);
		CGContextStrokePath(context);
		
		// Traccio i valori di z
		CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
		CGContextMoveToPoint(context, zero.x + (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * (i - 1), zero.y + (self.frame.size.height / 6) * [[[graphData zValues] objectAtIndex:(i - 1)] floatValue]);
		CGContextAddLineToPoint(context, zero.x + (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * i, zero.y + (self.frame.size.height / 6) * [[[graphData zValues] objectAtIndex:i] floatValue]);
		CGContextStrokePath(context);
	}
	// Disegno la scala dei secondi
	CGContextSetLineWidth(context, 0.5);
	CGContextSetStrokeColorWithColor(context,[[UIColor blackColor] CGColor]);
	for (int i = 0; i < self.contentSize.width; i++) {
		CGContextMoveToPoint(context, (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * i * (1 / [graphData.interval floatValue]), 0);
		CGContextAddLineToPoint(context, (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * i * (1 / [graphData.interval floatValue]), self.frame.size.height);
		CGContextStrokePath(context);
	}
}

#pragma mark -
#pragma mark Refresh line

- (void)refreshView {
	//Se scrivo su tutta la parte visibile...
	if ([[graphData xValues] count] > NUMBEROFVALUESDISPLAYED) {
		//...aumento l'area del grafo...
		self.contentSize = CGSizeMake((self.frame.size.width / NUMBEROFVALUESDISPLAYED) * [[graphData xValues] count], self.frame.size.height);
		//...e sposto automaticamente il focus
		self.contentOffset = CGPointMake((self.frame.size.width / NUMBEROFVALUESDISPLAYED) * [[graphData xValues] count] - self.frame.size.width, self.contentOffset.y);
	}
	
	[self setNeedsDisplay];
}

- (void)resetView {
	//Resetto lo scroll
	self.contentOffset = CGPointZero;
	self.contentSize = self.frame.size;
	
	[self setNeedsDisplay];
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	//Ridisegno la view con i valori dell'area scrollata
	[self setNeedsDisplay];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [super dealloc];
}

@end
