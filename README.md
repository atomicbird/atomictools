# Atomic Tools

A collection of useful Objective-C code. Most of this has been blogged about at [Cocoa is my Girlfriend](http://www.cimgf.com/).

* `NSObject+setValuesForKeysWithJSONDictionary.h`: Safer alternative to `setValuesForKeysWithDictionary:` for use when importing JSON. Works with any object with declared properties corresponding to JSON dictionary keys. Detailed discussion is at [CIMGF](http://www.cimgf.com/2012/01/11/handling-incoming-json-redux/).

* `NSObject+deallocBlock.h`: Add a block to any object that will execute when that object is deallocated.

* `NSData+reallyMapped.h`: Create an NSData object using a memory mapped file. Works even though `dataWithContentsOfMappedFile:` is deprecated in iOS 5.0 and `NSDataReadingMappedAlways` doesn't always (despite the name) create memory mapped instances.
