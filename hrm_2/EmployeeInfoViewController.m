//
//  EmployeeInfoViewController.m
//  hrm_2
//
//  Created by Abu Khalid on 12/7/15.
//  Copyright © 2015 Kazi Sharmin Dina. All rights reserved.
//

#import "EmployeeInfoViewController.h"
#import "AppDelegate.h"
#import "Employee.h"
#import "Department.h"
#import "Designation.h"

@interface EmployeeInfoViewController ()

@end

@implementation EmployeeInfoViewController

@synthesize labelOfName, showName, labelOfPlace, labelOfStatus, labelOfPhone, labelOfDepartment, labelOfDesignation, labelOfBirthday;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    labelOfName.text = showName;
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
    [request setEntity:entity];
    NSPredicate *predicatedes = [NSPredicate predicateWithFormat:@"name == %@",labelOfName.text];
    [request setPredicate:predicatedes];
    Employee *empObject = [[context executeFetchRequest:request error:&error]lastObject];
    if(empObject) {
        labelOfPlace.text = empObject.placeOfBirth;
        labelOfStatus.text = empObject.status;
        labelOfPhone.text = empObject.phone;
        labelOfDepartment.text = empObject.departmentOfEmployee.departmantName;
        labelOfDesignation.text = empObject.designationOfEmployee.designationName;
        NSDate *date;
        if (!empObject.birthDate) {
            labelOfBirthday.text = @" ";
        } else if (empObject.birthDate) {
            date = [NSDate dateWithTimeIntervalSince1970: empObject.birthDate];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd-MM-yyyy"];
            labelOfBirthday.text = [dateFormatter stringFromDate:date];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion: nil];
}
@end
