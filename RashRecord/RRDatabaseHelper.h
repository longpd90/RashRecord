//
//  RRDatabaseHelper.h
//  RashRecord
//
//  Created by LongPD on 4/23/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RashRecord.h"
#import "RRGlobal.h"

@interface RRDatabaseHelper : NSObject

+ (RRDatabaseHelper *)shareMyInstance;

- (NSMutableArray *)getRecordObjectsFromDatabase:(NSString *)tableName
                                         withRow:(NSPredicate *)rowName
                                          andKey:(NSString *)keySearch
                                andSortAscending:(BOOL)sortAscending;
- (NSMutableArray *)getAllRecordObjectsFromDatabase:(NSString *)tableName;
- (NSMutableArray *)getRecordObjectsFromDate:(NSDate *)dateStart
                                      toDate:(NSDate *)dateEnd
                               withTableName:(NSString *)tableName;
- (BOOL)insertObjectToDataBase:(NSString *)tableName withDictionnary:(NSDictionary *)dictionnary;
- (BOOL)updateObjectToDatabase:(RashRecord *)rashRecoreEntity withDictionnary:(NSDictionary *)dictionnary;
- (BOOL)saveCoreDataInContext:(NSManagedObjectContext *)context;

@end
