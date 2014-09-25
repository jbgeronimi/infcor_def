//
//  favorites.h
//  ADECEC
//
//  Created by admin notte on 24/09/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface favorites : NSObject<NSCoding>
@property NSMutableDictionary *favList;

+(NSString *)getPathToArchive;
+(favorites *)getFav;
+(void)saveFav:(favorites *)aFav;
@end
