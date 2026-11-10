## Purpose

Produce the first composed financial example: two real components under one composition contract with one shared lemma, so that unit consistency and interface compatibility become demonstrated rather than available. Serves tasks I.3, II.1, II.5 and III.7.

## ADDED Requirements

### Requirement: Two financial components SHALL compose under one contract

The sUSDS deposit and the token0 quote register SHALL be composed into one workflow under one `ComponentContract` instance whose preservation theorem invokes one named financial lemma shared by both components.

#### Scenario: Composition is checked

- **WHEN** the composed workflow module is built
- **THEN** exactly one `ComponentContract` instance covers both components, one named lemma is invoked by both, dimension and refusal obligations are discharged, and the axiom audit reports no new trusted declaration

#### Scenario: Reuse is measured

- **WHEN** the second component is registered
- **THEN** the record reports its model, specification and guidance line counts, authoring effort and attribution, separately from the first

### Requirement: Per-case guidance SHALL be refactored into shared lemmas

The per-case tactic scripts SHALL be refactored into shared lemmas, starting with the swap proof, and lines and module sizes SHALL be re-measured afterwards.

#### Scenario: Swap proof shrinks without loss

- **WHEN** the per-case tactic scripts are replaced by shared lemmas
- **THEN** guidance per benchmark case is below today's 15 to 37 lines, the swap proof module is below 196 KB, and Suite 1.0 still reports 4 of 4

### Requirement: Second-instance provenance SHALL be stated

The rational-1 R8 record SHALL state whether the second vault instantiation is native to the library or goes through a trusted wrapper.

#### Scenario: R8 record names the mechanism

- **WHEN** the rational-1 R8 record is produced
- **THEN** it states whether the second vault instantiation is native to the library or goes through a trusted wrapper
