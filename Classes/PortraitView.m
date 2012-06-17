//
//  PortraitView.m
//  iAccelGraph
//
//  Created by Giuseppe Tropea on 1/27/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "PortraitView.h"
#import "PortraitGraphView.h"
#import "GraphData.h"

@implementation PortraitView

@synthesize xAxis, yAxis, zAxis;

#pragma mark -
#pragma mark Inizialization

- (id)initWithFrame:(CGRect)frame andGraphData:(GraphData *)aData {
    
    self = [super initWithFrame:frame];
    if (self) {
		// Calcolo l'altezza massima delle 3 view
		float height = (frame.size.height - 105) / 3;
		// Creo le 3 view...
        xAxis = [[PortraitGraphView alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, height) 
												   Title:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_AXIS_X_", @"")]
												  values:aData.xValues
												andColor:[UIColor redColor]];
		yAxis = [[PortraitGraphView alloc] initWithFrame:CGRectMake(0, height + 5, frame.size.width, height) 
												   Title:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_AXIS_Y_", @"")]
												  values:aData.yValues
												andColor:[UIColor greenColor]];
		zAxis = [[PortraitGraphView alloc] initWithFrame:CGRectMake(0, height * 2 + 5, frame.size.width, height) 
												   Title:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_AXIS_Z_", @"")]
												  values:aData.zValues
												andColor:[UIColor blueColor]];
		// ...le aggiungo...
		[self addSubview:xAxis];
		[self addSubview:yAxis];
		[self addSubview:zAxis];
		
		//...e le rilascio.
		[xAxis release];
		[yAxis release];
		[zAxis release];
		
    }
    return self;
}

- (void)refreshView {
	[xAxis.scrollView refreshView];
	[yAxis.scrollView refreshView];
	[zAxis.scrollView refreshView];
}

- (void)resetView {
	[xAxis.scrollView resetView];
	[yAxis.scrollView resetView];
	[zAxis.scrollView resetView];	
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [super dealloc];
}


@end
