/**
 * UIScrollView utilizzata per mostrare l'area scrollabile del grafico in modalità landscape.
 *
 * @class LandscapeGraphScrollView
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 03/02/2011
 * @version 2.0
 * @see GraphData
 *
 * ScrollView che mostra la retta spezzata del grafico in maniera scrollabile e la scala dei secondi.
 *
 * La classe è conforme al protocollo UIScrollViewDelegate.
 */

@class GraphData;

@interface LandscapeGraphScrollView : UIScrollView <UIScrollViewDelegate> {
	/// Oggetto contenente tutte le informazioni relative al grafico.
	GraphData *graphData;
	
	
	/// Punto utilizzato come zero nella scala.
	CGPoint zero;
}

/**
 * Metodo di inizializzazione della view.
 *
 * @param (CGRect) frame: frame contenente la posizione e la dimensione.
 * @param (GraphData *) aData : oggetto contenente tutte le informazioni relative al grafico.
 *
 * @return (id) : oggetto inizializzato.
 */
- (id)initWithFrame:(CGRect)frame andGraphData:(GraphData *)aData;

/**
 * Realizzazione delle tre linee spezzate del grafico.
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
 * Delegato della UIScrollView. Ha il compito di riaggiornare la view non appena viene scrollata un'area che prima non era visibile.
 *
 * @param (UIScrollView *)scrollView: scrollView che risponde allo scroll dell'utente.
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

/**
 * Metodo per il rilascio della memoria.
 */
- (void)dealloc;

@end
