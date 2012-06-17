/**
 * ViewController esteso da UITableViewController che implementa tutti metodi
 * necessari al funzionamento di una UITable.
 *
 * Conforme ai protocolli UITableViewDelegate, UITableViewDataSource.
 *
 * @class RootViewController
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 27/01/2011
 * @version 1.0
 *
 */

@interface RootViewController : UITableViewController {
	
	/// Sorgente dati per popolare la UITableView
	NSMutableArray *listOfItems;
	
	/// Struttura destinata a contenere i suoni da riprodurre alla pressione dei tasti
	SystemSoundID audioSID;
}

/**
 * Metodo di inizializzazione del ViewController
 *
 * @return (id) : oggetto inizializzato.
 */
- (id)init;

/**
 * Metodo richiamato automaticamente ogni volta che la view appare.
 * Utilizzato per aggiornare automaticamente la sorgente dati e mostrare una
 * lista di elementi aggiornati ad ogni apparizione della view.
 * 
 * @param (BOOL)animated : valore che indica se l'apparizione e' animata oppure no.
 */
- (void)viewWillAppear:(BOOL)animated;

/**
 * Metodo utilizzato per indicare le rotazioni supportate.
 *
 * @param (UIInterfaceOrientation) interfaceOrientation: orientamento del device;
 *
 * @return (BOOL) : restituisce YES se un orientamento e' supportato, altrimenti YES. Nel caso specifico restituisce sempre YES (tutti gli orientamenti sono supportati).
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

/**
 * Metodo necessario per rendere la classe conforme al protocollo UITableViewDataSource.
 * Metodo che indica il numero di sezioni presenti nella UITableView.
 *
 * @param (UITableView *) tableView : UITableView per cui si deve restituire il numero di sezioni.
 *
 * @return (NSInteger) : intero che indica il numero di sezioni presenti nella UITableView. Restituisce sempre 1.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

/**
  * Metodo necessario per rendere la classe conforme al protocollo UITableViewDataSource.
 * Metodo che indica il numero di righe per sezione.
 *
 * @param (UITableView *) tableView : UITableView per la quale si vuole restituire il numero di righe;
 * @param (NSInteger *) section : numero della sezione per la quale si vuole restituire il numero di righe.
 *
 * @return (NSInteger) : numero di righe di cui e' composta la sezione.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 * Metodo che scrive il contenuto della cella della UITableView
 * Viene inserito il titolo con il quale e' stato salvato il grafico.
 *
 * @param (UITableView *) tableView : UITableView per cui si vuole creare la cella;
 * @param (NSIndexPath *) indexPath : numero di riga per cui si vuole creare la cella.
 *
 * @return (UITableViewCell *) : restituisce la cella della UITableView.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Metodo utilizzato per la modifica della sorgente dati.
 * Utilizzato in modo particolare per l'eliminazione.
 *
 * @param (UITableView *) tableView : UITableView per la quale si deve eliminare l'elemento;
 * @param (UITableViewCellEditingStyle) editingStyle : tipo di modifica (es. cancellazione);
 * @param (NSIndexPath *) indexPath: riga da modificare.
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Metodo utilizzato per modificare l'ordine degli oggetti nella visualizzazione e nella sorgente dati.
 * L'ordinamento predefinito e' quello alfabetico crescente.
 *
 * @param (UITableView *) tableView : UITableView per cui si deve spostare un elemento;
 * @param (NSIndexPath *) fromIndexPath : numero di riga iniziale dell'oggeto;
 * @param (NSIndexPath *) toIndexPath : numero di riga in cui si deve trovare l'oggetto dopo lo spostamento.
 */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

/**
 * Delegato della UITableView. Dichiarato in UITableViewDelegate.
 * Alla selezione della cella viene effettuato il push di un DetailViewController che mostra il grafico.
 * a cui e' riferita la cella.
 *
 * @param (UITableView *) tableView : UITableView in cui si trova la cella selezionata;
 * @param (NSIndexPath *) indexPath : numero di riga selezionata.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Metodo invocato al tap del Button "add" posizionato sulla NavigationBar.
 * Esegue un push verso un DetailViewController in cui si trova un grafico vuoto.
 *
 * @param (id) sender : buttone che richiama il metodo.
 */
- (void)addButtonItemPressed:(id)sender;

/**
 * Metodo invocato al tap del Button "edit" posizionato sulla navigationBar.
 * Esegue un suono e richiama lo stesso metodo nella superclasse che permette di cancellare o spostare le righe.
 *
 * @param (BOOL) flag :
 * @param (BOOL) animated : valore che indica se si deve visualizzare un'animazione oppure no alla modifica.
 */
- (void)setEditing:(BOOL)flag animated:(BOOL)animated;

/**
 * Metodo che riproduce un suono al tap di un button.
 */
- (void)playSound;

/**
 * Metodo che legge i file precedentemente salvati sul device e li inserisce in un Array per generare la sorgente dati.
 *
 * @return (NSMutableArray *) : restituisce la sorgente dati.
 */
- (NSMutableArray *)getObjects;

/**
 * Metodo per la cancellazione dei file dal device.
 *
 * @param (NSString *) aName : nome del file.
 */
- (void)deleteObjectWithName:(NSString *)aName;

/**
 * Metodo per il rilascio della memoria.
 */
- (void)dealloc;

/// Sorgente dati per popolare la UITableView
@property (nonatomic, retain) NSMutableArray *listOfItems;

@end
