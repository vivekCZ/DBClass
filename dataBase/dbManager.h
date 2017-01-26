//
//  dbManager.h
//  dataBase
//
//  Created by cloudZon Infosoft on 03/06/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <sqlite3.h>
@interface dbManager : NSObject
@property(nonatomic) sqlite3 *connectToDB;
@property(strong,nonatomic) NSString *dataBasePath;
-(dbManager *)initDatabasewithName:(NSString *)name;
-(void)createDB:(NSString *)nameOfDB;
-(void)saveData:(NSString *)name number:(NSString *)number data:(NSData *)imageData;
-(NSDictionary *)fetchData;
@end
