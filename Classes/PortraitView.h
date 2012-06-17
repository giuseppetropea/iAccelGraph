/**
 * View utilizzata per mostrare le tre PortraitGraphView relative agli assi in modalità portrait.
 *
 * @class PortraitView
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 27/01/2011
 * @version 2.0
 * @see PortraitGraphView
 * @see GraphData
 *
 */

@class PortraitGraphView;
@class GraphData;

@interface PortraitView : UIView {
	/// PortraitGraphView relativa all'asse X.
	PortraitGraphView *xAxis;
	/// PortraitGraphView relativa all'asse Y.
	PortraitGraphView *yAxis;
	/// PortraitGraphView relativa all'asse Z.
	PortraitGraphView *zAxis;
}

/**
 * Inizializzazione di un oggetto PortraitView esteso da UIView
 * con un frame passato dall'utente e un oggetto GraphData per inizializzare il PortraitGraphView.
 *
 * @param (CGRect) frame: frame contenente la posizione e la dimensione.
 * @param (GraphData *) aData: oggetto GraphData utilizzato per inizializzare il LandscapeGraphView. 
 * @return id: oggetto LandscapeView inizializzato.
 */
- (id)initWithFrame:(CGRect)frame andGraphData:(GraphData *)aData;

/**
 * Metodo che si occupa di ridimensionare il contentSize e aggiornare la view.
 */
- (void)refreshView;

/**
 * Metodo che si occupa di azzerare il contentSize e aggiornare la view.
 */
- (void)resetView;

/**
 * Metodo per il rilascio della memoria.
 */
- (void)dealloc;

/// PortraitGraphView relativa all'asse X.
@property(nonatomic, retain)PortraitGraphView *xAxis;
/// PortraitGraphView relativa all'asse Y.
@property(nonatomic, retain)PortraitGraphView *yAxis;
/// PortraitGraphView relativa all'asse Z.
@property(nonatomic, retain)PortraitGraphView *zAxis;

@end
