//
//  afficheMotViewController.m
//  INFCOR
//
//  Created by admin notte on 16/08/2014.
//  Copyright (c) 2014 ___calasoc___. All rights reserved.
//

#import "afficheMotViewController.h"
#import "favorites.h"

@interface afficheMotViewController ()

@end

@implementation afficheMotViewController

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    //une etoile de favoris dans la barre de Nav
    self.stella=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"stella"] style:UIBarButtonItemStyleDone target:self action:@selector(cambiaStella:)];
    [self showStella];
    //Ajout d'un spinner d'attente
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.spinner.frame = [[UIScreen mainScreen] bounds];
    self.spinner.center = CGPointMake( self.view.frame.size.width /2,(self.view.frame.size.height / 2) - 64);
    self.spinner.color = [UIColor blackColor];
    [self.spinner startAnimating];
    [self.view addSubview:self.spinner];}

-(void)showStella{
    if(self.isFavorite){
        self.stella.tintColor = [UIColor colorWithWhite:1 alpha:1];
    }else {
        self.stella.tintColor = [UIColor colorWithWhite:.99 alpha:.45];
    }
    self.navigationItem.rightBarButtonItem = self.stella;
    //return self.stella;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = self.searchText;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.afficheMotTableView=[[UITableView alloc] init];
    self.afficheMotTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.afficheMotTableView.delegate = self;
    self.afficheMotTableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    NSString *cercaURL = [NSString stringWithFormat:@"http://adecec.net/infcor/try/traitement.php?mot=%@&langue=%@&param=%@", self.searchText, self.alangue,[self.params[@"dbb_query"] componentsJoinedByString:@" "] ];
   // if([self.alangue isEqualToString:@"mot_francais"]){[self.params[@"dbb_query"] insertObject:@"id" atIndex:0 ];}
    cercaURL = [cercaURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *cerca = [NSURL URLWithString:cercaURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:cerca];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc]init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:_responseData
                                                           options:0
                                                             error:nil];
    self.risultati = json;
    //NSLog(@"risultati %@",self.risultati);
    self.title = self.searchText;
    //il faut checker que le mot appartient aux favoris
    favorites *aFav = [favorites getFav];
    if([aFav.favList objectForKey:[self.risultati[0] objectForKey:@"id"]]){
        self.isFavorite = YES;}
    [self showStella];
    [self.tableView reloadData];
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.spinner stopAnimating];
}

//la fonction de gestion de l'etoile
-(void)cambiaStella:(id)sender{
    if(!(self.willSetFavorite | self.isFavorite)){
        [self addFavorite];}
    if(self.isFavorite){
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithWhite:1 alpha:.45];
        [self removeFavorite];
        self.isFavorite = NO;
    }else{
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithWhite:1 alpha:1];
        self.isFavorite = YES;
    }
}

//la fonction d'ajout des favoris
-(void)addFavorite{
    self.willSetFavorite = TRUE;
    NSString *cercaURL = [NSString stringWithFormat:@"http://adecec.net/infcor/try/traitement.php?mot=%@&langue=%@&param=%@", self.searchText, self.alangue,[self.allParams[@"dbb_query"] componentsJoinedByString:@" "] ];
    cercaURL = [cercaURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // NSLog(self.allParams[@"dbb_query"]);
    NSURL *cerca = [[NSURL alloc] initWithString:cercaURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:cerca];
    // Requete ASynchrone
    favorites *aFavorite = [[favorites alloc] init];
    aFavorite = [favorites getFav];
    if(!aFavorite){ aFavorite.favList = [[NSMutableDictionary alloc] init];
        [aFavorite.favList setObject:@"x" forKey:@"y"];
        NSLog(@"jhgjhk");}
    __block NSMutableArray *json;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                               if (data) {json = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:nil];}
                               NSDictionary *tmpJson = json[0];
                               NSString *unique  = [tmpJson valueForKey:@"id"];
                               [aFavorite.favList setObject:tmpJson forKey:unique];
                               //aFavorite.favList = muTemp ;
                              // NSLog(@"afav %@",aFavorite.favList);
                               [favorites saveFav:aFavorite];
                         }];
    self.isFavorite = YES;
}

//la fonction d'effacement du favoris
-(void)removeFavorite{
    favorites *aFavorite = [favorites getFav];
    [aFavorite.favList removeObjectForKey:[self.risultati[0] objectForKey:@"id"]];
    NSLog(@"risultati %@",[self.risultati[0] objectForKey:@"id"]);
    self.isFavorite = NO;
    [favorites saveFav:aFavorite];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.afficheMotTableView reloadData];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.params[self.alangue] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell_%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    UIFont *fonte= [UIFont fontWithName:@"Klill" size:18];
    UIFont *fonte20 = [UIFont fontWithName:@"Klill" size:21];
    NSAttributedString *longDef=[[NSAttributedString alloc]initWithString:[self.params[self.alangue][indexPath.row] uppercaseString] attributes:@{NSFontAttributeName:fonte20}];
    NSMutableAttributedString *leTexte = [[NSMutableAttributedString alloc] initWithAttributedString:longDef];
    if((self.risultati.count > 0) && (indexPath.row < 1)) {
        NSString *mottu = [self.risultati valueForKey:[[self.params valueForKey:@"affiche_mot"][0] valueForKey:self.alangue]][0];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
        cell.textLabel.attributedText = leTexte;}
    else if(self.risultati.count > 0){
        NSString *mottu = [self.risultati valueForKey:self.params[@"affiche_mot"][indexPath.row]][0];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
        cell.textLabel.attributedText = leTexte;}
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
    NSAttributedString *longDef=[[NSAttributedString alloc]initWithString:[self.params[self.alangue][indexPath.row] uppercaseString]  attributes:@{NSFontAttributeName:fonte20}];
    NSMutableAttributedString *leTexte = [[NSMutableAttributedString alloc] initWithAttributedString:longDef];
    if((self.risultati.count > 0) && (indexPath.row < 1)) {
        NSString *mottu = [self.risultati valueForKey:[[self.params valueForKey:@"affiche_mot"][0] valueForKey:self.alangue]][0];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
        }
    else if(self.risultati.count > 0){
        NSString *mottu = [self.risultati valueForKey:self.params[@"affiche_mot"][indexPath.row]][0];
        NSAttributedString *leMot = [[NSAttributedString alloc] initWithString:mottu attributes:@{NSFontAttributeName:fonte}];
        [leTexte appendAttributedString:leMot];
        }
    else return 40;
    CGSize maxCell = CGSizeMake(self.view.frame.size.width - 20, 9999);
    CGRect tailleCell = [leTexte boundingRectWithSize:maxCell
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                              context:nil];
    return tailleCell.size.height + MAX(35,tailleCell.size.height / 20);
}

@end
