/**
 * Oggetto GraphData che contiene tutte le informazioni relative ai grafici
 *
 * Conforme al protocollo <NSCoding>
 *
 * @class GraphData
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 27/01/2011
 * @version 1.0
 *
 */

@interface GraphData : NSObject <NSCoding> {
	/// Titolo del grafico
	NSString *title;
	
	/// Array contenente i valori relativi al campionamento dell'asse X	
	NSMutableArray *xValues;
	/// Array contenente i valori relativi al campionamento dell'asse Y
	NSMutableArray *yValues;
	/// Array contenente i valori relativi al campionamento dell'asse Z
	NSMutableArray *zValues;
	
	/// Flag che indica se il grafo e' salvato
	BOOL isSaved;
	
	/// Intervallo di campionamento
	NSNumber *interval;
	/// Numero massimo di valori da salvare
	NSNumber *numberOfValuesSaved;
}

/**
 * Inizializzazione di un oggetto GraphData.
 *
 * @return id: oggetto GraphData inizializzato.
 */
- (id) init;

/**
 * Inizializzazione di un oggetto GraphData con un Coder.
 * Metodo da implementare per conformita' al protocollo NSCoding.
 *
 * @param (NSCoder *) aDecoder: coder utilizzato per il salvataggio.
 * @return id: oggetto GraphData inizializzato.
 */
- (id) initWithCoder:(NSCoder *)aDecoder;

/**
 * Metodo da implementare per conformita' al protocollo NSCoding.
 *
 * @param (NSCoder *) coder: coder da utilizzare per il salvataggio.
 */
- (void)encodeWithCoder:(NSCoder *)coder;

/**
 * Metodo per il rilascio della memoria.
 */
- (void)dealloc;

/// Titolo del grafico
@property (nonatomic, retain) NSString *title;

/// Array contenente i valori relativi al campionamento dell'asse X
@property (nonatomic, retain) NSMutableArray *xValues;
/// Array contenente i valori relativi al campionamento dell'asse Y
@property (nonatomic, retain) NSMutableArray *yValues;
/// Array contenente i valori relativi al campionamento dell'asse Z
@property (nonatomic, retain) NSMutableArray *zValues;

/// Flag che indica se il grafo e' salvato
@property BOOL isSaved;

/// Intervallo di campionamento
@property (nonatomic, retain) NSNumber *interval;
/// Numero massimo di valori da salvare
@property (nonatomic, retain) NSNumber *numberOfValuesSaved;

@end
