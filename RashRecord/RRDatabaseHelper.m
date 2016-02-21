//
//  RRDatabaseHelper.m
//  RashRecord
//
//  Created by LongPD on 4/23/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRDatabaseHelper.h"

@implementation RRDatabaseHelper

static RRDatabaseHelper *shareInstance;

#pragma mark - Lifecycle methods

+ (RRDatabaseHelper *)shareMyInstance;
{
	@synchronized([RRDatabaseHelper class])
	{
		if (!shareInstance)
            shareInstance = [[self alloc] init] ;
        
		return shareInstance;
	}
	return nil;
}

+ (id)alloc
{
	@synchronized([RRDatabaseHelper class])
	{
		NSAssert(shareInstance == nil, @"Attempted to allocate a second instance of a singleton.");
		shareInstance = [super alloc];
		return shareInstance;
	}
	return nil;
}

#pragma mark - private

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma mark - update object

- (BOOL)insertObjectToDataBase:(NSString *)tableName withDictionnary:(NSDictionary *)dictionnary
{
    RashRecord *rashRecoreEntity = [NSEntityDescription insertNewObjectForEntityForName:tableName inManagedObjectContext:[self managedObjectContext]];
    return [self updateObjectToDatabase:rashRecoreEntity withDictionnary:dictionnary];

}

- (BOOL)updateObjectToDatabase:(RashRecord *)rashRecoreEntity withDictionnary:(NSDictionary *)dictionnary
{
    rashRecoreEntity.identifier = [dictionnary objectForKey:kRRRashRecordID];
    rashRecoreEntity.date = [dictionnary objectForKey:kRRRashRecordDate];
    rashRecoreEntity.des = [dictionnary objectForKey:kRRRashRecordDes];
    rashRecoreEntity.pt_left_hand = [dictionnary objectForKey:kRRRashRecordPtLeftHand];
    rashRecoreEntity.pt_right_hand = [dictionnary objectForKey:kRRRashRecordPtRightHand];
    rashRecoreEntity.pt_left_leg = [dictionnary objectForKey:kRRRashRecordPtLeftLeg];
    rashRecoreEntity.pt_right_leg = [dictionnary objectForKey:kRRRashRecordPtRightLeg];
    rashRecoreEntity.num_am_pin = [dictionnary objectForKey:kRRRashRecordNumAmPin];
    rashRecoreEntity.num_pm_pin = [dictionnary objectForKey:kRRRashRecordNumPmPin];
    rashRecoreEntity.title = [dictionnary objectForKey:kRRRashRecordTile];
    rashRecoreEntity.hos_address = [dictionnary objectForKey:kRRRashRecordHosAddress];
    rashRecoreEntity.hos_time = [dictionnary objectForKey:kRRRashRecordHosTime];
    rashRecoreEntity.nav_cal_id = [dictionnary objectForKey:kRRRashRecordNavCalId];
    rashRecoreEntity.nav_gl_id = [dictionnary objectForKey:kRRRashRecordNavGlId];
    return [self saveCoreDataInContext:[self managedObjectContext]];
}

#pragma mark - get objects

// get objects in interval
- (NSMutableArray *)getRecordObjectsFromDate:(NSDate *)dateStart
                                   toDate:(NSDate *)dateEnd
                            withTableName:(NSString *)tableName
{
    NSPredicate *predicateInterval = [NSPredicate predicateWithFormat:@"(date >= %@) AND (date < %@)",dateStart,dateEnd];
    return [self getRecordObjectsFromDatabase:tableName withRow:predicateInterval andKey:@"date" andSortAscending:NO];
}

// get all objects
- (NSMutableArray *)getAllRecordObjectsFromDatabase:(NSString *)tableName
{
	return [self getRecordObjectsFromDatabase:tableName withRow:nil andKey:nil andSortAscending:NO];
}

// get objects with a predicate
- (NSMutableArray *)getRecordObjectsFromDatabase:(NSString *)tableName
                                   withRow:(NSPredicate *)rowName
                                    andKey:(NSString *)keySearch
                          andSortAscending:(BOOL)sortAscending
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:tableName inManagedObjectContext:[self managedObjectContext]];
	[request setEntity:entity];
    
	if (rowName != nil)
		[request setPredicate:rowName];
    
	if (keySearch != nil) {
		NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:keySearch ascending:sortAscending];
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[request setSortDescriptors:sortDescriptors];
	}
    
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[[self managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
    
	if (mutableFetchResults == nil)
		NSLog(@"Couldn't get objects for entity %@", tableName);
    
	return mutableFetchResults;
}

#pragma mark - save Data

- (BOOL)saveCoreDataInContext:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    return YES;
}

@end
