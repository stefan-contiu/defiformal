## Purpose

Make DeFiFormal's results re-checkable by people outside the project. Reproduction failed for 3 of 13 assessed projects, including the two most active Lean and Rocq peers, and DeFiFormal's repository is blank on CI, release, outside reproduction and known adoption. Serves tasks I.2, I.4, I.5, I.7, III.2, III.3, III.4, III.5 and III.6.

## ADDED Requirements

### Requirement: The repository SHALL have a release, a contribution guide and a license

The repository SHALL carry a tagged release, a contribution guide and a license file.

#### Scenario: Maintenance dimension is dated

- **WHEN** the maturity rubric is applied
- **THEN** a tagged release date, a contribution guide and a license file are present

### Requirement: An outside developer SHALL reproduce the P18 package

A developer outside the project SHALL run the sprint P18 token0 package from its README, and the outcome and setup time SHALL be recorded whether it passes or fails.

#### Scenario: Reproduction is on record

- **WHEN** a developer outside the project follows the P18 token0 package README
- **THEN** a record exists with outcome, pass or fail, and setup time

### Requirement: Compiled proof modules SHALL ship as an evidence package

The package SHALL contain the compiled proof modules, checker name and version, the trusted-import list, what each check covers, checksums, and the two rational comparisons the charts cannot show.

#### Scenario: Third party re-checks from the package alone

- **WHEN** a third party receives the package and nothing else
- **THEN** they re-run the `leanchecker` pass and obtain the recorded result, and the package carries the two unplotted rational comparisons (R3 growth 1.04× against Act's 5.8×; R7 11.4 s against 45 s)

### Requirement: Setup SHALL be measured cold and cached

The dependency build SHALL be measured once from a clean machine and recorded even if it exceeds the limit, and the pinned-cache setup SHALL be documented and timed from clone to a passing replay.

#### Scenario: Both setup times are recorded

- **WHEN** the dependency build is run once from a clean machine and once from the documented pinned cache
- **THEN** both times are recorded even if the cold build exceeds the limit, and the cached clone-to-passing-replay time is under 60 s or carries a documented reason

### Requirement: Measurement records SHALL be consolidated and decomposed

The three rational-1 adapters SHALL be combined into one measurement record, and the workflow adapter's fixed cost SHALL be measured by replaying an empty case and reported separately from per-case proof time.

#### Scenario: One rational-1 record

- **WHEN** the three rational-1 adapters are combined
- **THEN** one record establishes all nine cases and coverage reads 9 of 9 on one line

#### Scenario: Fixed cost separated from proof time

- **WHEN** an empty case is replayed on the workflow adapter
- **THEN** fixed preparation cost and per-case proof time are reported as two numbers

### Requirement: Maturity SHALL be assessed under the competitor rubric

DeFiFormal SHALL be assessed under the same four-dimension maturity rubric as the competitors, producing a row with dated observations.

#### Scenario: DeFiFormal row exists

- **WHEN** the maturity assessment is run on DeFiFormal
- **THEN** a row with dated observations exists for every dimension, including corroborated adoption or its absence
