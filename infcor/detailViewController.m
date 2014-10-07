//
//  detailViewController.m
//  INFCOR
//
//  Created by admin notte on 24/08/2014.
//  Copyright (c) 2014 ___calasoc___. All rights reserved.
//
#import "resultViewController.h"
#import "detailViewController.h"
#import "favoritesTableViewController.h"
#import "pref.h"
#import "favorites.h"

@interface detailViewController ()

@end

@implementation detailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      //  self.title = [self.detailRisultati valueForKey:self.params[@"affiche_mot"][0]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.detailTableView=[[UITableView alloc] init];
    self.detailTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    //self.aPref = [pref getPref];
    //self.alangue = aPref.alangue;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
        //customisation de la barre de nav
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:@"Code-BOLD" size:17.0f]
                                                            }];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.129 green:0.512 blue:1.000 alpha:1.000]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //une etoile de favoris dans la barre de Nav
    self.stella=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"stella"] style:UIBarButtonItemStyleDone target:self action:@selector(cambiaStella:)];
    [self showStella];
}
-(void)viewDidAppear:(BOOL)animated {
    self.aPref = [pref getPref];
    //il faut checker que le mot appartient aux favoris
    favorites *aFav = [favorites getFav];
    if([aFav.favList objectForKey:[self.detailRisultati objectForKey:@"id"]]){
        self.isFavorite = YES;}
    [self showStella];
    [self.tableView reloadData];

}

-(void)showStella{
    if(self.isFavorite){
        self.stella.tintColor = [UIColor colorWithWhite:1 alpha:1];
    }else {
        self.stella.tintColor = [UIColor colorWithWhite:.99 alpha:.45];
    }
    self.navigationItem.rightBarButtonItem = self.stella;
}

//la fonction de gestion de l'etoile
-(void)cambiaStella:(id)sender{
    if(self.isFavorite){
        [self removeFavorite];
        self.isFavorite = NO;
        [self showStella];
    }else{
        [self addFavorite];
        self.isFavorite = YES;
        [self showStella];
    }
}

//L'ajout des favoris
-(void)addFavorite{
    favorites *aFav = [favorites getFav];
    [aFav.favList setObject:self.detailRisultati forKey:[self.detailRisultati objectForKey:@"id"]];
    [favorites saveFav:aFav];
}

//la fonction d'effacement du favoris
-(void)removeFavorite{
    favorites *aFavorite = [favorites getFav];
    [aFavorite.favList removeObjectForKey:[self.detailRisultati objectForKey:@"id"]];
    //NSLog(@"risultati %@",[self.risultati[0] objectForKey:@"id"]);
    self.isFavorite = NO;
    [favorites saveFav:aFavorite];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.aPref.params[@"affiche_mot"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    UIFont *fonte = [UIFont fontWithName:@"Klill" size:18];
    cell.textLabel.font = fonte;
    UIFont *fonte20 = [UIFont fontWithName:@"Klill" size:21];
    //NSLog(@"rom %lu string %@",(long)indexPath.row , [self.params[self.alangue][indexPath.row] uppercaseString]);
    NSAttributedString *longDef=[[NSAttributedString alloc]initWithString:[self.aPref.params[self.aPref.alangue][indexPath.row] uppercaseString] attributes:@{NSFontAttributeName:fonte20}];
    NSMutableAttributedString *leTexte = [[NSMutableAttributedString alloc] initWithAttributedString:longDef];
    if(([[self.aPref.params valueForKey:@"affiche_mot"][0] valueForKey:self.aPref.alangue]) && (indexPath.row < 1)){
        NSString *mottu = [@"" stringByAppendingString:[self.detailRisultati valueForKey:[[self.aPref.params valueForKey:@"affiche_mot"][0] valueForKey:self.aPref.alangue]]];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
        cell.textLabel.attributedText = leTexte;
    }
    else{
        NSString *mottu = [@"" stringByAppendingString:[self.detailRisultati valueForKey:self.aPref.params[@"affiche_mot"][indexPath.row]]];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
        cell.textLabel.attributedText = leTexte;}
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *fonte= [UIFont fontWithName:@"Klill" size:18];
    UIFont *fonte20 = [UIFont fontWithName:@"Klill" size:21];
    NSAttributedString *longDef=[[NSAttributedString alloc]initWithString:[self.aPref.params[self.aPref.alangue][indexPath.row] uppercaseString] attributes:@{NSFontAttributeName:fonte20}];
    NSMutableAttributedString *leTexte = [[NSMutableAttributedString alloc] initWithAttributedString:longDef];
    if(([[self.aPref.params valueForKey:@"affiche_mot"][0] valueForKey:self.aPref.alangue]) && (indexPath.row < 1)){
       // NSLog(@"txt %@",[[self.params valueForKey:@"affiche_mot"][0] valueForKey:self.alangue]);
        NSString *mottu = [@"" stringByAppendingString:[self.detailRisultati valueForKey:[[self.aPref.params valueForKey:@"affiche_mot"][0] valueForKey:self.aPref.alangue]]];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
    }
    else{
        NSString *mottu = [@"" stringByAppendingString:[self.detailRisultati valueForKey:self.aPref.params[@"affiche_mot"][indexPath.row]]];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
    }
    CGSize maxCell = CGSizeMake(self.view.frame.size.width - 20, 99999);
    CGRect tailleCell = [leTexte boundingRectWithSize:maxCell
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                              context:nil];
    return tailleCell.size.height + MAX(35,tailleCell.size.height / 20);
}

-(void)viewWillDisappear:(BOOL)animated{
}

@end
