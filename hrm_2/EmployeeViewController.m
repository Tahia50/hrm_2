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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pickerDatafordepartment = [self getDepartmentNames];
    _pickerDatafordesignation = [self getDesignations];
    self.pvDepartmant.dataSource = self;
    self.pvDepartmant.delegate = self;
    self.pvDesignation.dataSource = self;
    self.pvDesignation.delegate = self;
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

-(void)clear {
    self.txtName.text = @"";
    self.txtBirthPlace.text = @"";
    self.txtStatus.text = @"";
    self.txtPhone.text = @"";
    [self.sActive setOn:YES animated:YES];
 }
- (IBAction)btnReset:(id)sender {
    
    [self clear];
}
@end
