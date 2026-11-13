#!/bin/bash
# Smoke test for the IndyCheck Swift package.
# Builds a throwaway executable package that depends on indycheck-swift
# and checks three known-good values. Fails (exit 1) on any mismatch.
#
# Usage:
#   smoke-test.sh '<SwiftPM package dependency spec line>'
# Examples:
#   smoke-test.sh '.package(url: "https://github.com/dusmamud/indycheck-swift", branch: "main")'
#   smoke-test.sh '.package(url: "https://github.com/dusmamud/indycheck-swift", exact: "0.2.3")'
set -euo pipefail

DEP_SPEC="$1"
WORKDIR="$(mktemp -d)/indycheck-smoke"
mkdir -p "$WORKDIR/Sources/smoke"

cat > "$WORKDIR/Package.swift" <<EOF
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "smoke",
    platforms: [.macOS(.v11)],
    dependencies: [
        $DEP_SPEC
    ],
    targets: [
        .executableTarget(
            name: "smoke",
            dependencies: [.product(name: "IndyCheck", package: "indycheck-swift")]
        )
    ]
)
EOF

cat > "$WORKDIR/Sources/smoke/main.swift" <<'SWIFTEOF'
import IndyCheck

func check(_ label: String, _ condition: Bool, _ detail: String) {
    if condition {
        print("PASS: \(label) (\(detail))")
    } else {
        print("FAIL: \(label) (\(detail))")
        exit(1)
    }
}

let pan = validatePan(input: "ABCDE1234F")
check("validatePan ABCDE1234F is valid", pan.valid, "code=\(pan.code)")
check("validatePan code is VALID", pan.code == "VALID", "code=\(pan.code)")

let vehicle = validateVehicle(input: "22BH1234AA")
check("validateVehicle 22BH1234AA is valid", vehicle.valid, "code=\(vehicle.code)")
check("validateVehicle code is VALID", vehicle.code == "VALID", "code=\(vehicle.code)")

let detected = detect(input: "dus@okaxis")
check("detect dus@okaxis is upi", detected == "upi", "detected=\(detected)")

print("SMOKE OK: all checks passed")
SWIFTEOF

cd "$WORKDIR"
swift build
swift run
