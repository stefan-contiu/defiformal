# Competitive landscape adoption tasks (after independent planning review)

All boxes stay unchecked in this planning freeze. Do not start Lean, CI configuration or adapter work until independent review accepts this slice. The 24 tasks are those of section 4.2 of the report, verbatim. Each line carries the task, then in brackets its kind (better product, trusted by others, better measurement) and what it serves (gap D1 to D5 and report sections), and ends with the report's completion criterion as the verify clause.

## 1. Planning gate

- [ ] 1.1 Obtain independent review of this exact `competitive-landscape-adoption` candidate under the reviewer bindings in `AGENTS.md`, record verdict, requested and reported model identity and input hashes, and verify no box in this file is ticked before acceptance.
- [ ] 1.2 Decide whether the IOG Suite 1.0 and rational-1 adapters are contributed as a separate change, and verify tasks I.1, III.1, III.5 and III.6 are blocked, not skipped, until that decision is recorded.

## 2. Phase I: operational, no dependencies

- [ ] I.1 Add CI that runs the build, the axiom audit and the benchmark adapter on every commit, and fails on a lost case, a P3 or R3 replay growth above 1.1×, a benchmark clean build over 15 s, or a changed proof-module checksum. [better measurement; D5; 2.1, 2.3, 2.6, 2.8] Verify a passing run is visible at the current revision and the gate has been seen to fail on a deliberate break.
- [ ] I.2 Cut a first tagged release, and add a contribution guide and a license file. [trusted by others; D5; 3.1] Verify a release date in the maintenance column; both files in the repository.
- [ ] I.3 Start per-component accounting of model, specification and guidance lines, of authoring effort, and of attribution (AI-authored or human). [better measurement; D1; 2.7] Verify the vault deposit and the token0 register each report their counts and effort.
- [ ] I.4 Have an outside developer run the DeFiFormal sprint P18 token0 package from its README and record the outcome and setup time. [trusted by others; D5; 3.1] Verify a reproduction record by someone outside the project exists, pass or fail, with its setup time.
- [ ] I.5 Assign one owner for the benchmark run, the evidence package, the pinned cache and CI. [trusted by others; D5] Verify a name is on the roadmap.
- [ ] I.6 Turn each supported cell of 1.1 and 1.2 into a pinned, reproduced artifact: one worked example per cell, built and checked in CI. [trusted by others; D5; 1.1, 1.2, 3.2.2] Verify every supported DeFiFormal cell points to an artifact that CI rebuilds.
- [ ] I.7 Run the maturity assessment on DeFiFormal under the same rubric as the competitors. [better measurement; 3.1] Verify a DeFiFormal row in 3.1 with dated observations rather than a repository read.

## 3. Phase II: the first composed example

- [ ] II.1 Compose the sUSDS deposit and the token0 quote register into one workflow under one `ComponentContract` that invokes one shared financial lemma; report the second instance's lines. [better product; D1] Verify one contract instance, one named lemma invoked by both, units and refusal checked, counts reported. (No tool has a supported unit-consistency or interface-compatibility cell, 1.2.)
- [ ] II.2 Extend the deposit correspondence from the fixed WAD case to the full domain, using the native-correspondence helper of the benchmark adapter as the template for per-operation arithmetic contracts. [better product; D2; 2.7] Verify a theorem over all admissible assets and rates, not one literal. (Every benchmark result in the field is on a new model, 2.8.)
- [ ] II.3 Write the simulation relation between the pinned token0 Solidity campaign and the Lean library, and state the remaining obligation. [better product; D3] Verify three artifacts exist: model theorem, differential observations, refinement obligation.
- [ ] II.4 State solvency, price-integrity and ordering obligations as separate theorems with explicit premises on the existing borrow and oracle guards. [better product; D4; 1.2] Verify lending solvency and price integrity cells in 1.2 move from partial to supported at a stated scope.
- [ ] II.5 Refactor the per-case tactic scripts into shared lemmas, starting with the 37-line swap proof, and re-measure lines and module sizes. [better product; D1; 2.1, 2.7, 2.8] Verify guidance per case below today's 15 to 37 lines and the swap module below 196 KB, with 4 of 4 coverage kept.
- [ ] II.6 Attempt the swap theorem (P2, R2-SWAP) with a general tactic or an SMT bridge and no target-specific lemma; record the outcome either way. [better product; 2.1, 2.2] Verify the attempt is in the adapter record, pass or fail. (Only Act and CFF prove the swap without guidance.)

