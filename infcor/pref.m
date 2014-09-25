//
//  pref.m
//  ADECEC
//
//  Created by admin notte on 21/09/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import "pref.h"

@implementation pref
-(id)init {
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
    NSDictionary *params = @{
                    @"dbb_query":dbb,
                    @"mot_corse":corsu,
                    @"mot_francais" : fcese,
                    @"affiche_liste":liste,
                    @"affiche_mot":mots};
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *docsDir = [paths objectAtIndex:0];
    NSArray *dircontents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docsDir error:nil];
   // NSString *archivePath = [docsDir stringByAppendingPathComponent:@"pref.model"];
    if([dircontents containsObject:@"pref.model"]) {
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:[docsDir stringByAppendingPathComponent:@"pref.model"]];
    }else{
        self = [self initWithParams:params];
        [pref savePref:self];
    }
    return self;
}

-(id)initWithParams:(NSDictionary *) aParam{
    self = [super init];
    if(self) {
        self.params = aParam;
    }
    return self;
}
-(pref *)initWithCoder:(NSCoder *)aDecoder{
    self.params = [aDecoder decodeObjectForKey:@"params"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.params forKey:@"params"];
}
+ (NSString *)getPathToArchive{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *docsDir = [paths objectAtIndex:0];
    return [docsDir stringByAppendingPathComponent:@"pref.model"];
}
+ (void)savePref:(pref *)aPref {
    [NSKeyedArchiver archiveRootObject:aPref toFile:[pref getPathToArchive]];
}
+(pref *)getPref{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[pref getPathToArchive]];
}
@end
