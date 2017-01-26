//
//  dbManager.m
//  dataBase
//
//  Created by cloudZon Infosoft on 03/06/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "dbManager.h"

@implementation dbManager
@synthesize dataBasePath,connectToDB;
const char *dbPath;

-(dbManager *)initDatabasewithName:(NSString *)name{
    
    
    if (self==[super init]) {
        [self createDB:name];
    }
    return self;
}

-(void)createDB:(NSString *)nameOfDB{
    
    
    NSString *docDir;
    NSArray *dirPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docDir=dirPath[0];
    
    dataBasePath=[[NSString alloc]initWithString:[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",nameOfDB]]];
    
    NSFileManager *filemanager=[NSFileManager defaultManager];
    
    if ([filemanager fileExistsAtPath:dataBasePath]==NO) {
        dbPath=[dataBasePath UTF8String];
        if (sqlite3_open(dbPath, &connectToDB)==SQLITE_OK) {
            const char *createDB="create table if not exists User(name text,number text,image BLOB)";
            char *errmsg;
            if (sqlite3_exec(connectToDB, createDB, NULL, NULL, &errmsg)!=SQLITE_OK) {
                NSLog(@"failed to cretae table");
            }
            else{
                NSLog(@"cretaed successfully");
            }
            sqlite3_close(connectToDB);
        }
        else{
            NSLog(@"failed to open database");
        }
    }
    
}

-(void)saveData:(NSString *)name number:(NSString *)number data:(NSData *)imageData{
    
    const char *dbPath=[dataBasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbPath, &connectToDB)==SQLITE_OK) {
        
        //NSString *insertDB=[NSString stringWithFormat:@"insert into User (name,number) values(\"%@\" , \"%@\")",name,number];
        //    const char *insert=[insertDB UTF8String];
        const char *ins="insert into User (name,number,image) values (?,?,?)";
        sqlite3_prepare_v2(connectToDB, ins, -1, &statement, NULL);
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, NULL);
        sqlite3_bind_text(statement, 2, [number UTF8String], -1, NULL);
        sqlite3_bind_blob(statement, 3, [imageData bytes], [imageData length], SQLITE_TRANSIENT);
        if (sqlite3_step(statement)==SQLITE_DONE) {
            NSLog(@"inserted successfully");
        }
        else{
            NSLog(@"error");
        }
        sqlite3_finalize(statement);
        sqlite3_close(connectToDB);
    }
    
}

-(NSDictionary *)fetchData{
    //NSMutableArray *array=[[NSMutableArray alloc]init];
    NSDictionary *dic;
    const char *dbPath=[dataBasePath UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_open(dbPath, &connectToDB)==SQLITE_OK) {
        NSString *string=[NSString stringWithFormat:@"select * from User"];
        const char *select=[string UTF8String];
        if (sqlite3_prepare_v2(connectToDB,
                               select, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *name;
                const char* date = (const char*)sqlite3_column_text(statement, 0);
                if (date == NULL)
                    NSLog(@"nulll");
                else{
                    name = [[NSString alloc]
                            initWithUTF8String:
                            date];
                }
                NSString *phone;
                const char* date1 = (const char*)sqlite3_column_text(statement, 1);
                if (date1 == NULL){
                    NSLog(@"nul");
                }
                else{
                    phone = [[NSString alloc]
                             initWithUTF8String:(const char *)
                             sqlite3_column_text(statement, 1)];
                }
                
                int length = sqlite3_column_bytes(statement, 2);
                NSData *imageData = [NSData dataWithBytes:sqlite3_column_blob(statement, 2) length:length];
                
                NSLog(@"Length : %d", [imageData length]);
                dic=[[NSDictionary alloc]initWithObjectsAndKeys:name,@"name",phone,@"number",imageData,@"image",nil];
                //[array addObject:dic];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(connectToDB);
    }
    return dic;
}

@end
