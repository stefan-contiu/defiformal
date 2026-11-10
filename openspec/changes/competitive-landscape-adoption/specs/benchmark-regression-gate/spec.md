## Purpose

Protect the benchmark position DeFiFormal measured on 2026-11-06 so that no later commit silently loses a case, slows replay, or changes a shipped proof module unnoticed. Serves tasks I.1, I.6 and III.1.

## ADDED Requirements

### Requirement: Every commit SHALL run the regression gate

The repository SHALL run, on every commit to the delivery branch, the Lean build, the axiom audit and the Suite 1.0 and rational-1 benchmark adapters, and SHALL fail the commit on a lost case, a P3 or R3 replay growth above 1.1×, a benchmark clean build over 15 s, or a changed checksum of any shipped proof module.

#### Scenario: Passing run at the pinned revision

- **WHEN** the gate runs at `2b60322cdc8c98f0e0c27cab3b2d6dcc824c3eda` with the pinned toolchain
- **THEN** it reports Suite 1.0 4 of 4, rational-1 9 of 9, P3 growth at most 1.1× and build under 15 s, and exits successfully

#### Scenario: Deliberate break is caught

- **WHEN** one benchmark theorem is replaced by `sorry` or one adapter case is removed
- **THEN** the gate exits with failure and names the lost case or the audit finding

### Requirement: Supported capability cells SHALL be CI-rebuilt artifacts

Each cell of the primitive and property matrices graded supported for DeFiFormal SHALL point to one worked example in the repository that the gate builds and checks.

#### Scenario: A supported cell is traced

- **WHEN** a reviewer picks any supported DeFiFormal cell
- **THEN** the cell names one module and one theorem that the latest gate run built and checked

### Requirement: The published benchmark row SHALL match the current release

The published DeFiFormal row of Suite 1.0 and rational-1 SHALL be regenerated on every release and SHALL name the release commit and the gate run that produced it.

#### Scenario: Release and row agree

- **WHEN** a release is tagged
- **THEN** the published DeFiFormal row of both suites carries that release's commit and the gate run that produced it
