//
//  favoritesTableViewController.m
//  ADECEC
//
//  Created by admin notte on 29/09/2014.
//  Copyright (c) 2014 ___adecec___. All rights reserved.
//

#import "favoritesTableViewController.h"
#import "favorites.h"
#import "pref.h"
#import "detailViewController.h"

@interface favoritesTableViewController ()

@end

@implementation favoritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //customisation de la barre de nav
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:@"Code-BOLD" size:17.0f]
                                                            }];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.129 green:0.512 blue:1.000 alpha:1.000]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.aFav = [favorites getFav];
    self.view.backgroundColor = [UIColor whiteColor];
    self.favoritesTableView=[[UITableView alloc] init];
    self.favoritesTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.favoritesTableView.delegate = self;
    self.favoritesTableView.dataSource = self;
    [self.favoritesTableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.aFav.favList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.allkeys = [self.aFav.favList allKeys];
    cell.textLabel.text = self.allkeys[indexPath.row];
    //le mot contient " : " il faut les enlever pour l'esthetique
   // cell.textLabel.text = [cell.textLabel.text substringFromIndex:2];
    cell.textLabel.font = self.gio;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    pref *aPref = [pref getPref];
    detailViewController *detVC = [[detailViewController alloc] init];
    detVC.detailRisultati = [self.aFav.favList valueForKey:self.allkeys[indexPath.row]];
    detVC.alangue = self.alangue;
    detVC.params = aPref.params;
    detVC.title = self.allkeys[indexPath.row];
    detVC.title = [detVC.title substringFromIndex:2];
    detVC.gio = self.gio;
    
    [self.navigationController pushViewController:detVC animated:YES];
}



@end