/**
 * View utilizzata per mostrare una legenda del grafico.
 *
 * @class LegendView
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 28/01/2011
 * @version 2.0
 *
 * View che mostra tre quadratine colorati con affianco il nome dell'asse rappresentato dal colore.
 */

@interface LegendView : UIView {

}

/**
 * Inizializzazione di un oggetto LegendView esteso da UIView
 * con un frame passato dall'utente.
 *
 * @param (CGRect) frame: frame contenente la posizione e la dimensione.
 * @return id: oggetto LegendView inizializzato.
 */
- (id)initWithFrame:(CGRect)frame;

/**
 * Realizzazione dei quadratini colorati.
 *
 * @param (CGRect) rect: dimensione dell'area su cui disegnare.
 */
- (void)drawRect:(CGRect)rect;

/**
 * Metodo per il rilascio della memoria.
 */
- (void)dealloc;

@end
