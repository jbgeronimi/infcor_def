//
//  params.m
//  ADECEC
//
//  Created by admin notte on 01/10/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import "params.h"

@implementation params
-(id)init{
    self = [super init];
    /*self.allParams = @{
                            @"dbb_query":@[@"TALIANU",@"INGLESE",@"NATURA",@"PRUNUNCIA",@"DEFINIZIONE",@"ETIMULUGIA",@"GRAMMATICA",@"VARIANTESD",@"SINONIMI",@"ANTONIMI",@"DERIVADICOMPOSTI",@"SPRESSIONIEPRUVERBII",@"ANALUGIE",@"CITAZIONIDAAUTORI",@"BIBLIOGRAFIA",@"INDICE"],
                            @"affiche_mot":@[@"TALIANU",@"INGLESE",@"NATURA",@"PRUNUNCIA",@"DEFINIZIONE",@"ETIMULUGIA",@"GRAMMATICA",@"VARIANTESD",@"SINONIMI",@"ANTONIMI",@"DERIVADICOMPOSTI",@"SPRESSIONIEPRUVERBII",@"ANALUGIE",@"CITAZIONIDAAUTORI",@"BIBLIOGRAFIA",@"INDICE"],
                            @"mot_corse": @[@"Talianu",@"Inglese",@"Natura",@"Prununzia",@"Definizione",@"Etimulugia",@"Grammatica",@"Variante",@"Sinonimi",@"Antonimi",@"Derivati Cumposti",@"Spressioni è Pruverbii",@"Analugie",@"Citazioni dà Autori",@"Bibliografia",@"Indice"],
                            @"mot_francais" : @[@"Italien",@"Anglais",@"Genre",@"Prononciation",@"Définition en Corse",@"Etymologie",@"Grammaire",@"Variantes Graphiques",@"Synonymes",@"Antonymes",@"Dérivés Composés",@"Expressions et Proverbes",@"Analogies",@"Citations d'Auteurs",@"Bibliographie",@"Indice"]
                            };*/
    
        //init des parametres
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
    
    self.parametres  = @{
                             @"dbb_query":dbb,
                             @"mot_corse":corsu,
                             @"mot_francais" : fcese,
                             @"affiche_liste":liste,
                             @"affiche_mot":mots};
    
    //la langue
    //if(!self.alangue){
    //    self.alangue = @"mot_corse";}
    return self;
}
@end

