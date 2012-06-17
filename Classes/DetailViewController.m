//
//  DetailViewController.m
//  iAccelGraph2
//
//  Created by Giuseppe Tropea on 1/27/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "DetailViewController.h"
#import "GraphData.h"

#import "PortraitView.h"
#import "PortraitGraphView.h"
#import "PortraitGraphScrollView.h"

#import "LandscapeView.h"
#import "LandscapeGraphView.h"
#import "LandscapeGraphScrollView.h"

#import "SettingsViewController.h"

@implementation DetailViewController

@synthesize graphData;

- (id)initWithGraphData:(GraphData *)aData {
	self = [super init];
	if (self) {
		
		graphData = aData;

		// Inizializzazione navigation bar
		self.navigationItem.title = graphData.title;
		UIBarButtonItem *startButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_START_", @"")] style:UIBarButtonItemStyleBordered target:self action:@selector(startButtonPressed:)];
		self.navigationItem.rightBarButtonItem = startButtonItem;
		[startButtonItem release];
		UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_BACK_", @"")] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed:)];
		self.navigationItem.leftBarButtonItem = backButtonItem;
		[backButtonItem release];
		
		// Inizializzazioni variabili
		CGRect frame = [[UIScreen mainScreen] bounds];
		
		isStarted = NO;
		isEditable = YES;
		
		// Inizializzazione toolbar
		toolbar = [[UIToolbar alloc] init];
		toolbar.barStyle = UIBarStyleDefault;
		[toolbar sizeToFit];
		[self.view addSubview:toolbar];
		[toolbar release];
		
		UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(saveButtonPressed:)];
		UIBarButtonItem *photoButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(photoButtonPressed:)];
		UIBarButtonItem *resetButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(resetButtonPressed:)];
		UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settingsIco.png"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonPressed:)];
		UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		[toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceButtonItem, saveButtonItem, flexibleSpaceButtonItem, photoButtonItem, flexibleSpaceButtonItem, resetButtonItem, flexibleSpaceButtonItem, settingsButtonItem, flexibleSpaceButtonItem, nil]];
		[saveButtonItem release];
		[photoButtonItem release];
		[resetButtonItem release];
		[settingsButtonItem release];
		[flexibleSpaceButtonItem release];
		
		[self.view setBackgroundColor:[UIColor whiteColor]];
		
		// Inizializzazione della view per la modalita Portrait
		portraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) andGraphData:graphData];
		[self.view addSubview: portraitView];
		[portraitView release];
		
		// Inizializzazione della view per la modalita Landscape
		landscapeView = [[LandscapeView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width) andGraphData:graphData];
		[self.view addSubview: landscapeView];
		[landscapeView release];
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	self.navigationItem.title = graphData.title;
	
	CGRect frame = [[UIScreen mainScreen] bounds];
	
	if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || 
		[UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		// Se e' in Portrait mode
		[self.view bringSubviewToFront:portraitView];
		toolbar.frame = CGRectMake(0, frame.size.height - 100, frame.size.width, 40);
		[self.view bringSubviewToFront:toolbar];
	} else {
		// Se e' in landscape
		[self.view bringSubviewToFront:landscapeView];	
		toolbar.frame = CGRectMake(0, frame.size.width - 80, frame.size.height, 30);
	}
	
	[self.view bringSubviewToFront:toolbar];

	// Inizializzazione accelerometro
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:[graphData.interval floatValue]];
	[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
	
	
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
}

#pragma mark -
#pragma mark Rotation manager

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Supporta tutte le orientazioni
	return YES;
}

// Gestisco la rotazione
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
								duration:(NSTimeInterval)duration {
	CGRect frame = [[UIScreen mainScreen] bounds];
	if (toInterfaceOrientation == UIInterfaceOrientationPortrait || 
		toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		// Portrait mode
		[self.view bringSubviewToFront:portraitView];
		toolbar.frame = CGRectMake(0, frame.size.height - 100, frame.size.width, 40);
		[self.view bringSubviewToFront:toolbar];
	} else {
		// Landscape mode
		[self.view bringSubviewToFront:landscapeView];
		toolbar.frame = CGRectMake(0, frame.size.width - 80, frame.size.height, 30);
		[self.view bringSubviewToFront:toolbar];
		
	}
}

#pragma mark -
#pragma mark Button Action

