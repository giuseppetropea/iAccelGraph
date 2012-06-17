/**
 * View utilizzata per mostrare il LandscapeGraphView e la LegendView in modalità landscape.
 *
 * @class LandscapeView
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 27/01/2011
 * @version 2.0
 * @see LandscapeGraphView
 * @see GraphData
 *
 * View in cui è inserita sia la GraphView e la LegendView
 */

@class LandscapeGraphView;
@class GraphData;

@interface LandscapeView : UIView {
	/// GraphView per la visualizzazione del grafico in modalità landscape.
	LandscapeGraphView *axes;
}

/**
 * Inizializzazione di un oggetto LandscapeView.
 *
 * @param (CGRect) frame: frame contenente la posizione e la dimensione.
 * @param (GraphData *) aData : oggetto contenente tutte le informazioni relative al grafico.
 *
 * @return id: oggetto LandscapeGraphViewView inizializzato.
 */
- (id)initWithFrame:(CGRect)frame andGraphData:(GraphData *)aData;

/**
 * Metodo che si occupa di ridimensionare il contentSize e aggiornare la dello ScrollView.
 */
- (void)refreshView;

/**
 * Metodo che si occupa di azzerare il contentSize e aggiornare la scrollView.
 */
- (void)resetView;

/**
 * Metodo per il rilascio della memoria.
 */
- (void)dealloc;

/// GraphView per la visualizzazione del grafico in modalità landscape.
@property(nonatomic, retain)LandscapeGraphView *axes;

@end
