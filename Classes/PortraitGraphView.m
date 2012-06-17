//
//  PortraitGraphView.m
//  iAccelGraph
//
//  Created by Giuseppe Tropea on 1/27/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "PortraitGraphView.h"
#import "PortraitGraphScrollView.h"
#import "GraphData.h"

@implementation PortraitGraphView

@synthesize scrollView;;

#pragma mark -
#pragma mark Inizialization

- (id)initWithFrame:(CGRect)frame Title:(NSString *)aTitle 
			 values:(NSMutableArray *)anArray 
		   andColor:(UIColor *)aColor {    
    self = [super initWithFrame:frame];
    if (self) {
		// Inizializzo e aggiungo lo scrollView
		self.scrollView = [[PortraitGraphScrollView alloc] initWithFrame:graphFrame values:anArray andColor:aColor];
		[self addSubview:scrollView];
		[scrollView release];
		
		// Inizializzo e aggiungo la label
		title = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 70, 0, 70, 20)];
		[title setText:aTitle];
		[title setBackgroundColor:[UIColor clearColor]];
		[self addSubview:title];
		[title release];
		
		[self setBackgroundColor:[UIColor whiteColor]];
		
    }
    return self;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [super dealloc];
}

@end
