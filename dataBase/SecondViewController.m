//
//  SecondViewController.m
//  dataBase
//
//  Created by cloudZon Infosoft on 03/06/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "SecondViewController.h"
#import "dbManager.h"
@interface SecondViewController ()

@end

@implementation SecondViewController
dbManager *db;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     db=[[dbManager alloc]initDatabasewithName:@"DemoOfDatabase"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)insert:(id)sender {
    UIImage *i=[UIImage imageNamed:@"logo_small1"];
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(i)];
    [db saveData:@"Sample12" number:@"1234567" data:imageData];
}
- (IBAction)fetch:(id)sender {
    
    NSDictionary *dictionary=[db fetchData];
    
    NSLog(@"%@",dictionary);
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 20, 20)];
    img.image=[UIImage imageWithData:dictionary[@"image"]];

    [self.view addSubview:img];
}

@end
