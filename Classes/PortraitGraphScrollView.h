/**
 * UIScrollView utilizzata per mostrare l'area scrollabile del grafico in modalità portrait.
 *
 * @class PortraitGraphScrollView
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 02/02/2011
 * @version 2.0
 *
 * ScrollView che mostra la retta spezzata del grafico in maniera scrollabile.
 *
 * La classe è conforme al protocollo UIScrollViewDelegate.
 */

@interface PortraitGraphScrollView : UIScrollView <UIScrollViewDelegate> {
	
	/// Colore della linea spezzata.
	UIColor *color;
	
	/// Array contenente i valori relativi al campionamento dell'asse.
	NSMutableArray *axisValues;
	
	/// Intervallo di campionamento
	NSNumber *interval;
		
	/// Punto utilizzato come zero nella scala.
	CGPoint zero;	
}

/**
 * Inizializzazione di un oggetto PortraitGraphScrollView.
 *
 * @param (CGRect) frame: frame contenente la posizione e la dimensione.
 * @param (NSMutableArray *) anArray: array dei valori con cui inizializzare la PortraitGraphScrollView.
 * @param (UIColor *) aColor: cololore della retta spezzata del grafico.
 *
 * @return id: oggetto LandscapeGraphViewView inizializzato.
 */
- (id)initWithFrame:(CGRect)graphFrame values:(NSMutableArray *)anArray andColor:(UIColor *)aColor;

/**
 * Realizzazione della linea spezzate del grafico e della scala dei secondi.
 *
 * @param (CGRect) rect: dimensione dell'area su cui disegnare.
 */
- (void)drawRect:(CGRect)rect;

/**
 * Metodo che si occupa di ridimensionare il contentSize e aggiornare la view.
 */
- (void)refreshView;

/**
 * Metodo che si occupa di azzerare il contentSize e aggiornare la view.
 */
- (void)resetView;

/**
 * Metodo delegato di UIScrollView.
 * Si occupa di ridisegnare la view nel caso in cui venga mostrata un'area che prima non era visibile.
 *
 * @param (UIScrollView *) scrollView: UIScrollView che viene srollata.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

/// Array contenente i valori relativi al campionamento dell'asse.
@property(nonatomic, retain) NSMutableArray *axisValues;

/// Intervallo di campionamento
@property(nonatomic, retain) NSNumber *interval;

@end
