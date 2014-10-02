//
//  detailViewController.m
//  INFCOR
//
//  Created by admin notte on 24/08/2014.
//  Copyright (c) 2014 ___calasoc___. All rights reserved.
//
#import "resultViewController.h"
#import "detailViewController.h"
#import "favoritesTableViewController.h"
#import "pref.h"

@interface detailViewController ()

@end

@implementation detailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      //  self.title = [self.detailRisultati valueForKey:self.params[@"affiche_mot"][0]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.detailTableView=[[UITableView alloc] init];
    self.detailTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    [self.detailTableView reloadData];
    //self.aPref = [pref getPref];
    //self.alangue = aPref.alangue;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    self.aPref = [pref getPref];
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.aPref.params[@"affiche_mot"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    UIFont *fonte = [UIFont fontWithName:@"Klill" size:18];
    cell.textLabel.font = fonte;
    UIFont *fonte20 = [UIFont fontWithName:@"Klill" size:21];
    //NSLog(@"rom %lu string %@",(long)indexPath.row , [self.params[self.alangue][indexPath.row] uppercaseString]);
    NSAttributedString *longDef=[[NSAttributedString alloc]initWithString:[self.aPref.params[self.aPref.alangue][indexPath.row] uppercaseString] attributes:@{NSFontAttributeName:fonte20}];
    NSMutableAttributedString *leTexte = [[NSMutableAttributedString alloc] initWithAttributedString:longDef];
    if(([[self.aPref.params valueForKey:@"affiche_mot"][0] valueForKey:self.aPref.alangue]) && (indexPath.row < 1)){
        NSString *mottu = [@"" stringByAppendingString:[self.detailRisultati valueForKey:[[self.aPref.params valueForKey:@"affiche_mot"][0] valueForKey:self.aPref.alangue]]];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
        cell.textLabel.attributedText = leTexte;
    }
    else{
        NSString *mottu = [@"" stringByAppendingString:[self.detailRisultati valueForKey:self.aPref.params[@"affiche_mot"][indexPath.row]]];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
        cell.textLabel.attributedText = leTexte;}
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *fonte= [UIFont fontWithName:@"Klill" size:18];
    UIFont *fonte20 = [UIFont fontWithName:@"Klill" size:21];
    NSAttributedString *longDef=[[NSAttributedString alloc]initWithString:[self.aPref.params[self.aPref.alangue][indexPath.row] uppercaseString] attributes:@{NSFontAttributeName:fonte20}];
    NSMutableAttributedString *leTexte = [[NSMutableAttributedString alloc] initWithAttributedString:longDef];
    if(([[self.aPref.params valueForKey:@"affiche_mot"][0] valueForKey:self.aPref.alangue]) && (indexPath.row < 1)){
       // NSLog(@"txt %@",[[self.params valueForKey:@"affiche_mot"][0] valueForKey:self.alangue]);
        NSString *mottu = [@"" stringByAppendingString:[self.detailRisultati valueForKey:[[self.aPref.params valueForKey:@"affiche_mot"][0] valueForKey:self.aPref.alangue]]];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
    }
    else{
        NSString *mottu = [@"" stringByAppendingString:[self.detailRisultati valueForKey:self.aPref.params[@"affiche_mot"][indexPath.row]]];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
    }
    CGSize maxCell = CGSizeMake(self.view.frame.size.width - 20, 99999);
    CGRect tailleCell = [leTexte boundingRectWithSize:maxCell
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                              context:nil];
        return tailleCell.size.height + MAX(15,tailleCell.size.height / 20);
}

-(void)viewWillDisappear:(BOOL)animated{
}

@end
