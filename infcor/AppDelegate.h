//
//  AppDelegate.h
//  infcor
//
//  Created by admin notte on 24/07/2014.
//  Copyright (c) 2014 ___calasoc___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "params.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) NSDictionary *params;
//@property (strong,nonatomic) NSString *alangue;
@property NSDictionary *defText;
@property (strong,nonatomic) params *aParam;
@property UIFont *gio;
@end
