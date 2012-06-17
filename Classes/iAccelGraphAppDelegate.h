/**
 * AppDelegate specializzato per iPhone dell'App iOS
 *
 * Conforme al protocollo <UIApplicationDelegate>
 *
 * @class iAccelGraphAppDelegate
 * @author Giuseppe Tropea | http://giuseppetropea.net | email@giuseppetropea.net
 * @date 27/01/2011
 * @version 1.0
 *
 */

@interface iAccelGraphAppDelegate : NSObject <UIApplicationDelegate> {
	/// Finestra principale dell'App
    UIWindow *window;
	
	/// UINavigationController utilizzato per la navigazione tra le view nella UITableView
	UINavigationController *navigationController;
}

/**
 * Metodo richiamato al lancio dell'app.
 * 
 * @param (UIApplication *) application : applicazione lanciata;
 * @param (NSDictionary *) lanchOptions : opzioni passate al lancio dell'app.
 * 
 * @return (BOOL) : esito del lancio dell'app.
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;  

/**
 * Metodo per il rilascio della memoria.
 */
- (void)dealloc;

@end

