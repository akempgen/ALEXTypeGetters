//
//  ALEXTypeGettersTests.m
//  ALEXTypeGettersTests
//
//  Created by Alexander Kempgen on 27.04.13.
//
//

#import "ALEXTypeGettersTests.h"

#import "ALEXTypeGetters.h"


@implementation ALEXTypeGettersTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testConvenienceGetters
{
	NSDictionary *dictionary = @{
								@"string": @"string",
								@"number": @1,
								@"arrayOfStrings": @[@"a",@"b",@"c"],
								@"arrayOfNumbers": @[@1,@2,@3],
								};
	
	NSError *error = nil;
	NSString *string = [dictionary alex_stringForKey:@"string" error:&error];
	STAssertNotNil(string, @"must return a string");
	STAssertNil(error, @"error shouldnt be set");
	
	error = nil;
	NSNumber *number = [dictionary alex_numberForKey:@"number" error:&error];
	STAssertNotNil(number, @"must return a number");
	STAssertNil(error, @"error shouldnt be set");
	
	error = nil;
	NSString *nilObject = [dictionary alex_stringForKey:@"missingKey" error:&error];
	STAssertNil(nilObject, @"key doesnt exist, object must be nil");
	STAssertNotNil(error, @"error should be set");
	STAssertEquals([error code], ALEXTypeGetterErrorCodeNilObject, @"wrong error code");
	
	error = nil;
	NSString *notANumber = [dictionary alex_stringForKey:@"number" error:&error];
	STAssertNil(notANumber, @"object for key is a number, not a string. object must be nil");
	STAssertNotNil(error, @"error should be set");
	STAssertEquals([error code], ALEXTypeGetterErrorCodeNotKindOfClass, @"wrong error code");
	
	
	
	error = nil;
	NSArray *array = [dictionary alex_arrayForKey:@"arrayOfStrings" error:&error];
	STAssertNotNil(array, @"not nil");
	STAssertNil(error, @"nil");
	
	error = nil;
	NSArray *arrayOfStrings = [dictionary alex_arrayOfStringsForKey:@"arrayOfStrings" error:&error];
	STAssertNotNil(arrayOfStrings, @"not nil");
	STAssertNil(error, @"nil");
	
	error = nil;
	NSArray *arrayOfNumbers = [dictionary alex_arrayOfStringsForKey:@"arrayOfNumbers" error:&error];
	STAssertNil(arrayOfNumbers, @"nil");
	STAssertNotNil(error, @"not nil");
	STAssertEquals([error code], ALEXTypeGetterErrorCodeArrayObjectsNotKindOfClass, @"wrong error code");
}

- (void)testMultipleErrors {
	
	NSDictionary *dictionary = @{
							  	@"string": @"string",
		 						@"number": @1,
							  	@"arrayOfStrings": @[@"a",@"b",@"c"],
							  	@"arrayOfNumbers": @[@1,@2,@3],
							  	};
	
	NSError *multipleErrors;
	
	NSString *nilObject = [dictionary alex_stringForKey:@"missingKey" error:&multipleErrors];
	STAssertNil(nilObject, @"key doesnt exist, object must be nil");
	STAssertNotNil(multipleErrors, @"error should be set");
	STAssertEquals([multipleErrors code], ALEXTypeGetterErrorCodeNilObject, @"wrong error code");
	
	NSString *notANumber = [dictionary alex_stringForKey:@"number" error:&multipleErrors];
	STAssertNil(notANumber, @"object for key is a number, not a string. object must be nil");
	STAssertNotNil(multipleErrors, @"error should be set");
	STAssertEquals([multipleErrors code], ALEXTypeGetterErrorCodeMultipleErrors, @"wrong error code");
	STAssertTrue([[[multipleErrors userInfo] objectForKey:ALEXTypeGettersErrorDetailedErrorsKey] count] == 2, @"wrong detailed error count");
	
	
	NSArray *arrayOfNumbers = [dictionary alex_arrayOfStringsForKey:@"arrayOfNumbers" error:&multipleErrors];
	STAssertNil(arrayOfNumbers, @"nil");
	STAssertNotNil(multipleErrors, @"not nil");
	STAssertEquals([multipleErrors code], ALEXTypeGetterErrorCodeMultipleErrors, @"wrong error code");
	STAssertTrue([[[multipleErrors userInfo] objectForKey:ALEXTypeGettersErrorDetailedErrorsKey] count] == 3, @"wrong detailed error count");
	
}


