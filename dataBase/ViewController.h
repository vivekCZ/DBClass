//
//  ViewController.h
//  dataBase
//
//  Created by cloudZon Infosoft on 03/06/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "SecondViewController.h"
@interface ViewController : UIViewController

@property(nonatomic) sqlite3 *connectToDB;
@property(strong,nonatomic) NSString *dataBasePath;
@end
