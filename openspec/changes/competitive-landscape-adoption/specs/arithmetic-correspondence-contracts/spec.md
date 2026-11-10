## Purpose

Turn the single fixed-value correspondence into per-operation contracts over the full domain, and state the relation between the Lean library and the pinned deployed code. Serves tasks II.2, II.3 and II.6.

## ADDED Requirements

### Requirement: Deposit correspondence SHALL hold over the full domain

The deposit operation SHALL have a theorem relating its Word-arithmetic executable and its exact-rational transition for all admissible asset amounts and rates, including rounding, fee and refusal behaviour, in the form of the native-correspondence helper used by the benchmark adapter.

#### Scenario: No literal remains

- **WHEN** the correspondence theorem is inspected
- **THEN** its statement quantifies over assets and rates and the fixed WAD instance is a corollary, not the theorem

### Requirement: Source correspondence SHALL be stated as three artifacts

The repository SHALL state the relation between the pinned token0 Solidity campaign and the Lean library as three separate artifacts: a model theorem, a differential observation record and a written refinement obligation.

#### Scenario: Token0 campaign is related to the library

- **WHEN** the pinned token0 Solidity campaign is compared with the Lean library
- **THEN** the repository holds a model theorem, a differential observation record and a written refinement obligation naming what remains unproved

### Requirement: The swap theorem SHALL be attempted without target-specific guidance

The swap case (P2, R2-SWAP) SHALL be attempted with a general tactic or an SMT bridge and no lemma written for it, and the outcome SHALL be recorded whether it passes or fails.

#### Scenario: Attempt is recorded either way

- **WHEN** the swap case (P2, R2-SWAP) is attempted with a general tactic or an SMT bridge and no lemma written for it
- **THEN** the adapter record states the outcome, pass or fail, and the guidance line count of the attempt