## 4. Phase III: measure against the field

- [ ] III.1 Keep the Suite 1.0 and rational-1 adapters running on every release and publish the updated DeFiFormal row. [better measurement; D1; 2.1] Verify the row in 2.1 matches the current release. (Both suites were first run on 2026-11-06.)
- [ ] III.2 Ship the compiled proof modules as the evidence package: checker name and version, trusted-import list, what each check covers, checksums, and the two rational comparisons the charts cannot show (R3 growth 1.04× against Act's 5.8×; R7 11.4 s against 45 s). [trusted by others; D5; 2.4, 2.5, 2.8] Verify a third party re-runs the leanchecker pass from the package alone.
- [ ] III.3 Measure the cold dependency build once from a clean machine and record it even if it exceeds the limit; then document the pinned-cache setup and time it from clone to a passing replay. [trusted by others; D5; 2.6] Verify both numbers recorded; the cached setup under 60 s, or a documented reason it is not.
- [ ] III.4 Ship an evidence package with the composed example and with every later integration, and record adoption only when it is corroborated. [trusted by others; D5; 3.1] Verify each shipped integration carries its package; the adoption column of 3.1 shows corroborated use.
- [ ] III.5 Combine the three rational-1 adapters into one measurement record that establishes all nine cases. [better measurement; 2.2] Verify DeFiFormal's coverage reads 9 of 9 on one line in 2.2, as Act's does.
- [ ] III.6 Measure the fixed cost of the workflow adapter by replaying an empty case; if most of the 10 to 14 s is import elaboration, record it as preparation and report per-case proof time separately. [better measurement; 2.4, 2.6] Verify fixed cost and per-case proof time reported as two numbers.
- [ ] III.7 State in the R8 record whether the second-vault instantiation is native or goes through a trusted wrapper. [trusted by others; 2.2] Verify the record says which. (Act's and Certora's R8 rely on a trusted wrapper.)

## 5. Phase IV: widen the financial scope

- [ ] IV.1 Add an AMM swap operation with reserve accounting, specify it in both arithmetics with fees and refusal, and re-run R2 on the library instead of the benchmark model. [better product; D2; 1.1, 1.2, 2.2] Verify AMM conservation and no-arbitrage cells in 1.2 move from unknown; R2 is proved on the kernel.
- [ ] IV.2 Run one small ordering scenario on the interleaving executor and state the invariant or gain bound it suggests. [better product; D4] Verify a replayed counterexample or a proven bound with declared assumptions.
- [ ] IV.3 Model liquidation with solvency and correctness stated as separate theorems, when DeFiFormal sprint P27 opens. [better product; D4; 1.1, 1.2] Verify liquidation cells in 1.1 and 1.2 move from unknown.
- [ ] IV.4 Extend lending beyond borrow: repay, interest accrual, collateral deposit and withdrawal. [better product; D2; 1.1] Verify the lending cell in 1.1 moves from partial to supported. (Lending is supported by 2 competitors.)

## 6. Review and remainders

- [ ] 6.1 Reconcile every delta-spec scenario to proof, finite, mutation, measurement or assumption evidence, and verify no scenario is credited from a declaration alone.
- [ ] 6.2 Leave replay speed, deployed-code equivalence, a complete adversary model and corroborated adoption named as remainders, and verify none is claimed by this change.
