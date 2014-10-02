//
//  favoritesTableViewController.h
//  ADECEC
//
//  Created by admin notte on 29/09/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "favorites.h"

@interface favoritesTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *favoritesTableView;
@property (strong,nonatomic) favorites *aFav;
@property (strong,nonatomic) UIFont *gio;
@property NSArray *allkeys;
@end
