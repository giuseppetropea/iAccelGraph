//
//  LandscapeView.m
//  iAccelGraph
//
//  Created by Giuseppe Tropea on 1/27/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "LandscapeView.h"
#import "LandscapeGraphView.h"
#import "LegendView.h"
#import "GraphData.h"

@implementation LandscapeView

@synthesize axes;

- (id)initWithFrame:(CGRect)frame andGraphData:(GraphData *)aData {
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor whiteColor]];
        self.axes = [[LandscapeGraphView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 105)  andGraphData:aData];
		[self addSubview:axes];
		[self.axes release];
		
		LegendView *legend = [[LegendView alloc] initWithFrame:CGRectMake(0, frame.size.height - 110, frame.size.width, 30)];
		[self addSubview:legend];
		[legend release];
    }
    return self;
}

- (void)refreshView {
	[axes.scrollView refreshView];
}

- (void)resetView {
	[axes.scrollView resetView];	
}

- (void)dealloc {
    [super dealloc];
}


@end
