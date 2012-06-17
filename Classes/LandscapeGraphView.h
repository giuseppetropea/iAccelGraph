/**
 * GraphView utilizzata per mostrare il grafico in modalità landscape.
 *
 * @class LandscapeGraphView
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 27/01/2011
 * @version 2.0
 * @see GraphView
 * @see LandscapeGraphScrollView
 * @see GraphData
 *
 * Classe estesa da GraphView in cui viene mostrata la UIScrollView incaricata di rappresentare le linee spezzate del grafico.
 */

#import "GraphView.h"

@class LandscapeGraphScrollView;
@class GraphData;

@interface LandscapeGraphView : GraphView {
	/// Area scrollabile che mostra il grafico.
	LandscapeGraphScrollView *scrollView;
	
}

/**
 * Inizializzazione di un oggetto LandscapeGraphView esteso da GraphView.
 *
 * @param (CGRect) frame: frame contenente la posizione e la dimensione.
 * @param (GraphData *) aData : oggetto contenente tutte le informazioni relative al grafico.
 *
 * @return id: oggetto LandscapeGraphViewView inizializzato.
 */
- (id)initWithFrame:(CGRect)frame andGraphData:(GraphData *)aData;

/**
 * Metodo per il rilascio della memoria.
 */
- (void)dealloc;

/// ScrollView incaricato di disegnare il grafico scrollabile.
@property(nonatomic, retain)LandscapeGraphScrollView *scrollView;

@end
