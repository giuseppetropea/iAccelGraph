/**
 * Classe utilizzata per disegnare l'area del grafo.
 *
 * @class GraphView
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 27/01/2011
 * @version 2.0
 *
 * Sfondo con scala su cui saranno tracciati i grafi.
 */

@interface GraphView : UIScrollView {
	CGRect graphFrame;
}

/**
 * Inizializzazione di un oggetto GraphView esteso da UIScrollView
 * con un frame passato dall'utente.
 *
 * @param (CGRect) frame: frame contenente la posizione e la dimensione.
 * @return id: oggetto GraphView inizializzato.
 */
- (id)initWithFrame:(CGRect)frame;

/**
 * Realizzazione sfondo e scala e numerata.
 *
 * @param (CGRect) rect: dimensione dell'area su cui disegnare.
 */
- (void)drawRect:(CGRect)rect;
/**
 * Metodo per il rilascio della memoria.
 */
- (void)dealloc;

/// Area del grafico.
@property CGRect graphFrame;

@end
