//
//  prefsViewController.m
//  infcor
//
//  Created by admin notte on 24/07/2014.
//  Copyright (c) 2014 ___calasoc___. All rights reserved.
//

#import "prefsViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
//#import "params.h"
#import "pref.h"

@interface prefsViewController ()

@end

@implementation prefsViewController


- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated{
    //self.aParam = [[params alloc]init];
    //customisation de la barre de nav
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:@"Code-BOLD" size:17.0f]
                                                            }];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.129 green:0.512 blue:1.000 alpha:1.000]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //self.AP = self.aPref.alangue;
    //self.allParams = self.aParam.allParams;
   // self.title = @"Options";
    self.allParams = @{
                       @"dbb_query":@[@"TALIANU",@"INGLESE",@"NATURA",@"PRUNUNCIA",@"DEFINIZIONE",@"ETIMULUGIA",@"GRAMMATICA",@"VARIANTESD",@"SINONIMI",@"ANTONIMI",@"DERIVADICOMPOSTI",@"SPRESSIONIEPRUVERBII",@"ANALUGIE",@"CITAZIONIDAAUTORI",@"BIBLIOGRAFIA",@"INDICE"],
                       @"affiche_mot":@[@"TALIANU",@"INGLESE",@"NATURA",@"PRUNUNCIA",@"DEFINIZIONE",@"ETIMULUGIA",@"GRAMMATICA",@"VARIANTESD",@"SINONIMI",@"ANTONIMI",@"DERIVADICOMPOSTI",@"SPRESSIONIEPRUVERBII",@"ANALUGIE",@"CITAZIONIDAAUTORI",@"BIBLIOGRAFIA",@"INDICE"],
                       @"mot_corse": @[@"Talianu",@"Inglese",@"Natura",@"Prununzia",@"Definizione",@"Etimulugia",@"Grammatica",@"Variante",@"Sinonimi",@"Antonimi",@"Derivati Cumposti",@"Spressioni è Pruverbii",@"Analugie",@"Citazioni dà Autori",@"Bibliografia",@"Indice"],
                       @"mot_francais" : @[@"Italien",@"Anglais",@"Genre",@"Prononciation",@"Définition en Corse",@"Etymologie",@"Grammaire",@"Variantes Graphiques",@"Synonymes",@"Antonymes",@"Dérivés Composés",@"Expressions et Proverbes",@"Analogies",@"Citations d'Auteurs",@"Bibliographie",@"Indice"]
                       };
}

-(void)viewDidAppear:(BOOL)animated{
    self.aPref = [pref getPref];
    self.title = [self.aPref.titlePrefs valueForKey:self.aPref.alangue];
    [self.tableView reloadData];
}

-(NSDictionary *)decodeWithCoder:(NSCoder *)aDecoder {
    [aDecoder decodeObjectForKey:@"params"];
    return self.aPref.params;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.aPref.params forKey:@"params"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //self.aPref.params = [pref getPref].params;
    // un tableau avec tous les elements de params
    //self.tableView.bounds = CGRectMake(0, 444, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height -99);
    //NSLog(@"hei %lu, ecran %f",(long)self.tableView.frame.origin.y,[UIScreen mainScreen].bounds.size.height -99);
    //self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height -99)];
    //self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}
/*
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    self.view.layer.borderColor = [UIColor blackColor].CGColor;
     self.view.layer.borderWidth = 2.0f;
    UIButton *vabe = [UIButton buttonWithType:UIButtonTypeSystem];
    vabe.backgroundColor = [UIColor whiteColor];
    vabe.tintColor = [UIColor blackColor];
    [vabe setTitle:@"OK" forState:UIControlStateNormal];
    [vabe addTarget:self action:@selector(goodJob:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:vabe];
    return vabe;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25.0f;
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.aPref.allParams[self.aPref.alangue] count ];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    UIFont *fonte= [UIFont fontWithName:@"klill" size:17];
    cell.textLabel.font = fonte;
    cell.textLabel.text = self.aPref.allParams[self.aPref.alangue][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    cell.accessoryView = switchView;
    [switchView setTag:indexPath.row];
    [switchView setOn:[self.aPref.params[self.aPref.alangue] containsObject:self.aPref.allParams[self.aPref.alangue][indexPath.row]] animated:NO];
    [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    return cell;
}

- (void) switchChanged:(id)sender {
    UISwitch* switchControl = sender;
    if(switchControl.isOn){
        if (![self.aPref.params[self.aPref.alangue] containsObject:self.aPref.allParams[self.aPref.alangue][switchControl.tag]]){
            [self.aPref.params[@"dbb_query"] addObject:self.aPref.allParams[@"dbb_query"][switchControl.tag]];
            [self.aPref.params[@"affiche_mot"] addObject:self.aPref.allParams[@"affiche_mot"][switchControl.tag]];
            [self.aPref.params[@"mot_corse"] addObject:self.aPref.allParams[@"mot_corse"][switchControl.tag]];
            [self.aPref.params[@"mot_francais"] addObject:self.aPref.allParams[@"mot_francais"][switchControl.tag]];
        }
    }
    if (!switchControl.isOn){
        if ([self.aPref.params[self.aPref.alangue] containsObject:self.aPref.allParams[self.aPref.alangue][switchControl.tag]]){
            [self.aPref.params[@"dbb_query"] removeObject:self.aPref.allParams[@"dbb_query"][switchControl.tag]];
            [self.aPref.params[@"affiche_mot"] removeObject:self.aPref.allParams[@"affiche_mot"][switchControl.tag]];
            [self.aPref.params[@"mot_corse"] removeObject:self.aPref.allParams[@"mot_corse"][switchControl.tag]];
            [self.aPref.params[@"mot_francais"] removeObject:self.aPref.allParams[@"mot_francais"][switchControl.tag]];
        }
    }
    if(switchControl.on){
    }
    
}

- (void) viewWillDisappear:(BOOL)animated  ;
{
    //ViewController *VC = [[ViewController alloc] init];
    //pref *aPref = [[pref alloc] init];
    //aPref.params= self.aPref.params;
    self.title = @"";
    [pref savePref:self.aPref];
   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //VC.params = self.aPref.params;
    //[self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end