//
//  RRGlobal.h
//  RashRecord
//
//  Created by LongPD on 4/22/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import <Foundation/Foundation.h>

// Settings
#define kRRUserDefaults                                 [NSUserDefaults standardUserDefaults]
#define kRRUserNameKey                                  @"kRRUserNameKey"
#define kRRUserName                                     [kRRUserDefaults objectForKey:kRRUserNameKey]
#define kRRUserSexKey                                   @"kRRUserSexKey"
#define kRRUserSex                                      [kRRUserDefaults integerForKey:kRRUserSexKey]
#define kRRDosageNoteIndexKey                           @"kRRDosageNoteIndexKey"
#define kRRDosageNoteIndex                              [kRRUserDefaults integerForKey:kRRDosageNoteIndexKey]
#define kRRDosageNoteKey                                @"kRRDosageNoteKey"
#define kRRDosageNote                                   [kRRUserDefaults objectForKey:kRRDosageNoteKey]
#define kRRDosageAMKey                                  @"kRRDosageAMKey"
#define kRRDosageAM                                     [kRRUserDefaults integerForKey:kRRDosageAMKey]
#define kRRDosagePMKey                                  @"kRRDosagePMKey"
#define kRRDosagePM                                     [kRRUserDefaults integerForKey:kRRDosagePMKey]
#define kRRTimeDrinkAMKey                               @"kRRTimeDrinkAMKey"
#define kRRTimeDrinkAM                                  [kRRUserDefaults objectForKey:kRRTimeDrinkAMKey]
#define kRRTimeDrinkPMKey                               @"kRRTimeDrinkPMKey"
#define kRRTimeDrinkPM                                  [kRRUserDefaults objectForKey:kRRTimeDrinkPMKey]
#define kRRNotificationGoToHospitalKey                  @"kRRNotificationGoToHospitalKey"
#define kRRNotificationGoToHospital                     [kRRUserDefaults integerForKey:kRRNotificationGoToHospitalKey]
#define kRRTimingNotificationIndexKey                   @"kRRTimingNotificationIndexKey"
#define kRRTimingNotificationIndex                      [kRRUserDefaults integerForKey:kRRTimingNotificationIndexKey]
#define kRRTimingNotificationKey                        @"kRRTimingNotificationKey"
#define kRRTimingNotification                           [kRRUserDefaults objectForKey:kRRTimingNotificationKey]

// Value
#define kRRNumberSecondsInDay           24 * 3600

// Data base
#define kRRRashRecordTableName          @"RashRecord"

#define kRRRashRecordID                 @"kRRRashRecordIdentifier"
#define kRRRashRecordDate               @"kRRRashRecordDate"
#define kRRRashRecordDes                @"kRRRashRecordDes"
#define kRRRashRecordPtRightLeg         @"kRRRashRecordPtRightLeg"
#define kRRRashRecordPtLeftLeg          @"kRRRashRecordPtLeftLeg"
#define kRRRashRecordPtRightHand        @"kRRRashRecordPtRightHand"
#define kRRRashRecordPtLeftHand         @"kRRRashRecordPtLeftHand"
#define kRRRashRecordNumPmPin           @"kRRRashRecordNumPmPin"
#define kRRRashRecordNumAmPin           @"kRRRashRecordNumAmPin"
#define kRRRashRecordTile               @"kRRRashRecordTile"
#define kRRRashRecordNavGlId            @"kRRRashRecordNavGlId"
#define kRRRashRecordNavCalId           @"kRRRashRecordNavCalId"
#define kRRRashRecordHosAddress         @"kRRRashRecordHosAddress"
#define kRRRashRecordHosTime            @"kRRRashRecordHosTime"

@interface RRGlobal : NSObject

@end
