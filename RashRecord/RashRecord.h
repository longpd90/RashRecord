//
//  RashRecord.h
//  RashRecord
//
//  Created by LongPD on 4/23/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RashRecord : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * des;
@property (nonatomic, retain) NSString * pt_right_leg;
@property (nonatomic, retain) NSString * pt_left_leg;
@property (nonatomic, retain) NSString * pt_right_hand;
@property (nonatomic, retain) NSString * pt_left_hand;
@property (nonatomic, retain) NSString * num_pm_pin;
@property (nonatomic, retain) NSString * num_am_pin;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * nav_gl_id;
@property (nonatomic, retain) NSString * nav_cal_id;
@property (nonatomic, retain) NSString * hos_address;
@property (nonatomic, retain) NSDate * hos_time;

@end
