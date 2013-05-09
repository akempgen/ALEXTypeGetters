ALEXTypeGetters
===============

Objective-C categories on NSDictionary and NSArray that give you methods like `-(NSString *)stringForKey:` in addition to `-(id)objectForKey:`. These methods do all the necessary type checks inside and return nil if the object's class does not match. They will also create meaningful errors to help you debug your code. This can save you some typing when working with NSJSONSerialization or Plist deserialization, where you have dictionaries of unknown content.

API
---
The category on NSDictionary provides these types of methods in ascending complexity whose behavior you can hopefully infer from Cocoa conventions:

	- (NSString *)alex_stringForKey:(id)key;
	- (NSArray *)alex_arrayOfStringsForKey:(id)key;
	- (NSString *)alex_stringForKey:(id)key error:(NSError **)error;
	- (NSArray *)alex_arrayOfStringsForKey:(id)key error:(NSError **)error;
	- (BOOL)alex_getString:(NSString **)string forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;
	- (BOOL)alex_getArrayOfStrings:(NSArray **)array forKey:(id)key options:(ALEXTypeGetterOptions)options error:(NSError **)error;

All method types are available for all NSJSONSerialization and all PList classes, which are: NSString, NSNumber, NSArray, NSDictionary, NSNull, NSData and NSDate as well as a generic methods like `- (id)alex_objectOfClass:(Class)objectClass forKey:(id)key error:(NSError **)error;` which work with all other classes (including your own).
The only value for ALEXTypeGetterOptions currently is `ALEXTypeGetterOptionsObjectIsOptional` which means, that a nil value will be counted as success and the method returns YES.

The category on NSArray currently has only one method:

	- (BOOL)alex_objectsAreKindOfClass:(Class)objectClass error:(NSError **)error;

The methods with an error paramter will generate meaningful NSErrors for you if you want to log or display or otherwise process them (you should!). And there is an added bonus: if you pass in the same parameter for error several times, it will collect them all into one, so you dont have to check for an error for every key! See next section for an example of this.

Examples
--------

Lets say you receive this JSON (from http://en.wikipedia.org/wiki/JSON) and have it stored in an NSData object:

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

First you do the normal JSON deserialization:

	NSError *JSONError;
	NSDictionary *JSONObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
		
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

And then you will get values from the dictionary to configure your model objects etc. Here are some examples how you would use the methods in this categories to do that:

### Simple example with no error handling:

	NSString *name = [JSONObject alex_stringForKey:@"name"];
	NSNumber *stockNumber = [JSONObject alex_numberForKey:@"stock"];
	// because stockNumber is nil instead of a dictionary the next line is safe:
	NSUInteger stockInteger = [stockNumber unsignedIntegerValue];
	NSLog(@"name: %@ stock: %lu", name, stockInteger);

output:

	name: Foo stock: 0

### Logging an Error

	NSError *tagsStringError;
	NSString *tagsString = [JSONObject alex_stringForKey:@"tags" error:&tagsStringError];
	if (tagsString == nil) {
		NSLog(@"Error getting tags from JSON:\n%@", tagsStringError);
	}
	
output: 

	Error getting tags from JSON:
	Error Domain=ALEXTypeGettersErrorDomain Code=3 "Object Not Kind Of Class Error" UserInfo=0x100150330 {NSLocalizedDescription=Object Not Kind Of Class Error, NSLocalizedFailureReason=Object for key 'tags' is not kind of class NSString}

### Combined Errors

	NSError *combinedErrors;
	NSString *idString = [JSONObject alex_stringForKey:@"id" error:&combinedErrors];
	NSNumber *price = [JSONObject alex_numberForKey:@"price" error:&combinedErrors]; // this one is fine
	NSString *description = [JSONObject alex_stringForKey:@"description" error:&combinedErrors];
	NSArray *tagsPrimaryKeys = [JSONObject alex_arrayOfNumbersForKey:@"tags" error:&combinedErrors];
	if (idString == nil || price == nil || description == nil || tagsPrimaryKeys == nil) {
		NSLog(@"Error getting some values from JSON:\n%@", combinedErrors);
	}
	
output: 

	Error getting some values from JSON:
	Error Domain=ALEXTypeGettersErrorDomain Code=1 "Multiple Errors" UserInfo=0x1006009b0 {NSLocalizedDescription=Multiple Errors, ALEXTypeGettersErrorDetailedErrorsKey=(
		"Error Domain=ALEXTypeGettersErrorDomain Code=3 \"Object Not Kind Of Class Error\" UserInfo=0x100600370 {NSLocalizedDescription=Object Not Kind Of Class Error, NSLocalizedFailureReason=Object for key 'id' is not kind of class NSString}",
		"Error Domain=ALEXTypeGettersErrorDomain Code=2 \"Nil Object Error\" UserInfo=0x1006004e0 {NSLocalizedDescription=Nil Object Error, NSLocalizedFailureReason=Object for key 'description' is nil}",
		"Error Domain=ALEXTypeGettersErrorDomain Code=4 \"Array Objects Not Kind Of Class Error\" UserInfo=0x1006008c0 {NSLocalizedDescription=Array Objects Not Kind Of Class Error, NSLocalizedFailureReason=Objects at indexes 0-1 are not kind of class NSNumber}"
	)}

### Optional keys and -(BOOL)alex_get… methods

These will all return YES:

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
	
	if (!success) {
		NSLog(@"Error getting required and optional values: %@", getError);
	} else {
		NSLog(@"identifier: %@, tags: %@, optionalString: %@", identifier, tags, optionalString);
	}

output:

	identifier: 1, tags: (
		Bar,
		Eek
	), optionalString: (null)

Status
------

The code is still work in progress, but should be good enough for some test runs. Let me know if you find problems.

License
-------

3-clause BSD license:

	Copyright © 2013, Alexander Kempgen (https://github.com/akempgen)
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:
    	* Redistributions of source code must retain the above copyright
    	  notice, this list of conditions and the following disclaimer.
    	* Redistributions in binary form must reproduce the above copyright
    	  notice, this list of conditions and the following disclaimer in the
    	  documentation and/or other materials provided with the distribution.
    	* Neither the name of the copyright holder nor the
    	  names of its contributors may be used to endorse or promote products
    	  derived from this software without specific prior written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER AND CONTRIBUTORS "AS IS" AND
	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
	DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
	ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


Version History
---------------

no releases yet