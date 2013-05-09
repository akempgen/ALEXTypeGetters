//
//  ALEXTypeGetters.m
//  ALEXTypeGetters
//
//  Created by Alexander Kempgen on 27.04.13.
//
//

#import "ALEXTypeGetters.h"


NSString * const ALEXTypeGettersErrorDomain = @"ALEXTypeGettersErrorDomain";
NSString * const ALEXTypeGettersErrorDetailedErrorsKey = @"ALEXTypeGettersErrorDetailedErrorsKey";


@interface NSError (ALEXTypeGetters)

+ (void)alex_assignError:(NSError **)error forCode:(ALEXTypeGetterErrorCode)errorCode additionalInfo:(NSDictionary *)additionalInfo;
+ (NSError *)alex_errorForTypeGetterErrorCode:(ALEXTypeGetterErrorCode)errorCode additionalInfo:(NSDictionary *)additionalInfo;

@end


@implementation NSDictionary (ALEXTypeGetters)


- (NSString *)alex_stringForKey:(id)key {
	return [self alex_stringForKey:key error:NULL];
}
- (NSNumber *)alex_numberForKey:(id)key {
	return [self alex_numberForKey:key error:NULL];
}
- (NSArray *)alex_arrayForKey:(id)key {
	return [self alex_arrayForKey:key error:NULL];
}
- (NSDictionary *)alex_dictionaryForKey:(id)key {
	return [self alex_dictionaryForKey:key error:NULL];
}
- (NSNull *)alex_nullForKey:(id)key {
	return [self alex_nullForKey:key error:NULL];
}
- (NSData *)alex_dataForKey:(id)key {
	return [self alex_dataForKey:key error:NULL];
}
- (NSDate *)alex_dateForKey:(id)key {
	return [self alex_dateForKey:key error:NULL];
}


- (NSArray *)alex_arrayOfStringsForKey:(id)key {
	return [self alex_arrayOfStringsForKey:key error:NULL];
}
- (NSArray *)alex_arrayOfNumbersForKey:(id)key {
	return [self alex_arrayOfNumbersForKey:key error:NULL];
}
- (NSArray *)alex_arrayOfArraysForKey:(id)key {
	return [self alex_arrayOfArraysForKey:key error:NULL];
}
- (NSArray *)alex_arrayOfDictionariesForKey:(id)key {
	return [self alex_arrayOfDictionariesForKey:key error:NULL];
}
- (NSArray *)alex_arrayOfNullsForKey:(id)key {
	return [self alex_arrayOfNullsForKey:key error:NULL];
}
- (NSArray *)alex_arrayOfDatasForKey:(id)key {
	return [self alex_arrayOfDatasForKey:key error:NULL];
}
- (NSArray *)alex_arrayOfDatesForKey:(id)key {
	return [self alex_arrayOfDatesForKey:key error:NULL];
}


- (NSString *)alex_stringForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSString class];
	return [self alex_objectOfClass:objectClass forKey:key error:error];
}
- (NSNumber *)alex_numberForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSNumber class];
	return [self alex_objectOfClass:objectClass forKey:key error:error];
}
- (NSArray *)alex_arrayForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSArray class];
	return [self alex_objectOfClass:objectClass forKey:key error:error];
}
- (NSDictionary *)alex_dictionaryForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSDictionary class];
	return [self alex_objectOfClass:objectClass forKey:key error:error];
}
- (NSNull *)alex_nullForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSNull class];
	return [self alex_objectOfClass:objectClass forKey:key error:error];
}
- (NSData *)alex_dataForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSData class];
	return [self alex_objectOfClass:objectClass forKey:key error:error];
}
- (NSDate *)alex_dateForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSDate class];
	return [self alex_objectOfClass:objectClass forKey:key error:error];
}

- (id)alex_objectOfClass:(Class)objectClass forKey:(id)key error:(NSError **)error {
	id object;
	BOOL success = [self alex_getObject:&object ofClass:objectClass forKey:key options:0 error:error];
	if (!success) {
		return nil;
	}
	return object;
}


- (NSArray *)alex_arrayOfStringsForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSString class];
	return [self alex_arrayOfObjectsOfClass:objectClass forKey:key error:error];
}
- (NSArray *)alex_arrayOfNumbersForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSNumber class];
	return [self alex_arrayOfObjectsOfClass:objectClass forKey:key error:error];
}
- (NSArray *)alex_arrayOfArraysForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSArray class];
	return [self alex_arrayOfObjectsOfClass:objectClass forKey:key error:error];
}
- (NSArray *)alex_arrayOfDictionariesForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSDictionary class];
	return [self alex_arrayOfObjectsOfClass:objectClass forKey:key error:error];
}
- (NSArray *)alex_arrayOfNullsForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSNull class];
	return [self alex_arrayOfObjectsOfClass:objectClass forKey:key error:error];
}
- (NSArray *)alex_arrayOfDatasForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSData class];
	return [self alex_arrayOfObjectsOfClass:objectClass forKey:key error:error];
}
- (NSArray *)alex_arrayOfDatesForKey:(id)key error:(NSError **)error {
	Class objectClass = [NSDate class];
	return [self alex_arrayOfObjectsOfClass:objectClass forKey:key error:error];
}

