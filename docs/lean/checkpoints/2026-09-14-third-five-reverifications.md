# Five additional independent reverifications — complete

MI-06, MI-07, MI-26, NR-03 and RA-09: **47 exports, 2,250 exact input hashes**.

All five fresh Linux Comparator/default-kernel runs, two independent statement and proof reviews per project, and final publication checks passed. Existing proofs, metadata, canonical targets, problem IDs and historical evidence remain unchanged. These are independent re-verifications of existing formalizations. George Stepaniants retains formalization credit; original mathematical credits remain. IE-15 is untouched.

This batch used preserved authored snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`. Current upstream main was observed at the older `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`; the original mathematical targets agree across those revisions. Each audit records this provenance explicitly.

| Problem | Fresh Linux verification | Published audit |
| --- | --- | --- |
| MI-06 | [Passed](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34872712273) | [Record](https://github.com/sidneyholden1/OpenProblemsInNLA/tree/26d38e1629f04b2ba4f3d3a60455c6d624c1e8bc/docs/lean/reverification-2026-09-14/MI-06) |
| MI-07 | [Passed](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34872717807) | [Record](https://github.com/sidneyholden1/OpenProblemsInNLA/tree/5b167ea67372836f8dde9674d566ccc23916f222/docs/lean/reverification-2026-09-14/MI-07) |
| MI-26 | [Passed](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34872724754) | [Record](https://github.com/sidneyholden1/OpenProblemsInNLA/tree/eee3283eb87dc85cfe961d3a136944d40c05c586/docs/lean/reverification-2026-09-14/MI-26) |
| NR-03 | [Passed](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34872729999) | [Record](https://github.com/sidneyholden1/OpenProblemsInNLA/tree/210aa7685875ac826b78cfada8e0d722a11bafa1/docs/lean/reverification-2026-09-14/NR-03) |
| RA-09 | [Passed](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/34872737659) | [Record](https://github.com/sidneyholden1/OpenProblemsInNLA/tree/0b4af13839e9938dea35a6e63b3ea662b9084f30/docs/lean/reverification-2026-09-14/RA-09) |

NR-03 passed on the second attempt after a dependency-download failure before Lean execution. Both attempts used identical proof inputs; the failed bootstrap log is retained.

The JSON checkpoint records exact branches, tested and published commits, artifact hashes, reviewer evidence and successful final workflow links. Publication commits add evidence outside each tested project and do not claim a second proof replay.
