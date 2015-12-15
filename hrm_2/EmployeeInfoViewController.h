//
//  EmployeeInfoViewController.h
//  hrm_2
//
//  Created by Abu Khalid on 12/7/15.
//  Copyright © 2015 Kazi Sharmin Dina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeInfoViewController : UIViewController

@property (strong, nonatomic) NSString *showName;
@property (strong, nonatomic) IBOutlet UILabel *labelOfName;
@property (strong, nonatomic) IBOutlet UILabel *labelOfPlace;
@property (strong, nonatomic) IBOutlet UILabel *labelOfBirthday;
@property (strong, nonatomic) IBOutlet UILabel *labelOfPhone;
@property (strong, nonatomic) IBOutlet UILabel *labelOfDesignation;
@property (strong, nonatomic) IBOutlet UILabel *labelOfStatus;
@property (strong, nonatomic) IBOutlet UILabel *labelOfDepartment;




- (IBAction)dismiss:(id)sender;

@end
