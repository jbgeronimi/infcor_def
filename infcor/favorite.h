//
//  favorite.h
//  ADECEC
//
//  Created by admin notte on 27/09/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface favorite : NSObject<NSCoding>
@property NSMutableArray *indice;

+(NSString *)getPathToArchive;
+(favorite *)getFav;
+(void)saveFav:(favorite *)aFav;
@end
