//
//  RRRecordDetailView.m
//  RashRecord
//
//  Created by LongPD on 4/25/14.
//  Copyright (c) 2014 LongPD. All rights reserved.
//

#import "RRRecordDetailView.h"

@implementation RRRecordDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"RRRecordDetailView" owner:nil options:nil];
        self = [objects objectAtIndex:0];
        //Detail Calendar
        self.btnCalendarDetail.selected = NO;
        self.btnMedicineMorning1.selected = NO;
        self.btnMedicineMorning2.selected = NO;
        self.numAM = 0;
        self.btnMedicineNight1.selected = NO;
        self.btnMedicineNight2.selected = NO;
        self.numPM = 0;
        //Scroll
        [self.scrollView setContentSize:CGSizeMake(316, 500)];

        
    }
    return self;
}

//Btn Medicine
- (IBAction)btnMedicineMorning1Clicked:(id)sender
{
    [self.delegate clickIconMedicine];
    self.btnMedicineMorning1.selected = !self.btnMedicineMorning1.selected;
    if (self.btnMedicineMorning1.selected)
    {
        [self.btnMedicineMorning1 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_drink.png"] forState:UIControlStateNormal];
        self.numAM ++;
    }
    else
    {
        [self.btnMedicineMorning1 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_not_drink.png"] forState:UIControlStateNormal];
        self.numAM --;
    }
}
- (IBAction)btnMedicineMorning2Clicked:(id)sender
{
    [self.delegate clickIconMedicine];
    self.btnMedicineMorning2.selected = !self.btnMedicineMorning2.selected;
    if (self.btnMedicineMorning2.selected)
    {
        [self.btnMedicineMorning2 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_drink.png"] forState:UIControlStateNormal];
        self.numAM ++;
    }
    else
    {
        [self.btnMedicineMorning2 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_not_drink.png"] forState:UIControlStateNormal];
        self.numAM --;
    }
}

- (IBAction)btnMedicineNight1Clicked:(id)sender
{
    [self.delegate clickIconMedicine];
    self.btnMedicineNight1.selected = !self.btnMedicineNight1.selected;
    if (self.btnMedicineNight1.selected)
    {
        [self.btnMedicineNight1 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_drink.png"] forState:UIControlStateNormal];
        self.numPM ++;
    }
    else
    {
        [self.btnMedicineNight1 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_not_drink.png"] forState:UIControlStateNormal];
        self.numPM --;
    }

}
- (IBAction)btnMedicineNight2Clicked:(id)sender
{
    [self.delegate clickIconMedicine];
    self.btnMedicineNight2.selected = !self.btnMedicineNight2.selected;
    if (self.btnMedicineNight2.selected)
    {
        [self.btnMedicineNight2 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_drink.png"] forState:UIControlStateNormal];
        self.numPM ++;
    }
    else
    {
        [self.btnMedicineNight2 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_not_drink.png"] forState:UIControlStateNormal];
        self.numPM --;
    }
    
}
- (void)loadButtonMedicineMorning
{
    switch (self.numAM)
    {
        case 0:
            self.btnMedicineMorning1.selected = NO;
            [self.btnMedicineMorning1 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_not_drink.png"] forState:UIControlStateNormal];
            self.btnMedicineMorning2.selected = NO;
            [self.btnMedicineMorning2 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_not_drink.png"] forState:UIControlStateNormal];
            break;
        case 1:
            self.btnMedicineMorning1.selected = YES;
            [self.btnMedicineMorning1 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_drink.png"] forState:UIControlStateNormal];
            self.btnMedicineMorning2.selected = NO;
            [self.btnMedicineMorning2 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_not_drink.png"] forState:UIControlStateNormal];
            break;
        case 2:
            self.btnMedicineMorning1.selected = YES;
            [self.btnMedicineMorning1 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_drink.png"] forState:UIControlStateNormal];
            self.btnMedicineMorning2.selected = YES;
            [self.btnMedicineMorning2 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_drink.png"] forState:UIControlStateNormal];
            break;

    }
}
- (void)loadButtonMedicineNight
{
    switch (self.numPM)
    {
        case 0:
            self.btnMedicineNight1.selected = NO;
            [self.btnMedicineNight1 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_not_drink.png"] forState:UIControlStateNormal];
            self.btnMedicineNight2.selected = NO;
            [self.btnMedicineNight2 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_not_drink.png"] forState:UIControlStateNormal];
            break;
        case 1:
            self.btnMedicineNight1.selected = YES;
            [self.btnMedicineNight1 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_drink.png"] forState:UIControlStateNormal];
            self.btnMedicineNight2.selected = NO;
            [self.btnMedicineNight2 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_not_drink.png"] forState:UIControlStateNormal];
            break;
        case 2:
            self.btnMedicineNight1.selected = YES;
            [self.btnMedicineNight1 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_drink.png"] forState:UIControlStateNormal];
            self.btnMedicineNight2.selected = YES;
            [self.btnMedicineNight2 setBackgroundImage:[UIImage imageNamed:@"icon_medicine_drink.png"] forState:UIControlStateNormal];
            break;
            
    }
}

#pragma mark - Delegate UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    [self.scrollView setContentSize:CGSizeMake(316, 500)];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake([textField superview].frame.origin.x, [textField superview].frame.origin.y) animated:YES];
    [self.scrollView setContentSize:CGSizeMake(316, 500)];
    [self.delegate textFieldBeginEditting];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.txtExaminationTime)
    {
        [self.scrollView setContentOffset:CGPointMake([textField superview].frame.origin.x, [textField superview].frame.origin.y) animated:YES];
        [self endEditing:YES];
        [self.delegate textFieldShouldBeginEditting];
        return NO;
    }
    return YES;
}
#pragma mark - Delegate UITextView
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.scrollView setContentOffset:CGPointMake([textView superview].frame.origin.x, [textView superview].frame.origin.y) animated:YES];
    [self.scrollView setContentSize:CGSizeMake(316, 500)];

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self.scrollView setContentSize:CGSizeMake(316, 500)];
        return NO;
    }
    
    return YES;
}
@end
