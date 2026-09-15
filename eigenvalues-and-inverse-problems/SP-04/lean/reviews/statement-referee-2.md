# SP-04 independent statement review — referee 2

Reviewer: OpenAI Codex agent `/root`. Verdict: **APPROVE** the exact statement bytes below, before proof implementation. This is an AI-agent review adapting the repository Tau Ceti review protocol, not external human review or endorsement.

I did not author the mathematical Definitions, Challenge, or numerical plan (drafted by `/root/new_target_screen`). I copied the unchanged draft into its isolated branch and prepared project/metadata wrappers. This review is independent of the mathematical statement author. I read the complete canonical README, full informal solution.md, numerical plan and actual Lean definitions/signatures. Original source hashes match SOURCE_PROVENANCE.json.

The feasible set includes both determinant signs via |det X|=1. Stationary is the actual matrix equation Xᵀ(U−X)=cI, not a diagonal-only proxy. UniqueLeast compares against every real stationary pair and requires both unique matrix and unique multiplier at equality, as the canonical unique-choice restriction permits. Nearest compares the explicit squared Frobenius distance with every feasible matrix; squaring preserves the order of these nonnegative norms. The constructed failures must establish the chosen pair and its uniqueness, so the conditional statement cannot be discharged vacuously.

The full parameter interval 7/4<s0<s1<s2<44/25 and endpoints 0≤c≤13/25 are retained. The negative-root theorem requires an actual unique t in (0,13/25), not merely a scalar diagnostic. Diagonality of every stationary matrix is an explicit theorem obligation. The positive-root product estimate is exact: (13/25)(44/25)(51/50)=29172/31250<1. The proposed square-root difference argument can replace derivatives without restricting the region. Its future proof must still justify all root patterns and all stationary matrices.

The family includes every left/right orthogonal transform of the diagonal region in the full real matrix space, with its genuine finite-product Euclidean topology. Openness is explicitly required in the full nine-dimensional space. The generic negation quantifies over every nonzero polynomial in all nine entries, so a merely diagonal or exceptional counterexample cannot suffice. A proper real algebraic exceptional set is contained in the zero set of some nonzero polynomial; proving failure outside every such zero set refutes the original generic rule. Dimension three is sufficient to negate the all-dimensions assertion. No finiteness assumption about stationary sets replaces existence of the counterexample's unique least choice.

I inspected the current isolated-project build log: exit zero, 8708 jobs, exactly nine intentional Challenge placeholders. The current comparator configuration lists all nine names, no replaceable definitions and only the three standard axioms. It has not been run. Metadata identifies the informal author and AI-assisted formalization author separately and retains pending proof/review status. No proof exists in this project at review time.

No substantive statement change is requested. All proofs, independent final code reviews, LeanCert trust audits and actual Linux Comparator/default-kernel controls remain pending. Changes to mathematical statement bytes reopen this review.

## Reviewed hashes

- `NLA/SP04/Definitions.lean`: `54a1ab62f1e32e1913ee87600a98fb1f942f4acf6e55f777b6be3cb25b3825d5`
- `Challenge.lean`: `99e61e62c3ea8e5911e7765850735515cca4f896c3593001215dd703585c0506`
- `NUMERICAL_TARGETS.md`: `6a32b2cc5d14e9f062e5ec09bac8471f91eb269054b9a0241d590c47b1649a63`
- `comparator.json`: `583cad865ecdc647f71544a4cdd62dd8473fb436242240c56e89ba9f00ddf6f9`
- `lakefile.toml`: `752b51f88c9dfcc5a21ca5008fcad5d615779c55f41d210ecb5806cf5ce73e0d`
- `lake-manifest.json`: `0b777416633b6ab6cecb4b739da1148251ec285a20225da94da6f72b56bddcab`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `verification/statement-current-project.log`: `1db0a5768d0ac7a7b115ea7659a9106a7b34fed6e983d4178bd42d78fcfec73d`
