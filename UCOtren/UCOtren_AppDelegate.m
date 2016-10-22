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
    
    NSError *error = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://your.server/your/api/endpoint.php"]]; // Change me / Cambialo
    NSURLResponse *response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    _iTunesAppStoreUCOMoveURL = @"";
    if (data != nil)
    {
        NSDictionary *objectJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (objectJSON != nil)
        {
            if ([[objectJSON valueForKey:@"avaliable"]isEqual:[NSString stringWithFormat:@"yes"]]){
                _iTunesAppStoreUCOMoveURL = [objectJSON valueForKey:@"iTunesAppStoreURL"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[objectJSON valueForKey:@"header"]
                                                                message:[objectJSON valueForKey:@"message"]
                                                               delegate:self
                                                      cancelButtonTitle:@"Cerrar"
                                                      otherButtonTitles:[objectJSON valueForKey:@"textButton"],nil];
                [alert show];
            }
        }
    }
    
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
    
    //******* SOBREESCRIBE LA APARIENCIA DE LA BARRA DE NAVEGACIÓN ***********
    //[[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
    //                                                       [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
    //                                                       UITextAttributeTextShadowOffset,
    //                                                       [UIFont fontWithName:@"Roboto-Light" size:21.0], UITextAttributeFont, nil]]; // Deprecated in iOS 7
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Roboto-Light" size:21],NSFontAttributeName, nil]];
    
    
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSUInteger)buttonIndex {
    if (buttonIndex != 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_iTunesAppStoreUCOMoveURL]];
    }
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
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}
@end
