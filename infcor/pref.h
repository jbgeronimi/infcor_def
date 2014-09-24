//
//  pref.h
//  ADECEC
//
//  Created by admin notte on 21/09/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pref : NSObject<NSCoding>
@property (strong,nonatomic)  NSDictionary *params;

-(id)initWithParams:(NSDictionary *)aPref;
+(NSString *)getPathToArchive;
+(pref *)getPref;
+(void)savePref:(pref *)aPref;
@end
