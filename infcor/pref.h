//
//  pref.h
//  ADECEC
//
//  Created by admin notte on 21/09/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pref : NSObject<NSCoding>

@property (strong,nonatomic) NSDictionary *allParams;
@property (strong,nonatomic) NSString *alangue;
@property (strong,nonatomic)  NSDictionary *params;
@property (strong,nonatomic) NSDictionary *titlePrefs;

-(id)initWithParams:(NSDictionary *)aPref;
+(NSString *)getPathToArchive;
+(pref *)getPref;
+(void)savePref:(pref *)aPref;
@end
