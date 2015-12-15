//
//  EmployeeViewController.h
//  hrm_2
//
//  Created by Kazi Sharmin Dina on 12/3/15.
//  Copyright © 2015 Kazi Sharmin Dina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UIDatePicker *dpBirthDate;
@property (weak, nonatomic) IBOutlet UITextField *txtBirthPlace;
@property (weak, nonatomic) IBOutlet UIPickerView *pvDepartmant;
@property (weak, nonatomic) IBOutlet UITextField *txtStatus;
@property (weak, nonatomic) IBOutlet UIPickerView *pvDesignation;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UISwitch *sActive;
@property (strong, nonatomic) NSString *nameTxt;
- (IBAction)btnSaveEmployee:(id)sender;
- (IBAction)btnReset:(id)sender;

@end
