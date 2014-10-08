//
//  ViewController.m
//  infcor
//
//  Created by admin notte on 24/07/2014.
//  Copyright (c) 2014 ___calasoc___. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "prefsViewController.h"
#import "SideDismissalTransition.h"
#import "SideTransition.h"
#import "AppDelegate.h"
#import "resultViewController.h"
#import "afficheMotViewController.h"
#import "favoritesTableViewController.h"
#import "pref.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self setDefaultValuesForVariables];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[self.searchText becomeFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    self.aPref = [pref getPref];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
   //customisation de la barre de nav
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:@"Code-BOLD" size:17.0f]
                                                            }];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.129 green:0.512 blue:1.000 alpha:1.000]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.tabBarController.tabBar.backgroundColor = [UIColor blackColor];

    self.view.autoresizesSubviews = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.010 green:0.000 blue:0.098 alpha:1.000];
    self.gio = [UIFont fontWithName:@"Klill" size:20];
    // je cree une vue pour le fond bleu
    UIView *lefond = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 115)];
    [lefond setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    lefond.backgroundColor = [UIColor colorWithRed:0.129 green:0.512 blue:1.000 alpha:1.000];
    [self.view addSubview:lefond];
    //detection du clavier pour adapter la hauteur des suggestions
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:@"UIKeyboardWillHideNotification"
                                               object:nil];

    UIFont *titre = [UIFont fontWithName:@"Sansation" size:20];
    NSDictionary *langInit = @{@"mot_corse":@"Corsu \u2192 Francese",
                               @"mot_francais":@"Français \u2192 Corse"};
    //corsu - francese ou  francais-corse
    self.primu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.primu.frame = CGRectMake(55,21, self.view.frame.size.width - 100, 42);
    [self.primu.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.primu.titleLabel setFont:titre];
    self.primu.tintColor = [UIColor colorWithWhite:1 alpha:1];
    //une image pour signifier l'inversion
    [self.primu setImage:[UIImage imageNamed:@"reload.png"] forState:UIControlStateNormal];
    self.primu.imageEdgeInsets = UIEdgeInsetsMake(0, self.primu.frame.size.width - 50 , 0, 0);
    [self.primu setTitle:[langInit valueForKey:self.aPref.alangue] forState:UIControlStateNormal];
    [self.primu setTitleEdgeInsets:UIEdgeInsetsMake(0, 25 - (self.primu.frame.size.width /2) , 0, 0)];
    // NSLog(@"frame image %f",self.primu.imageView.frame.size.width);
    [self.primu addTarget:self
                   action:@selector(changeLanguage:)
         forControlEvents:UIControlEventTouchUpInside];
    self.primu.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleLeftMargin);
    [self.view addSubview:self.primu];
    
    //la zone de saisie du texte, le texte par defaut  et son bouton d'effacement
    self.searchText = [[UITextField alloc] initWithFrame:CGRectMake(30, 64, self.view.frame.size.width - 60, 39)];
    //le texte par defaut
    self.searchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.defText valueForKey:self.aPref.alangue] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.7]}];
    [self.searchText setBorderStyle:UITextBorderStyleRoundedRect];
    //le bouton d'effacement
    UIButton *effaceBouton= [UIButton buttonWithType:UIButtonTypeCustom];
    [effaceBouton setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    effaceBouton.frame = CGRectMake(0,0, 24, 20);
    [effaceBouton addTarget:self
                     action:@selector(clearTextField:)
           forControlEvents:UIControlEventTouchUpInside];
    self.searchText.rightViewMode = UITextFieldViewModeWhileEditing;
    self.searchText.rightView = effaceBouton;
    
    self.searchText.font = self.gio;
    self.searchText.textColor = [UIColor whiteColor];
    [self.searchText setAutocorrectionType:UITextAutocorrectionTypeNo],
    [self.searchText setBackgroundColor:[UIColor colorWithRed:0.000 green:0.000 blue:0.200 alpha:0.850]];
    self.searchText.returnKeyType = UIReturnKeySearch;
    //on interroge la base a chaque lettre tapée (editingChanged)
    [self.searchText addTarget:self
                        action:@selector(editingChanged:)
              forControlEvents:UIControlEventEditingChanged];
    self.searchText.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.searchText];
    //on range le clavier
    [self.searchText addTarget:self
                        action:@selector(enleveClavier)
              forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //une vue pour l'image de fond
    UIButton *fiond = [[UIButton alloc] initWithFrame:CGRectMake(0, 115, self.view.frame.size.width, self.view.frame.size.height)];
    [fiond setImage:[UIImage imageNamed:@"fiond"] forState:UIControlStateNormal] ;
    fiond.alpha = 0.19;
    fiond.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [fiond addTarget:self action:@selector(enleveClavierSuiteTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fiond];
        
    //un tableau avec les suggestions
    self.suggestTableView=[[UITableView alloc] initWithFrame:CGRectMake(30, 115, self.view.frame.size.width - 60, 8)];
    self.suggestTableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.suggestTableView.delegate = self;
    self.suggestTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.suggestTableView./*backgroundColor = [UIColor colorWithRed:0.010 green:0.000 blue:0.098 alpha:1.000];*/backgroundColor = [[UIColor alloc] initWithWhite:0.5 alpha:0.08];
    self.suggestTableView.dataSource = self;
    self.suggestTableView.rowHeight = 28;
    [self.view addSubview:self.suggestTableView];

}

//la croix d'effacement
-(void)clearTextField:(id)sender {
    self.searchText.text = nil;
    self.suggest = nil;
    CGRect newTable = self.suggestTableView.frame;
    newTable.size.height = 2;
    self.suggestTableView.frame = newTable;
    [self.suggestTableView reloadData];
}

-(void)editingChanged:(id)sender {
    NSString *cercaString = [NSString stringWithFormat:@"http://adecec.net/infcor/try/suggestion.php?mot=%@&langue=%@", self.searchText.text, self.aPref.alangue];
    NSURL *cercaURL = [[NSURL alloc] initWithString:cercaString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:cercaURL];
    // Requete ASynchrone
    __block NSMutableArray *json;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (data) {json = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:nil];}
                               self.suggest = json;
                               self.suggestTableView.frame = CGRectMake(30, 115, self.view.frame.size.width - 60, MIN(8 + self.suggest.count * 28, self.maxTable));
                               [self.suggestTableView reloadData];
                           }];
}

