//
//  Designation+CoreDataProperties.h
//  
//
//  Created by Tahia Ata on 12/3/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Designation.h"

NS_ASSUME_NONNULL_BEGIN

@interface Designation (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *designationName;
@property (nullable, nonatomic, retain) NSSet<Employee *> *employeeOfDesignationType;

@end

@interface Designation (CoreDataGeneratedAccessors)

- (void)addEmployeeOfDesignationTypeObject:(Employee *)value;
- (void)removeEmployeeOfDesignationTypeObject:(Employee *)value;
- (void)addEmployeeOfDesignationType:(NSSet<Employee *> *)values;
- (void)removeEmployeeOfDesignationType:(NSSet<Employee *> *)values;

@end

NS_ASSUME_NONNULL_END
