## Purpose

State the economic properties the field has only scoped proofs of (among competitors, MEV-formal's ordering safety is the only supported economic cell), as separate theorems with explicit premises, so that lending solvency and price integrity move from partial to supported at a stated scope. Serves tasks II.4 and IV.2.

## ADDED Requirements

### Requirement: Solvency, price integrity and ordering SHALL be separate theorems

Solvency, price integrity and ordering SHALL be stated as three separate theorems, each with explicit premises on the existing borrow and oracle guards.

#### Scenario: Obligations are stated with premises

- **WHEN** the economic obligations module is built
- **THEN** solvency, price integrity and ordering are three named theorems, each listing its premises on the existing borrow and oracle guards, and none is folded into another

#### Scenario: Matrix cells move

- **WHEN** the property matrix is regraded from source
- **THEN** lending solvency and price integrity read supported at the scope the premises state

### Requirement: An ordering scenario SHALL be run on the interleaving executor

One small ordering scenario SHALL be run on the interleaving executor and the invariant or gain bound it suggests SHALL be stated with its assumptions.

#### Scenario: Scenario yields a counterexample or a bound

- **WHEN** one small ordering scenario is replayed on the interleaving executor
- **THEN** the record holds either a replayed counterexample or a proven gain bound with its declared assumptions
