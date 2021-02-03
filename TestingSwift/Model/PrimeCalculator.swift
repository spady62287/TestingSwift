//
//  PrimeCalculator.swift
//  TestingSwift
//
//  Created by Daniel Spady on 2021-02-03.
//

import Foundation

// simple implementation of an algorithm called the Sieve of Eratosthenes, which calculates prime numbers up to a maximum number.

// 0 and 1 can't be prime by definition, so we mark those as not prime.
// loop from 2 up to the maximum of our range.
// if that number is currently marked prime, then we can mark all its multiples as not prime.

struct PrimeCalculator {
    
    static func calculate(upTo max: Int, completion: @escaping ([Int]) -> Void ) {
        // Compiler error for pushing this code to the background
        // Added a wait/expectation for the unit test
        // push our work straight to a background thread
        DispatchQueue.global().async {
            guard max > 1 else {
                // if the input value is 0 or 1 exit immediately
                return
            }
            
            // mark all our numbers as prime
            var sieve = [Bool](repeating: true, count: max)
            
            // 0 and 1 are by definition not prime
            sieve[0] = false
            sieve[1] = false
            
            // count from 0 up to the ceiling...
            for number in 2 ..< max {
                // if this is marked as prime, then every multiple of it is not prime
                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) {
                        sieve[multiple] = false
                    }
                }
            }
            
            // Collapse our results down to a single array of primes
            
            let primes = sieve.enumerated().compactMap( { $1 == true ? $0 : nil } )
            
            completion(primes)
        }
    }
    
    static func calculateStreaming(upTo max: Int, completion: @escaping (Int) -> Void) {
        DispatchQueue.global().async {
            
            guard max > 1 else {
                return
            }
            
            var sieve = [Bool](repeating: true, count: max)
            sieve[0] = false
            sieve[1] = false
            
            for number in 2 ..< max {
                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) {
                        sieve[multiple] = false
                    }
                    
                    completion(number)

                }
            }
        }
    }
    
    // Progress is a dedicated API for monitoring progress. It's useful because it is able to carry much more data about some in-flight action, such as a whether it has been cancelled or paused by the user. It also allows you to compose task progression, so you could say that task 1 is 100% complete, task 2 is 50% complete
    
    // Testing progress is done with a specific XCTestExpectation subclass called XCTestExpectation subclass called XCTNSPredicateExpectation, which lets you specify a custom test using string syntax. In our code we're going to check that the completedUnitCount of our Progress object is equal to 100, which means our expectation will automatically be fulfilled as soon as that becomes true:
    
    
    static func calculateWithProgress(upTo max: Int, completion: @escaping ([Int]) -> Void) -> Progress {
        
        // Create a Progress object that counts up to our maximum number
        let progress = Progress(totalUnitCount: Int64(max))
        
        DispatchQueue.global().async {
            guard max > 1 else {
                completion([])
                return
            }
            
            // Creates a new Array of values repeating the value of "true", based off the max value
            var sieve = [Bool](repeating: true, count: max)
            
            sieve[0] = false
            sieve[1] = false
            
            // add 2 to our progress counter, because we already went through 0 and 1
            progress.completedUnitCount += 2
            
            for number in 2 ..< max {
                // every time we've checked one number, add 1 to our completed unit count
                progress.completedUnitCount += 1
                
                if sieve[number] == true {
                    for multiple in stride(from: number * number, to: sieve.count, by: number) {
                        sieve[multiple] = false
                    }
                }
            }
            
            let primes = sieve.enumerated().compactMap( { $1 == true ? $0 : nil } )
            
            completion(primes)
        }
        
        // Send back the Progress object
        return progress
    }
    
}
