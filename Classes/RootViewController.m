//
//  RootViewController.m
//  iGraphAccel
//
//  Created by Giuseppe Tropea on 1/27/11.
//  Copyright 2011 Giuseppe Tropea. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "GraphData.h"


@implementation RootViewController

@synthesize listOfItems;

#pragma mark -
#pragma mark Initialization

- (id)init {
	[super initWithStyle:UITableViewStyleGrouped];
	if (self) {
		
		listOfItems = [[NSMutableArray alloc] init];
		
		// Inizializzazione NavigationBar
		self.navigationItem.title = [NSString stringWithFormat:@"%@",NSLocalizedString(@"_APP_NAME_", @"")];
		self.navigationItem.leftBarButtonItem = [self editButtonItem];
		UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonItemPressed:)];
		self.navigationItem.rightBarButtonItem = addButtonItem;
		
	}
	return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	// Popolo il mio DataSource
	self.listOfItems = [self getObjects];
	// Ricarico i dati nella mia tableView
	[[self tableView] reloadData];
}

#pragma mark -
#pragma mark Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	//Supporta tutte le rotazioni
	return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Numero di sezioni
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Numero di righe per sezione
    return [self.listOfItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    // Metto nelle celle il nome del grafico
	cell.textLabel.text = [[self.listOfItems objectAtIndex:[indexPath row]] title];
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

// Gestisco l'eliminazione degli elementi
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Cancello il file dal disco
		[self deleteObjectWithName:[[self.listOfItems objectAtIndex:[indexPath row]] title]];
		// Rimuovo il riferimento nell'array che uso come sorgente dati
        [self.listOfItems removeObjectAtIndex:[indexPath row]];
		// Cancello la riga con un'animazione
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}



// Gestisco lo spostamento degli elementi
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	// Mi salvo il riferimento all'oggetto da spostare
	GraphData *temp = [self.listOfItems objectAtIndex:[fromIndexPath row]];
	// Aumento il retain count a 2 per non perdere il riferimento
	[temp retain];
	// Rimuovo l'elemento dall'array
	[self.listOfItems removeObjectAtIndex:[fromIndexPath row]];
	// Retain count uguale a 1
	// Inserisco l'elemento nell'array alla nuova posizione
	// Il retain count aumenta a 2
	[self.listOfItems insertObject:temp atIndex:[toIndexPath row]];
	// Rilascio l'elemento per riportare il retain count a 1
	[temp release];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Emetto un suono
	[self playSound];
	
	// Mi estraggo il grafico dall'array
	GraphData *data = [self.listOfItems objectAtIndex:[indexPath row]];
	// Mi creo un controllore per il grafico estratto
	DetailViewController *detailViewController = [[DetailViewController alloc] initWithGraphData:data];
	// Passo al nuovo controllore che mi deve mostrare il grafico
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	
}

#pragma mark -
#pragma mark Button action

- (void)addButtonItemPressed:(id)sender {
	// Emetto un suono
	[self playSound];
	
	// Mi creo un nuovo grafico
	GraphData *data = [[GraphData alloc] init];
	// Mi creo un controllore per il nuovo grafico
	DetailViewController *detailViewController = [[DetailViewController alloc] initWithGraphData:data];
	// Passo al nuovo grafico
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];	
}

// Sovrascrivo il metodo per aggiungere l'emissione del suono
- (void)setEditing:(BOOL)flag animated:(BOOL)animated {
	[super setEditing:flag animated:animated];
	// Emetto un suono
	[self playSound];
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
#pragma mark Filesystem managemet

- (NSMutableArray *)getObjects {
	
	NSError *error;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// Mi ricavo il path della cartella Documents
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	// Mi salvo in un array tutti i nomi dei file
	NSMutableArray *list = (NSMutableArray *)[fileManager contentsOfDirectoryAtPath:documentsDirectory error:&error];
	
	// Mi controllo se i file presenti in Documents sono i miei grafici
	// e me li salvo in un altro array
	NSMutableArray *validList = [[NSMutableArray alloc] init];
	for (NSString *str in list) {
		if ([[str substringFromIndex:[str length] - 4] isEqual:@".dat"]) {
			[validList addObject:str];
		}
	}
	
	// Mi estraggo i miei oggetti GraphData e li metto in un array
	NSMutableArray *objects = [[[NSMutableArray alloc] init]autorelease];
	NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
	for (int i = 0; i < [validList count]; i++) {
		NSString *str = [validList objectAtIndex:i];
		[objects addObject:(GraphData *)[NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/%@", path, str]]];
	}
	[validList release];
	
	return objects;
}

- (void)deleteObjectWithName:(NSString *)aName {
	
	NSError *error;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// Creo il path del file
	NSString *pathDoc = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"];
	NSString *path = [NSString stringWithFormat:@"%@/%@.dat", pathDoc, aName];
	// Cancello il file
	[fileManager removeItemAtPath:path error:&error];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[self.listOfItems release];
    [super dealloc];
}


@end