//Une Table pour les suggestions
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.suggest.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //couleur du texte
    cell.textLabel.textColor = [UIColor colorWithWhite:.8 alpha:1];
    //couleur des cellules
    if (indexPath.row %2) {
        UIColor *couleurPaire = [[UIColor alloc] initWithWhite:0.5 alpha:0.1];
        cell.backgroundColor = couleurPaire;
    }else{
        UIColor *couleurImpaire = [[UIColor alloc] initWithWhite:0.5 alpha:0.2];
        cell.backgroundColor = couleurImpaire;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.font = self.gio;
    cell.textLabel.text = self.suggest[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   	//[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //cas ou on selectionne la suggestion -> definition du mot direct
    afficheMotViewController *motVC=[[afficheMotViewController alloc] init];
    motVC.searchText = self.suggest[indexPath.row];
    motVC.aPref = self.aPref;
 //   motVC.params = self.aPref.params;
    motVC.gio = self.gio;
    [self.navigationController pushViewController:motVC animated:YES];
}
//@si on tape quelque part sur l'ecran
-(void)enleveClavierSuiteTap {
    [self.searchText resignFirstResponder];
 }

//si le mot a ete tape en entier et que "enter" a ete presse -> nouveau tableau avec toutes les possibilités associées au mot
-(BOOL)enleveClavier {
    resultViewController *risultatiVC=[[resultViewController alloc] init];
    //risultatiVC.params = self.aPref.params;
   // risultatiVC.alangue = self.aPref.alangue;
    risultatiVC.searchText = self.searchText.text;
    risultatiVC.title = self.searchText.text;
    risultatiVC.gio = self.gio;
    if (risultatiVC.searchText.length > 1){
        [self.navigationController pushViewController:risultatiVC animated:YES];
    }
    [self.searchText resignFirstResponder];
    CGRect newTable = self.suggestTableView.frame;
    newTable.size.height = MIN(8 + self.suggest.count * 28, self.view.frame.size.height - 115);
    //self.suggestTableView.frame = newTable;
    return YES;
}

//redimensionnement des suggestions en fonction de la taille du clavier
- (void) keyboardWillShow:(NSNotification *)note {
    NSDictionary *userInfo = [note userInfo];
    CGSize keySize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect newTable = self.suggestTableView.frame;
    newTable.size.height = MIN(8 + self.suggest.count * 28, self.view.frame.size.height - 115 - MIN(keySize.height, keySize.width));
    self.maxTable = self.view.frame.size.height - 115 - MIN(keySize.height, keySize.width);
    self.suggestTableView.frame = newTable;
}

-(void)keyboardWillHide:(NSNotification *)note{
    CGRect newTable = self.suggestTableView.frame;
    newTable.size.height = MIN(8 + self.suggest.count * 28, self.view.frame.size.height - 115 - self.tabBarController.tabBar.frame.size.height);
    self.suggestTableView.frame = newTable;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeLanguage:(UIButton *) sender {
    if ([sender.titleLabel.text isEqualToString:@"Corsu \u2192 Francese"]){
        [self.primu setTitle:@"Français \u2192 Corse" forState:UIControlStateNormal];
        self.aPref.alangue = @"mot_francais";
    }else {
        [self.primu setTitle:@"Corsu \u2192 Francese" forState:UIControlStateNormal];
        self.aPref.alangue = @"mot_corse";
    }
    self.searchText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[self.defText valueForKey:self.aPref.alangue] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.7]}];
    //on a change la langue, il faut refaire une requete
    [self editingChanged:self.searchText.text];
    [self.suggestTableView reloadData];
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
//initialisation des prefs
    self.aPref = [pref getPref];
    if(!self.aPref) {
        self.aPref = [[pref alloc] initWithParams:parames];
        self.aPref.alangue = @"mot_corse";
        [pref savePref:self.aPref];
    }
//initialisation des favoris
    self.aFav = [favorites getFav];
    if(!self.aFav){
        self.aFav = [[favorites alloc] init];
        [favorites saveFav:self.aFav];
    }
    [self.aFav.favList removeObjectForKey:@": favorits"];
    [favorites saveFav:self.aFav];

    self.defText = @{@"mot_corse":@"a parolla à traduce",@"mot_francais":@"tapez le mot à traduire"};
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated {
    //[favorites saveFav:self.aFav];
    [pref savePref:self.aPref];
}
@end
