//
//  ViewController.h
//  infcor
//
//  Created by admin notte on 24/07/2014.
//  Copyright (c) 2014 ___calasoc___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pref.h"
#import "favorites.h"

@interface ViewController : UIViewController <UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong,nonatomic) UIButton *primu;
//@property (strong,nonatomic) NSString *alangue;
@property (strong,nonatomic) UITextField *searchText;
@property (strong,nonatomic) NSURL *searchURL;
@property (strong,nonatomic) NSMutableArray *suggest;
@property (retain,nonatomic) UITableView *suggestTableView;
@property  float maxTable;
@property (strong,nonatomic) NSDictionary *allParams;
@property (assign,nonatomic) NSUInteger lindex;
@property (strong,nonatomic) UIFont *gio;
@property NSDictionary *defText;
@property (strong,nonatomic) pref *aPref;
@property (strong,nonatomic) favorites *aFav;
@end
