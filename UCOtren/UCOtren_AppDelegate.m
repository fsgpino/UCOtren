//
//  UCOtren_AppDelegate.m
//  UCOtren
//
//  Creado por Francisco Gómez Pino
//  Ideado por Gonzalo Toledano
//  Copyright (c) 2013 Francisco Gómez Pino. Todos los derechos reservados.
//

#import "UCOtren_AppDelegate.h"
#import <Parse/Parse.h>

@implementation UCOtren_AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"APPLICATIONID_PARSE_API_KEY" // Change me / Cambialo
                  clientKey:@"CLIENTKEY_PARSE_API_KEY"]; // Change me / Cambialo
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    //******* SOBREESCRIBE LA APARIENCIA DE LA BARRA DE NAVEGACIÓN ***********
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
                                                           UITextAttributeTextShadowOffset,
                                                           [UIFont fontWithName:@"Roboto-Light" size:21.0], UITextAttributeFont, nil]];
    //**** FIN DE SOBREESCRIBE LA APARIENCIA DE LA BARRA DE NAVEGACIÓN *******
    
    //************* En caso de ser iPhone 5 cambia el storyboard *************
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    //
    if (iOSDeviceScreenSize.height == 568)
    {   // iPhone 5 and iPod Touch 5th generation: 4 inch screen
        // Instantiate a new storyboard object using the storyboard file named Storyboard_iPhone4
        UIStoryboard *iPhone4Storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard-568h" bundle:nil];
        
        UIViewController *initialViewController = [iPhone4Storyboard instantiateInitialViewController];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController  = initialViewController;
        [self.window makeKeyAndVisible];
    }
    //********* FIN de En caso de ser iPhone 5 cambia el storyboard **********
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    if ([error code] == 3010) {
        NSLog(@"Push notifications don't work in the simulator!");
    } else {
        NSLog(@"didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}

- (NSInteger)actualizaHorario: (NSString *) tramo
{
    // Actualiza el horarios almacenados en ficheros plist conectandose a la API de UCOmove
    //
    //Declaración de los directorios de trabajo donde se almacenan los horarios
    NSArray *pathOfDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathOfDirectory objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"tramo-%@.plist", tramo];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    //
    //************************* ALERTA DE INICIO DE DESCARGA *************************
    //
    //Muestra la alerta que indica que se procede a descargar un horario
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Descargando horario\nPor favor, espere…" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    //
    //Muestra un Indicador de proceso en curso dentro de la alerta anterior
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //
    //Ajusta la posición del inicador dentro de la alerta
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    //
    //Se procede a iniciar la animación y se ajusta el indicador dentro de view correspondiente al alert
    [indicator startAnimating];
    [alert addSubview:indicator];
    //
    //******************** SE PROCEDE A LA DESCARGA DEL HORARIO **********************
    //
    NSError *error = nil;
    NSString *URLdownload = [NSString stringWithFormat:@"http://your.server/your/api/endpoint.php?plataforma=ios&tipo=tren&tramo=%@", tramo]; // Change me / Cambialo
    NSString *response=[NSString stringWithContentsOfURL:[NSURL URLWithString:URLdownload] encoding:NSUTF8StringEncoding error:&error];
    //
    //Se comprueba si se recibe respuesta del servidor
    if (response)
    {
        //******************** SE RECIBE RESPUESTA DEL SERVIDOR **********************
        //
        //Se almacena el contenido descargado del servidor en un Array
        NSArray* dataDownload = [response componentsSeparatedByString: @"//"];
        //
        //Se comprueba si el servidor ha aceptado la consulta
        if ([[dataDownload objectAtIndex:0]isEqual:@"On"])
        {
            //****************** EL SERVIDOR ACEPTA LA CONSULTA **********************
            //
            if ([[dataDownload objectAtIndex:1]isEqual:@"Ok"])
            {
                //*********** EL SERVIDOR REALIZO CON EXITO LA CONSULTA **************
                //
                //Se comprueba si el archivo ya existe
                if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
                {
                    //** EN CASO DE QUE EL ARCHIVO EXISTA SE COMPRUEBAN LAS FECHAS ***
                    NSArray *dataFile = [[NSArray alloc] initWithContentsOfFile:filePath];
                    //
                    //Se comprueban si las fechas son iguales
                    if([[dataDownload objectAtIndex:3]isEqual:[dataFile objectAtIndex:3]])
                    {
                        //**** EL CONTENIDO DESCARGADO ES EL MISMO QUE EL ACTUAL *****
                        //
                        //Se detiene el indicador y se retira la alerta de la pantalla
                        [indicator stopAnimating];
                        [alert dismissWithClickedButtonIndex:0 animated:YES];
                        //
                        NSLog(@"Descarga del horario %@ completada, no actualizado.", tramo);
                        //
                        //Se devuelve 2 indicando que la descarga es la misma que la actual
                        return 2;
                    }else{
                        //** EL CONTENIDO DESCARGADO NO ES EL MISMO QUE EL ACTUAL ***
                        //
                        //Se elimina el contenido actual del archivo
                        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                        //
                        //Se crea un nuevo archivo con los datos nuevos
                        [dataDownload writeToFile:filePath atomically:YES];
                        //
                        //Se detiene el indicador y se retira la alerta de la pantalla
                        [indicator stopAnimating];
                        [alert dismissWithClickedButtonIndex:0 animated:YES];
                        //
                        NSLog(@"Descarga del horario %@ completada, actualizado", tramo);
                        //
                        //Se devuelve 1 indicando que la descarga se ha realizado
                        return 1;
                    }
                }else{
                    //EL ARCHIVO NO EXISTE, SE CREA UNO NUEVO CON LOS DATOS DESCARGADOS
                    [dataDownload writeToFile:filePath atomically:YES];
                    //
                    //Se detiene el indicador y se retira la alerta de la pantalla
                    [indicator stopAnimating];
                    [alert dismissWithClickedButtonIndex:0 animated:YES];
                    //
                    NSLog(@"Descarga del horario %@ completada, actualizado.", tramo);
                    //
                    //Se devuelve 1 indicando que la descarga se ha realizado
                    return 1;
                }
            }else{
                //********** EL SERVIDOR NO REALIZO CON EXITO LA CONSULTA ************
                //
                //Se detiene el indicador y se retira la alerta de la pantalla
                [indicator stopAnimating];
                [alert dismissWithClickedButtonIndex:0 animated:YES];
                //
                NSLog(@"#ERROR#: Servidor apagado, no acepta conexiones.");
                //
                //Se devuelve 0 indicando que la descarga no a sido posible
                return 0;
            }
        }else{
            //***************** EL SERVIDOR NO ACEPTA LA CONSULTA ********************
            //
            //Se detiene el indicador y se retira la alerta de la pantalla
            [indicator stopAnimating];
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            //
            //Se observa si el fallo de no aceptar la consulta es por desconeción o otra cosa
            if ([[dataDownload objectAtIndex:0]isEqual:@"Off"])
            {
                NSLog(@"#ERROR#: Servidor apagado, no acepta conexiones.");
            }else{
                NSLog(@"%@",[dataDownload objectAtIndex:0]);
            }
            //
            //Se devuelve 0 indicando que la descarga no a sido posible
            return 0;
        }
    }else{
        //******************* NO SE RECIBE RESPUESTA DEL SERVIDOR ********************
        //
        //Se detiene el indicador y se retira la alerta de la pantalla
        [indicator stopAnimating];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        //
        //Se manda al log el error de la descarga
        NSLog(@"#Error#: Imposible descargar horario del servidor\n###############################\n%@\n###############################\n", error);
        //
        //Se devuelve 0 indicando que la descarga no a sido posible
        return 0;
    }
}

@end
