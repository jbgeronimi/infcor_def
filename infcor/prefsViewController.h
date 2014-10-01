//
//  prefsViewController.h
//  infcor
//
//  Created by admin notte on 24/07/2014.
//  Copyright (c) 2014 ___calasoc___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "params.h"


@interface prefsViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,NSCoding>

@property (strong,nonatomic) UITableView *afficheParams;
@property NSIndexPath *lindex;
//@property (strong, nonatomic) NSString  *alangue;
@property (strong,nonatomic) NSDictionary *params;
@property (strong,nonatomic) NSDictionary *allParams;
@property (strong,nonatomic) params *aParam;
@end
