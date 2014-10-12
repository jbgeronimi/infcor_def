//
//  aboutViewController.m
//  ADECEC
//
//  Created by admin notte on 11/10/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import "aboutViewController.h"
#import "pref.h"

@interface aboutViewController ()

@end

@implementation aboutViewController

-(void)viewDidAppear:(BOOL)animated {
    self.title = @"INFCOR";
    self.aPref = [pref getPref];
    self.aboutLabel.text = [self.aboutText valueForKey:self.aPref.alangue];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aPref = [pref getPref];
 //customisation de la barre de nav
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:@"Code-BOLD" size:17.0f]
                                                            }];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.129 green:0.512 blue:1.000 alpha:1.000]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIFont *gio = [UIFont fontWithName:@"arial" size:16];
    self.view.backgroundColor = [UIColor whiteColor];
    self.aboutText = @{@"mot_corse":@"",
                                @"mot_francais":@"Le projet lancé par l\'ADECEC le 19 août 1983 était de créer une banque de données linguistiques la plus complète possible.\nLe programme, qui s\'intitule INFCOR, prévoit l\'enregistrement, la mise en forme et le stockage de toutes les composantes de la langue: vocabulaire traditionnel dans ses variétés, terminologies spécifiques anciennes et modernes, noms propres, locutions.\nChaque entrée comprend, outre la définition en langue corse, la prononciation figurée, l\'étymologie, les synonymes, les antonymes, les dérivés et composés, les analogies, ainsi que les équivalents français, italiens, anglais... une illustration tirée des oeuvres littéraires et, si besoin est, une bibliographie, complètent chaque article.\n\nCompte tenu de l\'accessibilité permanente pour toute personne publique ou privée, à la somme des informations recueillies tenues à jour par le programme INFCOR, celui-ci, qui est utilisable depuis 1999, est appelé à rendre des services sans lesquels ni l\'usage, ni l\'enseignement du corse ne sauraient véritablement progresser."};
    self.aboutLabel = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height  )];
    self.aboutLabel.text = [self.aboutText valueForKey:self.aPref.alangue];
    self.aboutLabel.font = gio;
    self.aboutLabel.tintColor = [UIColor blackColor];
    [self.aboutLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self.view addSubview:self.aboutLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    self.title = nil;
}

@end
