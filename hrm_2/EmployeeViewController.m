//
//  EmployeeViewController.m
//  hrm_2
//
//  Created by Kazi Sharmin Dina on 12/3/15.
//  Copyright © 2015 Kazi Sharmin Dina. All rights reserved.
//

#import "EmployeeViewController.h"
#import "AppDelegate.h"
#import "Department.h"
#import "Designation.h"
#import "Employee.h"

@interface EmployeeViewController () {
    NSArray *_pickerDatafordepartment;
    NSArray *_pickerDatafordesignation;
    Department *department_Name;
    Designation *designation_Name;
}
@end

@implementation EmployeeViewController
@synthesize scrollview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pickerDatafordepartment = [self getDepartmentNames];
    _pickerDatafordesignation = [self getDesignations];
    self.pvDepartmant.dataSource = self;
    self.pvDepartmant.delegate = self;
    self.pvDesignation.dataSource = self;
    self.pvDesignation.delegate = self;
    //[self viewEmployeeInfo:@"kazi sharmin Dina"];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint scrolPoint = CGPointMake(0, textField.frame.origin.y);
    [scrollview setContentOffset:scrolPoint animated:YES];
}

-(void)textFieldDidEndEditing:textField {
    [scrollview setContentOffset:CGPointZero animated:YES];
}

- (NSArray *)getDepartmentNames {
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Department" inManagedObjectContext:context];
    fetchRequest.entity = entity;
    NSError *error;
    NSArray *departmentName = [context executeFetchRequest:fetchRequest error:&error];
    if (!departmentName) {
        NSLog(@"%@",[error localizedDescription]);
        NSMutableArray *emptyArray = [NSMutableArray array];
        return emptyArray;
    }
    NSLog(@"getdepartment\n");
    return departmentName;
}

- (NSArray *)getDesignations {
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Designation" inManagedObjectContext:context];
    fetchRequest.entity = entity;
    NSError *error;
    NSArray *departmentName = [context executeFetchRequest:fetchRequest error:&error];
    if (!departmentName) {
        NSLog(@"%@",[error localizedDescription]);
        NSMutableArray *emptyArray = [NSMutableArray array];
        return emptyArray;
    }
    NSLog(@"getdesignation\n");
    return departmentName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (long)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (long)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if([pickerView isEqual:self.pvDesignation]) {
        return _pickerDatafordesignation.count;
    }
    else {
        return _pickerDatafordepartment.count;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(pickerView == self.pvDesignation) {
        designation_Name = _pickerDatafordesignation[row];
    }
    else {
        department_Name = _pickerDatafordepartment[row];
    }
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if([pickerView isEqual:self.pvDesignation]) {
        Designation *depInfo = _pickerDatafordesignation[row];
        return depInfo.designationName;
    }
    else {
        Department *depInfo = _pickerDatafordepartment[row];
        return depInfo.departmantName;
    }
  }

- (IBAction)btnSaveEmployee:(id)sender {
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
    [request setEntity:entity];
    NSPredicate *predicatedes = [NSPredicate predicateWithFormat:@"name == %@",self.txtName.text ];
    [request setPredicate:predicatedes];
    Employee *empObject = [[context executeFetchRequest:request error:&error]lastObject] ;
    if(empObject) {
        empObject.name = self.txtName.text;
        empObject.placeOfBirth = self.txtBirthPlace.text;
        empObject.status = self.txtStatus.text;
        empObject.phone = self.txtPhone.text;
        empObject.active = self.sActive.on;
        empObject.birthDate = [[self.dpBirthDate date] timeIntervalSince1970];
        [department_Name addEmployeeOfDepartmentTypeObject:empObject];
        [designation_Name addEmployeeOfDesignationTypeObject:empObject];
        if (![context save:&error]) {
            NSLog(@"save done");
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        [self clear];
        NSLog(@"employee edit done");
    }
    else {
        Employee *empobj = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
        empobj.name = self.txtName.text;
        empobj.placeOfBirth = self.txtBirthPlace.text;
        empobj.status = self.txtStatus.text;
        empobj.phone = self.txtPhone.text;
        empobj.birthDate = [[self.dpBirthDate date] timeIntervalSince1970];
        empobj.active = self.sActive.on;
        NSError *error;
        [department_Name addEmployeeOfDepartmentTypeObject:empobj];
        [designation_Name addEmployeeOfDesignationTypeObject:empobj];
        if (![context save:&error]) {
            NSLog(@"save done");
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        [self clear];
        NSLog(@"done");
    }
}

-(void)viewEmployeeInfo: (NSString*)employeeName {
    if(employeeName.length != 0){
        AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appdelegate managedObjectContext];
        NSError *error;
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
        [request setEntity:entity];
        NSPredicate *predicatedes = [NSPredicate predicateWithFormat:@"name == %@",employeeName ];
        [request setPredicate:predicatedes];
        Employee *empObject = [[context executeFetchRequest:request error:&error]lastObject] ;
        if(empObject) {
            self.txtName.text = empObject.name;
            self.txtBirthPlace.text = empObject.placeOfBirth;
            self.txtStatus.text = empObject.status;
            self.txtPhone.text = empObject.phone;
            [self.sActive  setOn:(empObject.active == 1)];
            int row = 0;
            for(Department *dpt in _pickerDatafordepartment){
                if([dpt.departmantName isEqualToString: empObject.departmentOfEmployee.departmantName]) {
                    [self.pvDepartmant selectRow:row inComponent:0 animated:YES];
                    break;
                }
                row++;
            }
            row = 0;
            for(Designation *dpt in _pickerDatafordesignation){
                if([dpt.designationName isEqualToString: empObject.designationOfEmployee.designationName]) {
                    [self.pvDesignation selectRow:row inComponent:0 animated:YES];
                    break;
                }
                row ++;
            }
            self.dpBirthDate.date = [NSDate dateWithTimeIntervalSince1970: empObject.birthDate];
            NSLog(@"employee view done");
        }
        else {
            NSLog(@"employee does not exist in the database");
        }
    }
}

-(void)clear {
    self.txtName.text = @"";
    self.txtBirthPlace.text = @"";
    self.txtStatus.text = @"";
    self.txtPhone.text = @"";
    [self.sActive setOn:YES animated:YES];
 }
- (IBAction)btnReset:(id)sender {
        //[self clear];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
