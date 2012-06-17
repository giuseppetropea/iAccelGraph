//
//  PortraitGraphScrollView.m
//  iAccelGraph
//
//  Created by Giuseppe Tropea on 2/2/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "PortraitGraphScrollView.h"

@implementation PortraitGraphScrollView

@synthesize axisValues, interval;

#pragma mark -
#pragma mark Inizialization

- (id)initWithFrame:(CGRect)frame 
			 values:(NSMutableArray *)anArray 
		   andColor:(UIColor *)aColor {
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
		
		//Setto il colore del grafico
		color = aColor;
		
		//Mi inizializzo l'array che deve contenere i valori dell'accelerometro.
		axisValues = anArray;
				
		zero = CGPointMake(0, self.frame.size.height / 2);
		
		if ([axisValues count] > NUMBEROFVALUESDISPLAYED) {
			//...aumento l'area del grafo...
			self.contentSize = CGSizeMake((self.frame.size.width / NUMBEROFVALUESDISPLAYED) * [axisValues count], self.frame.size.height);
			//...e sposto automaticamente il focus
			self.contentOffset = CGPointMake((self.frame.size.width / NUMBEROFVALUESDISPLAYED) * [axisValues count] - self.frame.size.width, self.contentOffset.y);
		}
    }
    return self;
}

- (void)drawRect:(CGRect)rect {			
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetLineWidth(context, 1.0);
	CGContextSetStrokeColorWithColor(context, [color CGColor]);
	
	
	
	for (int i = 1; i < [axisValues count]; i++) {
		CGContextMoveToPoint(context, zero.x + (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * (i - 1), zero.y + (self.frame.size.height / 6) * [[axisValues objectAtIndex:(i - 1)] floatValue]);
		CGContextAddLineToPoint(context, zero.x + (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * i, zero.y + (self.frame.size.height / 6) * [[axisValues objectAtIndex:i] floatValue]);
		CGContextStrokePath(context);
	}
	
	interval = [NSNumber numberWithFloat:[[UIAccelerometer sharedAccelerometer] updateInterval]];
	CGContextSetLineWidth(context, 0.5);
	CGContextSetStrokeColorWithColor(context,[[UIColor blackColor] CGColor]);
	for (int i = 1; i < self.contentSize.width - 1; i++) {
		CGContextMoveToPoint(context, (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * i * (1 / [interval floatValue]), 0);
		CGContextAddLineToPoint(context, (self.frame.size.width / NUMBEROFVALUESDISPLAYED) * i * (1 / [interval floatValue]), self.frame.size.height);
		CGContextStrokePath(context);
	}
}

#pragma mark -
#pragma mark Refresh line

- (void)refreshView {
	//Se scrivo su tutta la parte visibile...
	if ([axisValues count] > NUMBEROFVALUESDISPLAYED) {
		//...aumento l'area del grafo...
		self.contentSize = CGSizeMake((self.frame.size.width / NUMBEROFVALUESDISPLAYED) * [axisValues count], self.frame.size.height);
		//...e sposto automaticamente il focus
		self.contentOffset = CGPointMake((self.frame.size.width / NUMBEROFVALUESDISPLAYED) * [axisValues count] - self.frame.size.width, self.contentOffset.y);
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
