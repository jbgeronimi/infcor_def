//
//  aboutViewController.h
//  ADECEC
//
//  Created by admin notte on 11/10/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pref.h"

@interface aboutViewController : UIViewController
@property (strong,nonatomic) pref *aPref;
@property NSDictionary *aboutText;
@property UITextView *aboutLabel;
@end
