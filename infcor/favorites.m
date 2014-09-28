//
//  favorites.m
//  ADECEC
//
//  Created by admin notte on 24/09/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import "favorites.h"

@implementation favorites
-(id)init{
    self = [super init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *docsDir = [paths objectAtIndex:0];
    NSArray *dircontents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docsDir error:nil];
    // NSString *archivePath = [docsDir stringByAppendingPathComponent:@"pref.model"];
    if([dircontents containsObject:@"favorites.model"]) {
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:[docsDir stringByAppendingPathComponent:@"favorites.model"]];
    }else{
        self.favList = [[NSMutableDictionary alloc] initWithCapacity:1];
        [self.favList setObject:@"x" forKey:@"y"];
        [favorites saveFav:self];
    }
    return self;
}

-(favorites *)initWithCoder:(NSCoder *)aDecoder{
    self.favList = [aDecoder decodeObjectForKey:@"favList"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.favList forKey:@"favList"];
}
+ (NSString *)getPathToArchive{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *docsDir = [paths objectAtIndex:0];
    return [docsDir stringByAppendingPathComponent:@"favorites.model"];
}
+ (void)saveFav:(favorites *)aFav {
    [NSKeyedArchiver archiveRootObject:aFav toFile:[favorites getPathToArchive]];
}
+(favorites *)getFav{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[favorites getPathToArchive]];
}
@end