- (NSArray *)alex_arrayOfObjectsOfClass:(Class)objectClass forKey:(id)key error:(NSError **)error {
	NSArray *array;
	BOOL success = [self alex_getArray:&array ofObjectsOfClass:objectClass forKey:key options:0 error:error];
	if (!success) {
		return nil;
	}
	return array;
}


- (BOOL)alex_getString:(NSString **)object forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSString class];
	return [self alex_getObject:object ofClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getNumber:(NSNumber **)object forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSNumber class];
	return [self alex_getObject:object ofClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getArray:(NSArray **)object forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSArray class];
	return [self alex_getObject:object ofClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getDictionary:(NSDictionary **)object forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSArray class];
	return [self alex_getObject:object ofClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getNull:(NSNull **)object forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSArray class];
	return [self alex_getObject:object ofClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getData:(NSData **)object forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSArray class];
	return [self alex_getObject:object ofClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getDate:(NSDate **)object forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSArray class];
	return [self alex_getObject:object ofClass:objectClass forKey:key options:options error:error];
}

- (BOOL)alex_getObject:(id *)object
			   ofClass:(Class)objectClass
				forKey:(id)key
			   options:(ALEXTypeGetterOptions)options
				 error:(NSError **)error {
	id objectForKey = [self objectForKey:key];
	if (objectForKey == nil) {
		if ((options & ALEXTypeGetterOptionsObjectIsOptional) == ALEXTypeGetterOptionsObjectIsOptional) {
			*object = nil;
			return YES;
		} else {
			// error for nil object
			// TODO: only pass key along, to avoid work when error is not set.
			NSString *reason = [NSString stringWithFormat:@"Object for key '%@' is nil",
								key];
			NSDictionary *additionalInfo = @{NSLocalizedFailureReasonErrorKey: reason};
			[NSError alex_assignError:error
							  forCode:ALEXTypeGetterErrorCodeNilObject
					   additionalInfo:additionalInfo];
			return NO;
		}
	} else if (![objectForKey isKindOfClass:objectClass]) {
		// error for wrong class
		// TODO: only pass key and objectClass along, to avoid work when error is not set.
		NSString *reason = [NSString stringWithFormat:@"Object for key '%@' is not kind of class %@",
							key, NSStringFromClass(objectClass)];
		NSDictionary *additionalInfo = @{NSLocalizedFailureReasonErrorKey: reason};
		[NSError alex_assignError:error
						  forCode:ALEXTypeGetterErrorCodeNotKindOfClass
				   additionalInfo:additionalInfo];
		return NO;
	}
	
	*object = objectForKey;
	return YES;
}


- (BOOL)alex_getArrayOfStrings:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSString class];
	return [self alex_getArray:array ofObjectsOfClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getArrayOfNumbers:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSNumber class];
	return [self alex_getArray:array ofObjectsOfClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getArrayOfArrays:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSArray class];
	return [self alex_getArray:array ofObjectsOfClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getArrayOfDictionaries:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSDictionary class];
	return [self alex_getArray:array ofObjectsOfClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getArrayOfNulls:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSNull class];
	return [self alex_getArray:array ofObjectsOfClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getArrayOfDatas:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSData class];
	return [self alex_getArray:array ofObjectsOfClass:objectClass forKey:key options:options error:error];
}
- (BOOL)alex_getArrayOfDates:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error {
	Class objectClass = [NSDate class];
	return [self alex_getArray:array ofObjectsOfClass:objectClass forKey:key options:options error:error];
}

- (BOOL)alex_getArray:(NSArray **)array
	 ofObjectsOfClass:(Class)objectClass
			   forKey:(id)key
			  options:(ALEXTypeGetterOptions)options
				error:(NSError **)error {
	NSArray *arrayForKey;
	BOOL isArray = [self alex_getArray:&arrayForKey forKey:key options:options error:error];
	if (!isArray) {
		return NO;
	}
	
	// if options is allows nil, arrayForKey can be nil at this point. sending a message to it will return NO in the next check!
	if (arrayForKey == nil && (options & ALEXTypeGetterOptionsObjectIsOptional) == ALEXTypeGetterOptionsObjectIsOptional) {
		*array = nil;
		return YES;
	}
	
	BOOL objectsAreKindOfClass = [arrayForKey alex_objectsAreKindOfClass:objectClass error:error];
	if (!objectsAreKindOfClass) {
		return NO;
	}
	
	*array = arrayForKey;
	return YES;
}


