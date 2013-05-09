//
//  ALEXTypeGetters.h
//  ALEXTypeGetters
//
//  Created by Alexander Kempgen on 27.04.13.
//
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, ALEXTypeGetterOptions) {
	ALEXTypeGetterOptionsObjectIsOptional	= (1UL << 0),
//	ALEXTypeGetterOptionsAttemptToTransform	= (1UL << 1),
};

extern NSString * const ALEXTypeGettersErrorDomain;
extern NSString * const ALEXTypeGettersErrorDetailedErrorsKey;

typedef NS_ENUM(NSInteger, ALEXTypeGetterErrorCode) {
	ALEXTypeGetterErrorCodeUnknownError,
	ALEXTypeGetterErrorCodeMultipleErrors,
	ALEXTypeGetterErrorCodeNilObject,
	ALEXTypeGetterErrorCodeNotKindOfClass,
	ALEXTypeGetterErrorCodeArrayObjectsNotKindOfClass,
};

@interface NSDictionary (ALEXTypeGetters)

// NSJSONSerialization classes are: NSString, NSNumber, NSArray, NSDictionary, or NSNull
// Property list objects include NSData, NSString, NSArray, NSDictionary, NSDate, and NSNumber objects

- (NSString *)alex_stringForKey:(id)key;
- (NSNumber *)alex_numberForKey:(id)key;
- (NSArray *)alex_arrayForKey:(id)key;
- (NSDictionary *)alex_dictionaryForKey:(id)key;
- (NSNull *)alex_nullForKey:(id)key;
- (NSData *)alex_dataForKey:(id)key;
- (NSDate *)alex_dateForKey:(id)key;


- (NSArray *)alex_arrayOfStringsForKey:(id)key;
- (NSArray *)alex_arrayOfNumbersForKey:(id)key;
- (NSArray *)alex_arrayOfArraysForKey:(id)key;
- (NSArray *)alex_arrayOfDictionariesForKey:(id)key;
- (NSArray *)alex_arrayOfNullsForKey:(id)key;
- (NSArray *)alex_arrayOfDatasForKey:(id)key;
- (NSArray *)alex_arrayOfDatesForKey:(id)key;


- (NSString *)alex_stringForKey:(id)key error:(NSError **)error;
- (NSNumber *)alex_numberForKey:(id)key error:(NSError **)error;
- (NSArray *)alex_arrayForKey:(id)key error:(NSError **)error;
- (NSDictionary *)alex_dictionaryForKey:(id)key error:(NSError **)error;
- (NSNull *)alex_nullForKey:(id)key error:(NSError **)error;
- (NSData *)alex_dataForKey:(id)key error:(NSError **)error;
- (NSDate *)alex_dateForKey:(id)key error:(NSError **)error;

- (id)alex_objectOfClass:(Class)objectClass forKey:(id)key error:(NSError **)error;


- (NSArray *)alex_arrayOfStringsForKey:(id)key error:(NSError **)error;
- (NSArray *)alex_arrayOfNumbersForKey:(id)key error:(NSError **)error;
- (NSArray *)alex_arrayOfArraysForKey:(id)key error:(NSError **)error;
- (NSArray *)alex_arrayOfDictionariesForKey:(id)key error:(NSError **)error;
- (NSArray *)alex_arrayOfNullsForKey:(id)key error:(NSError **)error;
- (NSArray *)alex_arrayOfDatasForKey:(id)key error:(NSError **)error;
- (NSArray *)alex_arrayOfDatesForKey:(id)key error:(NSError **)error;

- (NSArray *)alex_arrayOfObjectsOfClass:(Class)objectClass forKey:(id)key error:(NSError **)error;


- (BOOL)alex_getString:(NSString **)string forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getNumber:(NSNumber **)number forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getArray:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getDictionary:(NSDictionary **)dictionary forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getNull:(NSNull **)null forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getData:(NSData **)data forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getDate:(NSDate **)date forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;

- (BOOL)alex_getObject:(id *)object ofClass:(Class)objectClass forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;


- (BOOL)alex_getArrayOfStrings:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getArrayOfNumbers:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getArrayOfArrays:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getArrayOfDictionaries:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getArrayOfNulls:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getArrayOfDatas:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
- (BOOL)alex_getArrayOfDates:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;

- (BOOL)alex_getArray:(NSArray **)array ofObjectsOfClass:(Class)objectClass forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;

@end


@interface NSArray (ALEXTypeGetters)

- (BOOL)alex_objectsAreKindOfClass:(Class)objectClass error:(NSError **)error;

@end

