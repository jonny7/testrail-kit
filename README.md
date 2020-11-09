# TestRailKit
![](https://img.shields.io/badge/Swift-5.3-orange.svg?style=svg) [![codecov](https://codecov.io/gh/jonny7/testrail-kit/branch/master/graph/badge.svg)](https://codecov.io/gh/jonny7/testrail-kit) ![testrail-ci](https://github.com/jonny7/testrail-kit/workflows/testrail-ci/badge.svg) ![license](https://img.shields.io/github/license/jonny7/testrail-kit) [![Maintainability](https://api.codeclimate.com/v1/badges/58d6e1a7f9f8038f92c8/maintainability)](https://codeclimate.com/github/jonny7/testrail-kit/maintainability)

## Overview

**TestRailKit** is an asynchronous pure Swift wrapper around the [TestRail API](https://www.gurock.com/testrail/docs/api), written on top of Apple's [swift-nio](https://github.com/apple/swift-nio) and [AsyncHTTPClient](https://github.com/swift-server/async-http-client). Whereas other TestRail bindings generally provide some form of minimal client to send requests. This library provides the full type safe implementation of TestRail's API. Meaning that it will automatically encode and decode models to be sent and received and all the endpoints are already built in. These models were generally created by using our own unmodified TestRail instance and seeing what endpoints returned. But you can still make your own models easily.

## Installing
Add the following entry in your Package.swift to start using TestRailKit:
```swift
.package(url: "https://github.com/jonny7/testrail-kit", from: "1.0.0-alpha.1")
```
## Getting Started
```swift
import TestRailKit

let httpClient = HTTPClient(...)
let client = TestRailClient(httpClient: httpClient, eventLoop: eventLoop, username: "your_username", apiKey: "your-key", testRailUrl: "https://my-testrail-domain", port: nil) // `use port` if you're on a non-standard port
```
This gives you access to the TestRail client now. The library has extensive tests for all the endpoints, so you can always look there for example usage. At it's heart there are two main functions:
```swift
client.action(resource: ConfigurationRepresentable, body: TestRailPostable) -> TestRailModel // for posting models to TestRail
client.action(resource: ConfigurationRepresentable) -> TestRailModel // for retrieving models from TestRail
```

`ConfigurationRepresentation`: When calling either `action` method you will need to pass the resource argument, these all follow the same naming convention of TestRail resource, eg `Case`, `Suite`, `Plan` etc + "Resource". So the previously listed models all become `CaseResource`, `SuiteResource`, `PlanResource`. Each resource, then has various other enumerated options in order to provide an abstracted type-safe API, leaving the developer to pass simple typed arguments to manage TestRail. 

For example:
```swift
let tests: EventLoopFuture<[Test]> = client.action(resource: TestResource.all(runId: 89, statusIds: [1]))).wait() // return all tests for run 89 with a status of 1
```
> _**Note**: Use of `wait()` was used here for simplicity. Never call this method on an `eventLoop`!_

## Conventions
TestRail uses Unix timestamps when working with dates. TestRailKit will encode or decode all Swift `Date` objects into UNIX timestamps automatically.
TestRail also uses `snake_case` for property names, TestRailKit automatically encodes or decodes to `camelCase` as per Swift conventions 

## Customizing
If you wish to use a model that doesn't currently exist in the library because your own TestRail is mofidied you can simply make this model conform to `TestRailModel` if decoding it from TestRail or `TestRailPostable` if you wish to post this model to TestRail.

### Partial Updates
TestRail supports partial updates, if you wish to use these, you will need to make this new object conform to `TestRailPostable`. You can see an example of this in the [tests](https://github.com/jonny7/testrail-kit/blob/master/Tests/TestRailKitTests/Utilities/Classes/SuiteUtilities.swift).  

## Vapor
For those who want to use this library with the most popular server side Swift framework Vapor, please see this [repo](https://github.com/jonny7/testrail).

## Contributing 
All help is welcomed, please open a PR 
