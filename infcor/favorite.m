//
//  favorite.m
//  ADECEC
//
//  Created by admin notte on 27/09/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import "favorite.h"

@implementation favorite
-(id)init {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *docsDir = [paths objectAtIndex:0];
    self = [NSKeyedUnarchiver unarchiveObjectWithFile:[docsDir stringByAppendingPathComponent:@"favorite.model"]];
    return self;
}

-(favorite *)initWithCoder:(NSCoder *)aDecoder{
    self.indice = [aDecoder decodeObjectForKey:@"indice"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.indice forKey:@"indice"];
}

+ (NSString *)getPathToArchive{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *docsDir = [paths objectAtIndex:0];
    return [docsDir stringByAppendingPathComponent:@"favorite.model"];
}

+ (void)saveFav:(favorite *)aFav {
    [NSKeyedArchiver archiveRootObject:aFav toFile:[favorite getPathToArchive]];
}

+(favorite *)getFav{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[favorite getPathToArchive]];
}
@end
