# IndyCheck for Swift

Offline validation of Indian IDs — PAN, Aadhaar, GSTIN, IFSC, UPI, mobile,
PIN code, TAN, CIN, LLPIN, Voter ID, and vehicle numbers — as a Swift
Package. The validators run entirely on-device through a prebuilt
XCFramework built from the Rust core in
[dusmamud/indycheck](https://github.com/dusmamud/indycheck) (UniFFI bindings,
no network calls).

## Requirements

- iOS 13+ / macOS 11+
- Xcode 15+ (Swift 5.9+)

## Install

### Xcode

1. In Xcode: **File → Add Package Dependencies…**
2. Paste `https://github.com/dusmamud/indycheck-swift`
3. Pick version **0.2.4** (Dependency Rule: Up to Next Major Version).

### SwiftPM (`Package.swift`)

```swift
dependencies: [
    .package(url: "https://github.com/dusmamud/indycheck-swift", from: "0.2.4")
]
```

then add `"IndyCheck"` to your target's dependencies.

## Usage

```swift
import IndyCheck

let pan = validatePan(input: "ABCDE1234F")
print(pan.valid, pan.code)          // true, "VALID"

let vehicle = validateVehicle(input: "22BH1234AA")
print(vehicle.valid, vehicle.code)  // true, "VALID" (Bharat series)

let kind = detect(input: "dus@okaxis")
print(kind)                         // "upi"

let results = validateMany(inputs: ["ABCDE1234F", "not-an-id"])
for r in results {
    print(r.valid, r.code, r.reasonEn)
}
```

Every validator returns a `ValidationResult`:

```swift
public struct ValidationResult {
    public var valid: Bool
    public var code: String       // e.g. "VALID", or an error code
    public var reasonEn: String   // human-readable reason (English)
    public var reasonHi: String   // human-readable reason (Hindi)
    public var parsed: String?    // parsed components as a JSON string, or nil
}
```

Available functions: `detect`, `validatePan`, `validateAadhaar`,
`validateGstin`, `validateIfsc`, `validateUpi`, `validateMobile`,
`validatePincode`, `validateVehicle`, `validateTan`, `validateCin`,
`validateLlpin`, `validateVoterId`, `validateMany`.

## Status — please read

- **Format + checksum validation only.** This checks that an ID is
  well-formed (structure, check digits). It is **not** KYC, identity
  verification, or a check against any government database.
- **iOS simulator is arm64-only.** The XCFramework ships `ios-arm64`,
  `ios-arm64-simulator` (arm64), and a universal `macos-arm64_x86_64`
  slice. Running the simulator on an Intel Mac is not supported.
- **Smoke-tested only.** There is no full Swift test suite yet; CI builds
  a throwaway package depending on this repo and checks
  `validatePan("ABCDE1234F")`, `validateVehicle("22BH1234AA")`, and
  `detect("dus@okaxis")`. See `.github/workflows/verify.yml`.
- The underlying Rust core, full docs, and the other language bindings live
  in [dusmamud/indycheck](https://github.com/dusmamud/indycheck).

## License

Same license as the core project — see
[dusmamud/indycheck](https://github.com/dusmamud/indycheck/blob/main/LICENSE).

## Author

dusmamud
