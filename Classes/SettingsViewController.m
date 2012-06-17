//
//  SettingsViewController.m
//  iAccelGraph
//
//  Created by Giuseppe Tropea on 2/27/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "SettingsViewController.h"
#import "GraphData.h"

#define INTERVALS_COMPONET 0
#define NUMBERSOFVALUESSAVED_COMPONENT 1

@implementation SettingsViewController

- (id)initWithGraphData:(GraphData *)aData andEditable:(BOOL)editable {
	self = [super init];
	if (self) {
		graphData = aData;
		
		CGRect frame = [[UIScreen mainScreen] bounds];
		
		NSMutableArray *intervalsArray = [[NSMutableArray alloc] initWithCapacity:10];
		for (int i = 0; i < 10; i++) {
			[intervalsArray addObject:[NSNumber numberWithFloat: (float)(i+1)/10]];
		}
		
		NSMutableArray *numbersOfValuesSavedArray = [[NSMutableArray alloc] initWithCapacity:10];
		for (int i = 0; i < 20; i++) {
			[numbersOfValuesSavedArray addObject:[NSNumber numberWithInt:(i+1)*100]];
		}
		
		settings = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:intervalsArray, numbersOfValuesSavedArray, nil]
												 forKeys:[NSArray arrayWithObjects:@"intervalsArray", @"numbersOfValuesSavedArray", nil]];
		[intervalsArray release];
		[numbersOfValuesSavedArray release];
		
		
		//Inizializzazione contentView
		UIView *contentView = [[UIView alloc] init];
		[contentView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
		
		UILabel *labelIntervals = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 202, frame.size.width / 2, 20)];
		[labelIntervals setText:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_SET_INTERVAL_", @"")]];
		[labelIntervals setBackgroundColor:[UIColor darkGrayColor]];
		[labelIntervals setTextColor:[UIColor whiteColor]];
		[labelIntervals setTextAlignment:UITextAlignmentCenter];
		[contentView addSubview:labelIntervals];
		[labelIntervals release];
		
		UILabel *labelValues = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 2, frame.size.height - 202, frame.size.width / 2, 20)];
		[labelValues setText:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_STORE_LAST_", @"")]];
		[labelValues setBackgroundColor:[UIColor darkGrayColor]];
		[labelValues setTextColor:[UIColor whiteColor]];
		[labelValues setTextAlignment:UITextAlignmentCenter];
		[contentView addSubview:labelValues];
		[labelValues release];
		
		pickerView = [[UIPickerView alloc] init];
		[pickerView setFrame:CGRectMake(0, frame.size.height - 182, frame.size.width, 162)];
		pickerView.showsSelectionIndicator = YES;
		[pickerView setDelegate:self];
		[pickerView setDataSource:self];
		[pickerView selectRow:(int)([graphData.interval floatValue] * 10 - 1) inComponent:INTERVALS_COMPONET animated:NO];
		[pickerView selectRow:([graphData.numberOfValuesSaved intValue] / 100 - 1) inComponent:NUMBERSOFVALUESSAVED_COMPONENT animated:NO];

		[contentView addSubview:pickerView];
		[pickerView release];
		
		if (!editable) {
			UIView *disable = [[UIView alloc] initWithFrame:pickerView.frame];
			[disable setBackgroundColor:[UIColor blackColor]];
			[disable setAlpha:0.5];
			[contentView addSubview:disable];
			[disable release];
		}

		self.view = contentView;
		[contentView release];
	}
	return self;
}

#pragma mark -
#pragma mark PickerViewDelegate

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (component == INTERVALS_COMPONET) {
		return [NSString stringWithFormat:@"%.2f %@", [[[settings objectForKey:@"intervalsArray"] objectAtIndex:row] floatValue], [NSString stringWithFormat:@"%@",NSLocalizedString(@"_SECONDS_", @"")]];
	}
	return [NSString stringWithFormat:@"%d %@", [[[settings objectForKey:@"numbersOfValuesSavedArray"] objectAtIndex:row] intValue], [NSString stringWithFormat:@"%@",NSLocalizedString(@"_VALUES_", @"")]];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return [settings count];
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if (component == INTERVALS_COMPONET) {
		return [[settings objectForKey:@"intervalsArray"] count];
	}
	return [[settings objectForKey:@"numbersOfValuesSavedArray"] count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (component == INTERVALS_COMPONET) {
		graphData.interval = [[settings objectForKey:@"intervalsArray"] objectAtIndex:row];
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:[graphData.interval floatValue]];
	} else {
		graphData.numberOfValuesSaved = [[settings objectForKey:@"numbersOfValuesSavedArray"] objectAtIndex:row];
	}
	
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[settings release];
    [super dealloc];
}


@end
