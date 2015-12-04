//
//  Employee+CoreDataProperties.h
//  
//
//  Created by Tahia Ata on 12/3/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *active;
@property (nullable, nonatomic, retain) NSDate *birthDate;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *placeOfBirth;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) Department *departmentOfEmployee;
@property (nullable, nonatomic, retain) Designation *designationOfEmployee;

@end

NS_ASSUME_NONNULL_END
