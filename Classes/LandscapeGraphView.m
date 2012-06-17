//
//  LandscapeGraphView.m
//  iAccelGraph
//
//  Created by Giuseppe Tropea on 1/27/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "LandscapeGraphView.h"

#import "LandscapeGraphScrollView.h"
#import "GraphData.h"

@implementation LandscapeGraphView

@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame andGraphData:(GraphData *)aData {
    self = [super initWithFrame:frame];
    if (self) {
		
		// Inizializzo e aggiungo lo scrollView
		self.scrollView = [[LandscapeGraphScrollView alloc] initWithFrame:graphFrame andGraphData:aData];
		[self addSubview:scrollView];
		[scrollView release];
		
		[self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}


@end
