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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated{
    //self.aParam = [[params alloc]init];
    self.aPref = [pref getPref];
    [self.navigationController setNavigationBarHidden:YES];
    //self.AP = self.aPref.alangue;
    //self.allParams = self.aParam.allParams;
   // self.title = @"Options";
    self.allParams = @{
                       @"dbb_query":@[@"TALIANU",@"INGLESE",@"NATURA",@"PRUNUNCIA",@"DEFINIZIONE",@"ETIMULUGIA",@"GRAMMATICA",@"VARIANTESD",@"SINONIMI",@"ANTONIMI",@"DERIVADICOMPOSTI",@"SPRESSIONIEPRUVERBII",@"ANALUGIE",@"CITAZIONIDAAUTORI",@"BIBLIOGRAFIA",@"INDICE"],
                       @"affiche_mot":@[@"TALIANU",@"INGLESE",@"NATURA",@"PRUNUNCIA",@"DEFINIZIONE",@"ETIMULUGIA",@"GRAMMATICA",@"VARIANTESD",@"SINONIMI",@"ANTONIMI",@"DERIVADICOMPOSTI",@"SPRESSIONIEPRUVERBII",@"ANALUGIE",@"CITAZIONIDAAUTORI",@"BIBLIOGRAFIA",@"INDICE"],
                       @"mot_corse": @[@"Talianu",@"Inglese",@"Natura",@"Prununzia",@"Definizione",@"Etimulugia",@"Grammatica",@"Variante",@"Sinonimi",@"Antonimi",@"Derivati Cumposti",@"Spressioni è Pruverbii",@"Analugie",@"Citazioni dà Autori",@"Bibliografia",@"Indice"],
                       @"mot_francais" : @[@"Italien",@"Anglais",@"Genre",@"Prononciation",@"Définition en Corse",@"Etymologie",@"Grammaire",@"Variantes Graphiques",@"Synonymes",@"Antonymes",@"Dérivés Composés",@"Expressions et Proverbes",@"Analogies",@"Citations d'Auteurs",@"Bibliographie",@"Indice"]
                       };
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
    //self.aPref.params = [pref getPref].params;
    // un tableau avec tous les elements de params
    self.afficheParams=[[UITableView alloc] init];
    self.afficheParams.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.afficheParams.delegate = self;
    self.afficheParams.dataSource = self;
    //self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //self.tableView.sectionFooterHeight = 16;
    //self.tableView.rowHeight = 39;
    //if (self.modalPresentationStyle == UIModalPresentationCustom) {    }
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
    [pref savePref:self.aPref];
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