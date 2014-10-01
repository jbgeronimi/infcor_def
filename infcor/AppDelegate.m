//
//  AppDelegate.m
//  infcor
//
//  Created by admin notte on 24/07/2014.
//  Copyright (c) 2014 ___calasoc___. All rights reserved.
//

#import "AppDelegate.h"
#import "prefsViewController.h"
#import "pref.h"
#import "params.h"
#import "ViewController.h"
#import "favoritesTableViewController.h"
#import "prefsViewController.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setDefaultValuesForVariables];
    
    //self.aParam = [[params alloc] init];
    
    ViewController *VC = [[ViewController alloc] init];
    UINavigationController *navViewController = [[UINavigationController alloc] initWithRootViewController:VC];

    favoritesTableViewController *favVC = [[favoritesTableViewController alloc] init];
    favVC.gio = self.gio;
    UINavigationController *favNavController = [[UINavigationController alloc] initWithRootViewController:favVC];
    
    prefsViewController *prefsVC = [[prefsViewController alloc] init];
    //prefsVC.alangue = self.alangue;
   // prefsVC.gio = self.gio;
    UINavigationController *prefsNavController = [[UINavigationController alloc] initWithRootViewController:prefsVC];
    
    // aboutViewController *aboutVC = [[aboutViewController alloc] init];
    // UINavigationController *aboutNavController = [[UINavigationController alloc] initWithRootViewController:aboutViewController];
    
//les icones de la tabbar
    //la Home
    UIImage *casaViota = [UIImage imageNamed:@"casaViota"];
    casaViota = [casaViota imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *casaPiena = [UIImage imageNamed:@"casaPiena"];
    casaPiena = [casaPiena imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *itemCasa = [[UITabBarItem alloc] initWithTitle:@"" image:casaViota selectedImage:casaPiena];
    itemCasa.tag = 1;
    VC.tabBarItem = itemCasa;
    
    //les favoris
    UIImage *stellaViota = [UIImage imageNamed:@"stellaViota"];
    stellaViota = [stellaViota imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *stellaPiena = [UIImage imageNamed:@"stellaPiena"];
    stellaPiena = [stellaPiena imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *itemFav =[[UITabBarItem alloc] initWithTitle:@"" image:stellaViota selectedImage:stellaPiena];
    favVC.tabBarItem = itemFav;
    
    //Les réglages
    UIImage *prefViota = [UIImage imageNamed:@"prefViota"];
    prefViota = [prefViota imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *prefPiena = [UIImage imageNamed:@"prefPiena"];
    prefPiena = [prefPiena imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *itmePrefs = [[UITabBarItem alloc] initWithTitle:@"" image:prefViota selectedImage:prefPiena];
    prefsVC.tabBarItem = itmePrefs;
    prefsVC.aParam = VC.aParam;
    //prefsVC.params = self.params;
    
    //les couleurs
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[navViewController, favNavController, prefsNavController/*,aboutNavController*/];
    //tabBarController.tabBar.translucent = NO;
    [tabBarController.tabBar setBarTintColor:[UIColor colorWithRed:0.129 green:0.512 blue:0.99 alpha:0.900]];
    tabBarController.tabBar.backgroundColor = [UIColor blackColor];
    tabBarController.tabBar.tintColor = [UIColor whiteColor];
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
//    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
/*    NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (!data)
        {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pas de Connexion"
                                                        message:@"la banque INFCOR a besoin de se connecter à internet. Verifiez votre connexion"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }*/
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}

- (void)setDefaultValuesForVariables
{
    NSMutableArray *dbb = [[NSMutableArray alloc] init];
    [dbb addObject:@"FRANCESE" ];
    [dbb addObject:@"DEFINIZIONE"];
    [dbb addObject:@"SINONIMI"];
    NSMutableArray *corsu = [[NSMutableArray alloc] init];
    [corsu addObject: @"FRANCESE"];
    [corsu addObject:@"Definizione"];
    [corsu addObject:@"Sinonimi"];
    NSMutableArray *fcese = [[NSMutableArray alloc] init];
    [fcese addObject:@"CORSU"];
    [fcese addObject:@"Définition en Corse"];
    [fcese addObject:@"Synonymes"];
    NSMutableArray *liste = [[NSMutableArray alloc] init];
    [liste addObject:@{@"mot_corse":@"id",
                       @"mot_francais":@"FRANCESE"}];
    NSMutableArray *mots = [[NSMutableArray alloc] init];
    [mots addObject:@{@"mot_corse":@"FRANCESE",
                      @"mot_francais":@"id"}];
    [mots addObject:@"DEFINIZIONE"];
    [mots addObject:@"SINONIMI"];
    NSDictionary *parames = @{
                              @"dbb_query":dbb,
                              @"mot_corse":corsu,
                              @"mot_francais" : fcese,
                              @"affiche_liste":liste,
                              @"affiche_mot":mots};
    //pref *aPref = [[pref alloc]init];
    pref *aPref = [pref getPref];
    self.aParam.parametres = aPref.params;
    NSLog(@"pref %@",aPref.params);
    if(!aPref) {
        pref *aPref = [[pref alloc] initWithParams:parames];
        self.aParam.parametres = aPref.params;
        [pref savePref:aPref];
    }
    self.defText = @{@"mot_corse":@"a parolla à traduce",@"mot_francais":@"tapez le mot à traduire"};}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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

@end
