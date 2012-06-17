/**
 * UIViewController che mostra e permette la modifica delle impostazioni (solo nel 
 * caso in cui il campionamento sia gia' stato avviato).
 *
 * Conforme ai protocolli UIPickerViewDelegate, UIPickerViewDataSource.
 *
 * @class SettingsViewController
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 27/02/2011
 * @version 1.0
 * @see GraphData
 *
 */

@class GraphData;

@interface SettingsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	
	/// Oggetto contenente tutte le informazioni relative al mio grafico	
	GraphData *graphData;
	
	/// PickerView che mostra e permette il settaggio delle impostazioni
	UIPickerView *pickerView;
	/// Sorgente dati per il pickerView
	NSDictionary *settings;
}

/**
 * Metodo di inizializzazione del ViewController
 *
 * @param (GraphData *) aData : oggetto contenente tutte le informazioni relative al grafico;
 * @param (BOOL) editable: YES se le impostazioni sono editabili, altrimenti NO.
 *
 * @return (id) : oggetto inizializzato.
 */
- (id)initWithGraphData:(GraphData *)aData andEditable:(BOOL)editable;

/**
 * Metodo richiesto dal protocollo UIPickerViewDataSource, utilizzato per riemire
 * le righe del picker con i colori corrispondenti.
 *
 * @param (UIPickerView *) pickerView : pickerView di cui si vogliono settare le righe;
 * @param (NSInteger) row : numero di riga;
 * @param (NSIngeger) component : numero del componente.
 *
 * @return (NSString *) : restituisce il titolo della cella.
 */
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

/**
 * Metodo richiesto dal protocollo UIPickerViewDataSource, indica il numero di componenti da inserire nel pickerView.
 *
 * @param (UIPickerView *) pickerView : pickerView di cui si vogliono settare i componenti.
 *
 * @return (NSInteger) : restituisce il numero di componenti del pickerView.
 */
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView;

/**
 * Metodo richiesto dal protocollo UIPickerViewDataSource, utilizzato per specificare
 * il numero di righe da inserire in ogni component.
 *
 * @param (UIPickerView *) pickerView : pickerView di cui si vuole settare il numero di righe;
 * @param (NSIngeger) component : numero del componente di cui si vogliono settare le righe.
 *
 * @return (NSInteger) : restituisce il numero di righe per il component.
 */
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

/**
 * Metodo richiesto dal protocollo UIPickerViewDelegate, utilizzato per aggiornare i valori delle impostazioni alla selezione dei nuovi valori.
 *
 * @param (UIPickerView *) pickerView : pickerView di cui si vuole prendere la selezione;
 * @param (NSInteger) row : numero di riga selezionata;
 * @param (NSIngeger) component : numero del componente in cui e' contenuta la riga selezionata.
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
