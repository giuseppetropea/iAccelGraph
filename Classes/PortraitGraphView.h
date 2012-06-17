/**
 * GraphView utilizzata per mostrare il grafico in modalità portrait.
 *
 * @class PortraitGraphView
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 27/01/2011
 * @version 2.0
 * @see GraphView
 *
 * Classe estesa da GraphView in cui viene mostrata la UIScrollView incaricata di rappresentare le linee spezzate del grafico.
 */

#import "GraphView.h"

@class PortraitGraphScrollView;

@interface PortraitGraphView : GraphView {
	
	/// Area scrollabile che mostra il grafico.
	PortraitGraphScrollView *scrollView;
	/// Nome dell'asse.
	UILabel *title;

}

/**
 * Inizializzazione di un oggetto PortraitGraphView esteso da GraphView.
 *
 * @param (CGRect) frame: frame contenente la posizione e la dimensione.
 * @param (NSString *) aTitle: nome dell'asse che apparirà in una label.
 * @param (NSMutableArray *) anArray: array dei valori con cui inizializzare la PortraitGraphScrollView.
 * @param (UIColor *) aColor: cololore della retta spezzata del grafico.
 *
 * @return id: oggetto LandscapeGraphViewView inizializzato.
 */
- (id)initWithFrame:(CGRect)frame Title:(NSString *)aTitle values:(NSMutableArray *)anArray andColor:(UIColor *)aColor;

/**
 * Metodo per il rilascio della memoria.
 */
- (void)dealloc;

/// ScrollView incaricato di disegnare il grafico scrollabile.
@property(nonatomic, retain)PortraitGraphScrollView *scrollView;

@end
