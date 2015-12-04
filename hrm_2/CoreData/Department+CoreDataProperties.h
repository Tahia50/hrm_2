//
//  Department+CoreDataProperties.h
//  
//
//  Created by Tahia Ata on 12/3/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Department.h"

NS_ASSUME_NONNULL_BEGIN

@interface Department (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *departmantName;
@property (nullable, nonatomic, retain) NSSet<Employee *> *employeeOfDepartmentType;

@end

@interface Department (CoreDataGeneratedAccessors)

- (void)addEmployeeOfDepartmentTypeObject:(Employee *)value;
- (void)removeEmployeeOfDepartmentTypeObject:(Employee *)value;
- (void)addEmployeeOfDepartmentType:(NSSet<Employee *> *)values;
- (void)removeEmployeeOfDepartmentType:(NSSet<Employee *> *)values;

@end

NS_ASSUME_NONNULL_END
