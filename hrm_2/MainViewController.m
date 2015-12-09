//
//  MainViewController.m
//  hrm_2
//
//  Created by Tahia Ata on 12/1/15.
//  Copyright © 2015 Kazi Sharmin Dina. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "Department.h"
#import "Employee.h"

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.departmentArray = [self getDepartmentNames];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isFiltered) {
        return [self.filteredSearchResults count];
    } else {
        return [self.departmentArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    if (self.isFiltered) {
        NSString *employeeName = [self.filteredSearchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",(employeeName) ? employeeName: @""];
    } else {
        Department *departmentObject = [self.departmentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",(departmentObject.departmantName) ? departmentObject.departmantName: @""];
    }
    return cell;
}

#pragma mark - Public

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
    return departmentName;
}

- (void)addingDisableOverlay {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.disableViewOverlay = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 108.0f, screenRect.size.width, screenRect.size.height)];
    self.disableViewOverlay.backgroundColor = [UIColor blackColor];
    self.disableViewOverlay.alpha = 0;
    [self.view addSubview:self.disableViewOverlay];
    [UIView beginAnimations: @"FadeIn" context:nil];
    [UIView setAnimationDuration:0.5];
    self.disableViewOverlay.alpha = 0.6;
    [UIView commitAnimations];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self searchBar:searchBar activate:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar setText: @""];
    [self searchBar:searchBar activate:NO];
    self.isFiltered = NO;
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active {
    self.tableView.allowsSelection = !active;
    self.tableView.scrollEnabled = !active;
    if (!active) {
        [self.disableViewOverlay removeFromSuperview];
        [searchBar resignFirstResponder];
    } else {
        [self addingDisableOverlay];
    }
    [self.searchBar setShowsCancelButton:active animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.filteredSearchResults = [NSMutableArray array];
    if (searchText.length == 0) {
        self.isFiltered = NO;
        [self addingDisableOverlay];
        [self.tableView reloadData];
    } else {
        [self.disableViewOverlay removeFromSuperview];
         self.isFiltered = YES;
        AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
        NSFetchRequest *employeeDataRequest = [NSFetchRequest fetchRequestWithEntityName: @"Employee"];
        [employeeDataRequest setPredicate:[NSPredicate predicateWithFormat:@"\
                                               name contains[cd] %@\
                                               OR phone contains[cd] %@\
                                               OR departmentOfEmployee.departmantName contains[cd] %@ ",searchText,searchText,searchText]];
        NSError *error;
        NSArray *employeeDataArray = [[appdelegate managedObjectContext] executeFetchRequest:employeeDataRequest error:&error];
        if (!employeeDataArray) {
            NSLog(@"Fetch error: %@", [error localizedDescription]);
        } else {
            self.filteredSearchResults = [employeeDataArray valueForKey: @"name"];
        }
    }
    [self.tableView reloadData];
}

@end
