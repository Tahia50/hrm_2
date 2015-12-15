//
//  EmployeeListViewController.h
//  hrm_2
//
//  Created by Abu Khalid on 12/7/15.
//  Copyright © 2015 Kazi Sharmin Dina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *employeeTableView;
@property (strong, nonatomic) NSArray *employeeNameArray;
@property (strong, nonatomic) NSString *departmentName;

- (NSArray *)getEmployeeNames;

@end
