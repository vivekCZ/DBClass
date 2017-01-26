//
//  ViewController.m
//  dataBase
//
//  Created by cloudZon Infosoft on 03/06/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "ViewController.h"
#import "dbManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)goToSecond:(id)sender {
    SecondViewController *second=[[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    [self.navigationController pushViewController:second animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dbManager *db=[[dbManager alloc]initDatabasewithName:@"DemoOfDatabase"];
    
    
}

    // Do any additional setup after loading the view from its nib.


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