- (void)backButtonPressed:(id)sender {
	[self playSound];
	// Ritorno al mio RootViewController
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)startButtonPressed:(id)sender {
	// Emetto un suono
	[self playSound];
	
	// Se il campionamento e' avviato...
	if (isStarted) {
		//...lo fermo
		isStarted = NO;
		isEditable = NO;
		[[UIAccelerometer sharedAccelerometer] setDelegate:nil];
		// Abilito tutti i pulsanti
		for (int i = 0; i < [toolbar.items count]; i++) {
			[[toolbar.items objectAtIndex:i] setEnabled:YES];
		}
		self.navigationItem.leftBarButtonItem.enabled = YES;
		// Abilito lo scrolling
		portraitView.xAxis.scrollView.scrollEnabled = YES;
		portraitView.yAxis.scrollView.scrollEnabled = YES;
		portraitView.zAxis.scrollView.scrollEnabled = YES;
		landscapeView.axes.scrollView.scrollEnabled = YES;
		// Cambio il titolo del pulsante
		[sender setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_START_", @"")]];
	} else {
		// Altrimenti
		// attivo il campionamento
		isStarted = YES;
		[[UIAccelerometer sharedAccelerometer] setDelegate:self];
		// Disabilito tutto i pulsanti
		for (int i = 0; i < [toolbar.items count]; i++) {
			[[toolbar.items objectAtIndex:i] setEnabled:NO];
		}
		self.navigationItem.leftBarButtonItem.enabled = NO;
		// Disabilito lo scrolling
		portraitView.xAxis.scrollView.scrollEnabled = NO;
		portraitView.yAxis.scrollView.scrollEnabled = NO;
		portraitView.zAxis.scrollView.scrollEnabled = NO;
		landscapeView.axes.scrollView.scrollEnabled = NO;
		// Cambio il titolo del pulsante
		[sender setTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_STOP_", @"")]];
	}
	
}

- (void)saveButtonPressed:(id)sender {
	// Emetto un suono
	[self playSound];
	
	// Se ho gia' salvato il grafico...
	if (graphData.isSaved) {
		//...lo risalvo con lo stesso nome per sovrascriverlo
		[self saveWithName:graphData.title];
	} else {
		//altrimenti chiedo all'utente il nome con cui salvarlo
		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_SAVE_WITH_NAME_", @"")]
														message:@"              "
													   delegate:self 
											  cancelButtonTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_CANCEL_", @"")]
											  otherButtonTitles:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_SAVE_", @"")], nil];
		saveTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
		[saveTextField setBackgroundColor:[UIColor whiteColor]];
		[saveTextField setDelegate:self];
		[alert addSubview:saveTextField];
		[saveTextField release];
		[alert setTag:1];
		[alert show];
		[alert release];
		[saveTextField becomeFirstResponder];
	}
	
}


- (void)photoButtonPressed:(id)sender {
	// Emetto un suono
	[self playSound];
	
	// Creo l'immagine relativa alla view X
	UIGraphicsBeginImageContext(portraitView.xAxis.frame.size);
	[portraitView.xAxis.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImageX = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	// Creo l'immagine relativa alla view Y
	UIGraphicsBeginImageContext(portraitView.yAxis.frame.size);
	[portraitView.yAxis.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImageY = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	// Creo l'immagine relativa alla view Z
	UIGraphicsBeginImageContext(portraitView.zAxis.frame.size);
	[portraitView.zAxis.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImageZ = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	// Unisco le tre immagini
	UIGraphicsBeginImageContext(CGSizeMake(viewImageX.size.width, viewImageX.size.height * 3));
	[viewImageX drawInRect:CGRectMake(0, 0, viewImageX.size.width, viewImageX.size.height)];
	[viewImageY drawInRect:CGRectMake(0, viewImageX.size.height, viewImageY.size.width, viewImageY.size.height)];
	[viewImageZ drawInRect:CGRectMake(0, viewImageX.size.height + viewImageY.size.height, viewImageZ.size.width, viewImageZ.size.height)];
	UIImage *combinatedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	// Salvo l'immagine per il portrait nella libreria
	UIImageWriteToSavedPhotosAlbum(combinatedImage, nil, nil, nil);
	
	// Creo l'immagine della landscape view
	UIGraphicsBeginImageContext(landscapeView.axes.frame.size);
	[landscapeView.axes.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImageAxes = UIGraphicsGetImageFromCurrentImageContext();
	
	// Salvo l'immagine per il landscape nella libreria
	UIImageWriteToSavedPhotosAlbum(viewImageAxes, nil, nil, nil);
	
	// Mostro un feedback all'utente
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_SAVING_", @"")]
													message:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_SAVED_PHOTO_ALBUM_", @"")]
												   delegate:nil 
										  cancelButtonTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_OK_", @"")] 
										  otherButtonTitles:nil];
	alert.tag = 3;
	[alert show];
	[alert release];
}

- (void)resetButtonPressed:(id)sender {
	[self playSound];
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_RESETTING_", @"")]
													message:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_RESETTING_GRAPH_", @"")]
												   delegate:self 
										  cancelButtonTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_NO_", @"")] 
										  otherButtonTitles:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_YES_", @"")], nil];
	alert.tag = 4;
	[alert show];
	[alert release];

}

- (void)settingsButtonPressed:(id)sender {
	[self playSound];
	SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithGraphData:graphData andEditable:(isEditable)&&(!graphData.isSaved)];
	settingsViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
	[self.navigationController presentModalViewController:settingsViewController animated:YES];
	[settingsViewController release];
}

- (void)playSound {
	//Ricavo la posizione del mio effetto sonoro
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"toc" ofType:@"caf"];
	
	//Converto il puntatore alla risorsa in un oggetto NSURL
	NSURL *aFilePath = [NSURL fileURLWithPath:filePath isDirectory:NO];
	
	//Inizializzo il servizio per la riproduzione dell'effetto sonoro
	OSStatus error = AudioServicesCreateSystemSoundID ((CFURLRef)aFilePath, &audioSID);
	//Se non ho errori, riproduco l'effetto sonoro
	if(error == 0){
		//Riproduco il l'effetto sonoro
		AudioServicesPlaySystemSound(audioSID);
	}
	
}

#pragma mark -
#pragma mark I/O FileSystem Operation

- (void)saveWithName:(NSString *)aName {
	// Setto il titolo del grafico
	graphData.title = aName;
	graphData.isSaved = YES;
	
	// Provo a salvare il file
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
	BOOL save = [NSKeyedArchiver archiveRootObject:graphData toFile:[NSString stringWithFormat:@"%@/%@.dat", path, graphData.title]];
	NSString *resultSave;
	
	// se il salvataggio va a buon fine
	if (save) {
		resultSave = [NSString stringWithFormat:@"%@",NSLocalizedString(@"_SAVE_SUCCESS_", @"")];
	} else {
		resultSave = [NSString stringWithFormat:@"%@",NSLocalizedString(@"_SAVE_FAILED_", @"")];
		graphData.isSaved = NO;
	}
	
	// Mostro un alert con lo stato del salvataggio
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_SAVING_", @"")]
													message:resultSave
												   delegate:nil 
										  cancelButtonTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_OK_", @"")] 
										  otherButtonTitles:nil];
	alert.tag = 2;
	[alert show];
	[alert release];
	
	// Cambio il titolo del controller
	self.navigationItem.title = graphData.title;
}

#pragma mark -
#pragma mark Accelerometer Delegate

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	//NSLog(@"X = %f Y = %f Z = %f", [acceleration x], [acceleration y], [acceleration z]);

	[[graphData xValues] addObject:[NSNumber numberWithFloat:[acceleration x]]];
	[[graphData yValues] addObject:[NSNumber numberWithFloat:[acceleration y]]];
	[[graphData zValues] addObject:[NSNumber numberWithFloat:[acceleration z]]];
	
	if ([[graphData xValues] count] > [[graphData numberOfValuesSaved] intValue]) {
		[[graphData xValues] removeObjectAtIndex:0];
		[[graphData yValues] removeObjectAtIndex:0];
		[[graphData zValues] removeObjectAtIndex:0];
	}
		
	[portraitView refreshView];
	[landscapeView refreshView];
}

#pragma mark -
#pragma mark AlertView Delegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	// Se l'alertView e' quello del salvataggio
	if (alertView.tag == 1) {
		// Se e' stato premuto salva
		if (buttonIndex == 1) {
			// Se il nome non e' valido...
			if ([saveTextField.text length] == 0) {
				//... mostro un alert d'errore
				AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_ERROR_", @"")]
																message:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_NAME_NOT_VALID_", @"")]
															   delegate:nil 
													  cancelButtonTitle:[NSString stringWithFormat:@"%@",NSLocalizedString(@"_OK_", @"")] 
													  otherButtonTitles:nil];
				alert.tag = 2;
				[alert show];
				[alert release];
			} else {
				// Altrimenti salvo normalmente
				[self saveWithName:saveTextField.text];
				
			}
		}
	} else if (alertView.tag == 4) {
		if (buttonIndex == 1) {
			// Svuoto l'array
			[[graphData xValues] removeAllObjects];
			[[graphData yValues] removeAllObjects];
			[[graphData zValues] removeAllObjects];
			// Aggiorno le view
			[portraitView resetView];
			[landscapeView resetView];
			// Riabilito le impostazioni
			isEditable = YES;
		}
	}

}

#pragma mark -
#pragma mark TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	// Nascondo la tastiera
	[saveTextField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark Memory management

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
    [super dealloc];
}


@end
