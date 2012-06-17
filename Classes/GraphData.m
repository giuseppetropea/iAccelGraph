//
//  GraphData.m
//  iAccelGraph2
//
//  Created by Giuseppe Tropea on 1/27/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "GraphData.h"


@implementation GraphData

@synthesize title, xValues, yValues, zValues, isSaved, numberOfValuesSaved, interval;

- (id) init {
	self = [super init];
	if (self) {
		
		self.title = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_NEW_CHART_", @"")]];
				
		self.xValues = [[NSMutableArray alloc] init];
		self.yValues = [[NSMutableArray alloc] init];
		self.zValues = [[NSMutableArray alloc] init];
		
		self.isSaved = NO;
		
		self.interval = [[NSNumber alloc] initWithFloat:0.5];
		self.numberOfValuesSaved = [[NSNumber alloc] initWithInt:300];
		
		
	}
	return self;
	
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
	if (self) {
		self.title = [aDecoder decodeObjectForKey:@"title"];
		self.xValues = [aDecoder decodeObjectForKey:@"xValues"];
		self.yValues = [aDecoder decodeObjectForKey:@"yValues"];
		self.zValues = [aDecoder decodeObjectForKey:@"zValues"];
		
		self.isSaved = [aDecoder decodeBoolForKey:@"isSaved"];
		
		self.interval = [aDecoder decodeObjectForKey:@"interval"];
		self.numberOfValuesSaved = [aDecoder decodeObjectForKey:@"numberOfValuesSaved"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.title forKey:@"title"];
	[coder encodeObject:self.xValues forKey:@"xValues"];
	[coder encodeObject:self.yValues forKey:@"yValues"];
	[coder encodeObject:self.zValues forKey:@"zValues"];
	
	[coder encodeBool:self.isSaved forKey:@"isSaved"];

	[coder encodeObject:self.interval forKey:@"interval"];
	[coder encodeObject:self.numberOfValuesSaved forKey:@"numberOfValuesSaved"];
}

- (void)dealloc {
	[self.title release];
	
	[self.xValues release];
	[self.yValues release];
	[self.zValues release];
	
	[self.interval release];
	[self.numberOfValuesSaved release];
	
    
	[super dealloc];
}

@end
