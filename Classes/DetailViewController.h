/**
 * UIViewController che mostra un grafico nuovo oppure salvato precedentemente.
 *
 * Conforme ai protocolli UIAccelerometerDelegate, UIAlertViewDelegate, UITextFieldDelegate.
 *
 * @class DetailViewController
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 27/01/2011
 * @version 1.0
 * @see GraphData
 * @see PortaitView
 * @see LandscapeView
 */

@class GraphData, PortraitView, LandscapeView;

@interface DetailViewController : UIViewController <UIAccelerometerDelegate, UIAlertViewDelegate, UITextFieldDelegate> {
	
	/// Oggetto contenente tutte le informazioni relative al mio grafico
	GraphData *graphData;
	
	/// View da mostrare quando il device si trova in modalita' portrait
	PortraitView *portraitView;
	/// View da mostrare quando il device si trova in modalita' landscape
	LandscapeView *landscapeView;
	
	/// Toolbar da cui e' possibile accedere a tutte le operazioni eseguibili sui grafici
	UIToolbar *toolbar;
	/// TextField utilizzata per inserire il titolo del grafico durante salvataggio.
	UITextField *saveTextField;
	
	/// Valore che indica se il campionamento e' avviato oppure no
	BOOL isStarted;
	/// Valore che indica se le impostazioni per il grafico sono modificabili oppure no
	BOOL isEditable;
	
	/// Struttura destinata a contenere i suoni da riprodurre alla pressione dei tasti
	SystemSoundID audioSID;
	
}
/**
 * Metodo di inizializzazione del ViewController
 *
 * @param (GraphData *) aData : oggetto contenente tutte le informazioni relative al grafico.
 *
 * @return (id) : oggetto inizializzato.
 */
- (id)initWithGraphData:(GraphData *)aData;

/**
 * Metodo richiamato automaticamente ogni volta che la view appare.
 * Utilizzato per aggiornare automaticamente le impostazioni e posizionare gli oggetti al posto
 * giusto in base all'orientamento.
 * 
 * @param (BOOL)animated : valore che indica se l'apparizione e' animata oppure no.
 */
- (void)viewWillAppear:(BOOL)animated;

/**
 * Metodo richiamato automaticamente ogni volta che la view scompare.
 * Utilizzato per settare a nil il delegato dell'accelerometro, azione necessaria per evitare che l'app crashi.
 * 
 * @param (BOOL)animated : valore che indica se l'apparizione e' animata oppure no.
 */
- (void)viewWillDisappear:(BOOL)animated;

/**
 * Metodo utilizzato per indicare le rotazioni supportate.
 *
 * @param (UIInterfaceOrientation) interfaceOrientation: orientamento del device;
 *
 * @return (BOOL) : restituisce YES se un orientamento e' supportato, altrimenti YES. Nel caso specifico restituisce sempre YES (tutti gli orientamenti sono supportati).
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

/**
 * Metodo utilizzato per gestire le rotazioni spostando gli oggetti e cambiando le view.
 *
 * @param (UIInterfaceOrientation) toInterfaceOrientation : orientamento del device;
 * @param (NSTimeInterval) duration : durata della rotazione.
 *
 * @return (BOOL) : restituisce YES se un orientamento e' supportato, altrimenti YES. Nel caso specifico restituisce sempre YES (tutti gli orientamenti sono supportati).
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

/**
 * Metodo che avvia il campionamento.
 * Si occupa anche di disabilitare tutti i button e le modifiche al grafico.
 *
 * @param (id) sender : buttone che richiama il metodo.
 */
- (void)startButtonPressed:(id)sender;

/**
 * Metodo che esegue semplicemente il pop del ViewController.
 *
 * @param (id) sender : buttone che richiama il metodo.
 */
- (void)backButtonPressed:(id)sender;

/**
 * Metodo che si occupa di mostrare l'alert per effettuare il savataggio dei dati del grafico.
 *
 * @param (id) sender : buttone che richiama il metodo.
 */
- (void)saveButtonPressed:(id)sender;

/**
 * Metodo che effettua uno screen di tutte le view, le combina e salva l'immagine nel rullino fotografico.
 *
 * @author Giuseppe Tropea - Mario Nolassi
 * @version 2.0
 *
 * @param (id) sender : buttone che richiama il metodo.
 */
- (void)photoButtonPressed:(id)sender;

/**
 * Metodo che cancella tutti i valori campionati.
 *
 * @param (id) sender : buttone che richiama il metodo.
 */
- (void)resetButtonPressed:(id)sender;

/**
 * Metodo che mostra un SettingsViewController utilizzabile per mostrare 
 * e/o settare le impostazioni del grafico quali intervallo di campionamento 
 * e numero di valori da salvare.
 *
 * @param (id) sender : buttone che richiama il metodo.
 */
- (void)settingsButtonPressed:(id)sender;

/**
 * Metodo che riproduce un suono al tap di un button.
 */
- (void)playSound;

/**
 * Metodo che si occupa del salvataggio sul device dell'oggetto GraphData contenente i dati del grafico.
 * Mostra un alert che avvisa l'utente se il salvataggio e' andato a buon fine oppure no.
 *
 * @param (NSString *) aName : titolo del grafico e nome del file che deve contenere i dati.
 */
- (void) saveWithName:(NSString *)aName;

/**
 * Delegato di UIAccelerometer.
 * Si occupa di salvare i valori campionati dall'acceleromentro e di lanciare un aggiornamento delle view che devono
 * mostrare tali dati.
 *
 * @param (UIAccelerometer *) accelerometer : instanza dell'accelerometro (si utilizza sempre la stessa poiche' e' un singleton);
 * @param (UIAcceleration *) acceleration : accelerazione prodotta sui tre assi cartesiani, in G = 9.8 m/s^2.
 */
- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;

/**
 * Delegato di UIAlertView.
 * Si occupa di controllare se durante il salvataggio la textFieldView e' vuota e nel caso non lo sia
 * di richiamare il metodo  saveWithName:(NSString *)aName che si occupa del vero e proprio salvataggio.
 *
 * @param (UIAlertView *) alertView : alertView su cui si e' tappato un button;
 * @param (NSInteger) buttonIndex : intero identificatore del button.
 */
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

/**
 * Delegato di UITextFieldView
 * Si occupa di nascodere la tastiera al tap del tasto invio.
 * 
 * @param (UITextField *) textField : campo che contiene il titolo del grafico.
 * 
 * @return (BOOL) : restituisce YES se deve implementare le operazioni di default alla pressione dell'invio, altrimenti NO.
 */
- (BOOL) textFieldShouldReturn:(UITextField *)textField;

/// Oggetto contenente tutte le informazioni relative al mio grafico
@property (nonatomic, retain) GraphData *graphData;

@end
