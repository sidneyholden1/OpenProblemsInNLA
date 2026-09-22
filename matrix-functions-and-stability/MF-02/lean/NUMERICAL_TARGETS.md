# MF-02 full numerical and mathematical contract before proof

Read complete canonical README and source solution.md, Theorem and Sections2–5,
at83a1a1407d1427dbda6d968a9047b17f2071c229. The target is uniform constant-factor
asymptotic order, not exact stage count, optimal leading constant or same-budget
error optimality. All m∈ℕ and all real0<δ<1, including gaps depending on m.

1. RegisterRun begins with1,x. Each counted operation multiplies two arbitrary
free real linear combinations of all earlier stored polynomials, adds its
product, and retains all previous registers. Output is any free combination;
computable uses at most m operations. Optional counted scalar products do not
change the class since scalar multiplication is already free. Stored reuse is
allowed. Prove degree≤2^m for every such actual program.
2. Error is the actual maximum of |p(x)-sign(x)| on[-1,-δ]∪[δ,1]. Explicitly
prove its defining set nonempty, bounded above and attaining its supremum.
The conditional sign value at0 is immaterial because0 is outside this domain.
Program and cubic error infima must be nonempty and bounded below; no assumed
attainment of their minimizing coefficients is allowed.
3. For every polynomial of degree≤D, D≥1, prove error≥r^D where
r=(1-δ)/(1+δ)∈(0,1). Reuse Mathlib Chebyshev extremality and prove the odd-part,
even-square substitution and transformed-interval bridges. Do not posit them.
4. Cubic coefficient lists have exactlyT pairs, execution order q1 thenq2 etc;
empty composition isx. Prove actual cubic errors≥r^(3^T), and≤r^(2^T) forT≥1,
with strictly decreasing errors for allT. Construct the source optimized cubic
and final output scaling within the last stage. Exact polynomial identity
27(1+a)^2(1+a²)^2-16(1+a+a²)^3=(1-a)^2(11a⁴+28a³+30a²+28a+11)
replaces interval search. Handle unattained coefficient infima rigorously.
5. Every actualT-stage cubic composition is an actual register computation
with at most2T products; no output-scaling multiplication is charged.
6. The feasible stage set is nonempty for allm,δ. Its natural infimum is a
member and below every feasible stage. This establishes equivalence to the
canonical extended-natural infimum, whose empty-set value would be+∞.
7. Prove T_min(0,δ)=T_min(1,δ)=1; for m≥2 prove floor(m/2)≤T_min≤m; for allm
prove (m+1)/4≤T_min≤m+1, with constants independent ofδ. These are the full
original uniform asymptotic target. No sampled gaps or budget caps.

Two independent statement approvals precede proof bodies. Two nonauthor final
reviews follow full proof. Use LeanCert kernel trust and actual isolated Linux
Comparator/default-kernel/rejection controls for all seven exports, no custom
axioms or replaceable definition holes. Preserve source/prior-work attribution
and a truthful official formalization.yaml. No source/canonical promotion now.