@end


@implementation NSArray (ALEXTypeGetters)

- (BOOL)alex_objectsAreKindOfClass:(Class)objectClass error:(NSError **)error {
	NSIndexSet *indexes = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return ![obj isKindOfClass:objectClass];
	}];
	
	if ([indexes count]) {
		// error for array objects have wrong class
		// TODO: only pass indexes and objectClass along, to avoid work when error is not set.
		NSMutableArray *ranges = [NSMutableArray array];
		[indexes enumerateRangesUsingBlock:^(NSRange range, BOOL *stop) {
			NSString *rangeString;
			if (range.length == 1) {
				rangeString = [NSString stringWithFormat:@"%lu", range.location];
			} else if (range.length > 1) {
				rangeString = [NSString stringWithFormat:@"%lu-%lu", range.location, range.location+range.length-1];
			}
			if (rangeString != nil) {
				[ranges addObject:rangeString];
			}
		}];
		NSString *reason = [NSString stringWithFormat:@"Objects at indexes %@ are not kind of class %@",
							[ranges componentsJoinedByString:@", "], NSStringFromClass(objectClass)];
		NSDictionary *additionalInfo = @{NSLocalizedFailureReasonErrorKey: reason};
		[NSError alex_assignError:error
						  forCode:ALEXTypeGetterErrorCodeArrayObjectsNotKindOfClass
				   additionalInfo:additionalInfo];
		return NO;
	}
	return YES;
}

@end



@implementation NSError (ALEXTypeGetters)

// TODO: this shouldn't be an NSError category, that will also fix the complaint by the analyzer
+ (void)alex_assignError:(NSError **)error forCode:(ALEXTypeGetterErrorCode)errorCode additionalInfo:(NSDictionary *)additionalInfo {
	if (error == NULL) {
		return;
	}
	
	NSError *newError = [NSError alex_errorForTypeGetterErrorCode:errorCode additionalInfo:additionalInfo];
	NSError *existingError = *error;
	if (existingError == nil) {
		*error = newError;
	} else {
		NSArray *existingErrors;
		if ([existingError domain] == ALEXTypeGettersErrorDomain && [existingError code] == ALEXTypeGetterErrorCodeMultipleErrors) {
			existingErrors = [[existingError userInfo] objectForKey:ALEXTypeGettersErrorDetailedErrorsKey];
			existingErrors = [existingErrors arrayByAddingObject:newError];
		}
		else {
			existingErrors = @[existingError, newError];
		}
		
		NSDictionary *multipleErrorAdditionalInfo = @{ALEXTypeGettersErrorDetailedErrorsKey: existingErrors};
		NSError *multipleError = [NSError alex_errorForTypeGetterErrorCode:ALEXTypeGetterErrorCodeMultipleErrors
															additionalInfo:multipleErrorAdditionalInfo];
		*error = multipleError;
	}
}


+ (NSError *)alex_errorForTypeGetterErrorCode:(ALEXTypeGetterErrorCode)errorCode additionalInfo:(NSDictionary *)additionalInfo {
	NSString *localizedDescription;
	
	switch (errorCode) {
		case ALEXTypeGetterErrorCodeUnknownError:
			localizedDescription = @"Unknown Error";
			break;
		case ALEXTypeGetterErrorCodeMultipleErrors:
			localizedDescription = @"Multiple Errors";
			break;
		case ALEXTypeGetterErrorCodeNilObject:
			localizedDescription = @"Nil Object Error";
			break;
		case ALEXTypeGetterErrorCodeNotKindOfClass:
			localizedDescription = @"Object Not Kind Of Class Error";
			break;
		case ALEXTypeGetterErrorCodeArrayObjectsNotKindOfClass:
			localizedDescription = @"Array Objects Not Kind Of Class Error";
			break;
	}
	
	NSDictionary *userInfo = @{NSLocalizedDescriptionKey: localizedDescription};
	if (additionalInfo != nil) {
		NSMutableDictionary *mutableUserInfo = [userInfo mutableCopy];
		[mutableUserInfo addEntriesFromDictionary:additionalInfo];
		userInfo = [mutableUserInfo copy];
	}
	NSError *error = [NSError errorWithDomain:ALEXTypeGettersErrorDomain code:errorCode userInfo:userInfo];
	return error;
}

@end