- (void)testExamples {
	/* from http://en.wikipedia.org/wiki/JSON
	{
		"id": 1,
		"name": "Foo",
		"price": 123,
		"tags": [ "Bar", "Eek" ],
		"stock": {
			"warehouse": 300,
			"retail": 20
		}
	}
	*/
	NSData *data = [@"{ \
					\"id\": 1, \
					\"name\": \"Foo\", \
					\"price\": 123, \
					\"tags\": [ \"Bar\", \"Eek\" ], \
					\"stock\": { \
						\"warehouse\": 300, \
						\"retail\": 20 \
					} \
					}" dataUsingEncoding:NSUTF8StringEncoding];
	
	NSError *JSONError;
	NSDictionary *JSONObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
	
	STAssertNotNil(JSONObject, @"JSONObject should not be nil in the example code.");
	STAssertTrue([JSONObject isKindOfClass:[NSDictionary class]], @"JSONObject should be a dictionary in the example code");
	
	// You still have to do these two parts:
	if (JSONObject == nil) {
		NSLog(@"Error deserializing JSON data: %@, data as string: %@",
			  JSONError, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
		return;
	}
	
	if (![JSONObject isKindOfClass:[NSDictionary class]]) {
		NSLog(@"JSON object was not a dictionary as expected: %@, description: %@",
			  NSStringFromClass([JSONObject class]), [JSONObject description]);
		return;
	}
	
	// Simple example with no error handling
	NSString *name = [JSONObject alex_stringForKey:@"name"];
	NSNumber *stockNumber = [JSONObject alex_numberForKey:@"stock"];
	// because stock is nil instead of a dictionary the next line is safe:
	NSUInteger stockInteger = [stockNumber unsignedIntegerValue];
	NSLog(@"name: %@ stock: %lu", name, stockInteger);
	// will log:
	/*
	 name: Foo stock: 0
	*/
	
	// Logging an Error
	NSError *tagsStringError;
	NSString *tagsString = [JSONObject alex_stringForKey:@"tags" error:&tagsStringError];
	if (tagsString == nil) {
		NSLog(@"Error getting tags from JSON:\n%@", tagsStringError);
	}
	// will log:
	/*
	 Error getting tags from JSON: Error Domain=ALEXTypeGettersErrorDomain Code=3 "Object Not Kind Of Class Error" UserInfo=0x100150330 {NSLocalizedDescription=Object Not Kind Of Class Error, NSLocalizedFailureReason=Object for key 'tags' is not kind of class NSString}
	 */
	
	// Combined Errors
	NSError *combinedErrors;
	NSString *idString = [JSONObject alex_stringForKey:@"id" error:&combinedErrors];
	NSNumber *price = [JSONObject alex_numberForKey:@"price" error:&combinedErrors]; // this one is fine
	NSString *description = [JSONObject alex_stringForKey:@"description" error:&combinedErrors];
	NSArray *tagsPrimaryKeys = [JSONObject alex_arrayOfNumbersForKey:@"tags" error:&combinedErrors];
	if (idString == nil || price == nil || description == nil || tagsPrimaryKeys == nil) {
		NSLog(@"Error getting some values from JSON:\n%@", combinedErrors);
	}
	// will log:
	/*
	 Error getting some values from JSON: Error Domain=ALEXTypeGettersErrorDomain Code=1 "Multiple Errors" UserInfo=0x1006009b0 {NSLocalizedDescription=Multiple Errors, ALEXTypeGettersErrorDetailedErrorsKey=(
	 "Error Domain=ALEXTypeGettersErrorDomain Code=3 \"Object Not Kind Of Class Error\" UserInfo=0x100600370 {NSLocalizedDescription=Object Not Kind Of Class Error, NSLocalizedFailureReason=Object for key 'id' is not kind of class NSString}",
	 "Error Domain=ALEXTypeGettersErrorDomain Code=2 \"Nil Object Error\" UserInfo=0x1006004e0 {NSLocalizedDescription=Nil Object Error, NSLocalizedFailureReason=Object for key 'description' is nil}",
	 "Error Domain=ALEXTypeGettersErrorDomain Code=4 \"Array Objects Not Kind Of Class Error\" UserInfo=0x1006008c0 {NSLocalizedDescription=Array Objects Not Kind Of Class Error, NSLocalizedFailureReason=Objects at indexes 0-1 are not kind of class NSNumber}"
	 )}
	 */
	
	
	// Optional keys and and -(BOOL)alex_get… methods
	NSNumber *identifier;
	NSArray *tags;
	NSString *optionalString;
	BOOL success = YES;
	NSError *getError;
	if (![JSONObject alex_getNumber:&identifier forKey:@"id" options:0 error:&getError] && success) {
		success = NO;
	}
	if (![JSONObject alex_getArrayOfStrings:&tags forKey:@"tags" options:0 error:&getError] && success) {
		success = NO;
	}
	if (![JSONObject alex_getString:&optionalString forKey:@"optional" options:ALEXTypeGetterOptionsObjectIsOptional error:&getError] && success) {
		success = NO;
	}
	
	STAssertTrue(success, @"This example should not produce errors");
	STAssertNotNil(identifier, @"identifier should have a value");
	STAssertNotNil(tags, @"tags should have a value");
	STAssertNil(optionalString, @"optionalString should be nil");
	
	if (!success) {
		NSLog(@"Error getting required and optional values: %@", getError);
	} else {
		NSLog(@"identifier: %@, tags: %@, optionalString: %@", identifier, tags, optionalString);
	}
	// will log:
	/*
	 identifier: 1, tags: (
	 	Bar,
	 	Eek
	 ), optionalString: (null)
	 */
}
@end
