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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *docsDir = [paths objectAtIndex:0];
    self = [NSKeyedUnarchiver unarchiveObjectWithFile:[docsDir stringByAppendingPathComponent:@"pref.model"]];
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
