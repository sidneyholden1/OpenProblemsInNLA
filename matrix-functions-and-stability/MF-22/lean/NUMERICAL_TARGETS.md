# MF-22 complete numerical and asymptotic contracts

Source: George Stepaniants, *MF-22: An eventual linear condition-number bound*, complete solution.md and solution.tex, Sections 1–4. The coefficient family and original question retain credit to Bogoya, Böttcher, Ferrari, Grudsky and Serra-Capizzano. Source AI assistance and independent automated review are disclosed, without human-review or author-endorsement claims.

## Exact objects and public statements

`Ix n = Fin n × Fin 2` indexes exactly 2n complex coordinates, ordered as the original (u₀,v₀,…,uₙ₋₁,vₙ₋₁); (j,a) corresponds to flat index 2j+a. Both matrix norms use `Matrix.Norms.L2Operator`, the induced Euclidean norm. `H ρ n` uses precisely lag j−k, all eight displayed rational B/C blocks, and zero outside lags −1,0,1,2. There are no corner corrections. The inverse is Mathlib's actual matrix inverse. The extended condition number is infinity when det H=0 and otherwise ofReal(‖H‖₂‖H⁻¹‖₂).

Four Challenge exports, with no root, transfer, invertibility or growth assumptions beyond ρ>0:

1. `uniform_norm_bound`: for every fixed real ρ>0, there is D>0 such that every n≥1 satisfies ‖Hₙ(ρ)‖₂≤D.
2. `eventual_inverse_entry_bound`: there are C>0 and N≥1, depending only on ρ, such that every n≥N has det Hₙ≠0 and every entry of the actual inverse has complex modulus ≤C.
3. `linear_condition_bound`: there are K>0 and N≥1 such that every n≥N has det Hₙ≠0 and ‖Hₙ‖₂‖Hₙ⁻¹‖₂≤K n.
4. `original_target`: there are K>0, real α≥0, and N≥1 such that the actual extended condition number is ≤ofReal(K n^α) for every n≥N. The intended derivation chooses α=1 from the stronger preceding theorem. Thus singularity cannot make the product artificially vanish under totalized inversion.

All positive real parameters, including ρ=√10, are retained. Constants and the threshold are chosen before the universally quantified dimension. Every sufficiently large integer size is covered, not a subsequence. No uniform-in-ρ constant or assertion about finitely many small sizes is promised.

## Exact scalar obligations to prove after the statement gate

Write r=ρ and M=80H. Set A=−r−6i, B=−7r−30i, C=7r−30i, D=−25r−30i, E=r−6i, F=25r−30i. The literal rows of M are

- A u[j+1]−24r u[j]+F u[j−1]+B v[j]+96i v[j−1]+C v[j−2];
- B u[j+1]+96i u[j]+C u[j−1]+D v[j]+24r v[j−1]+E v[j−2].

The only boundary zeros are u[−1]=v[−1]=v[−2]=0 and u[n]=0; no v[n] condition is added. Let a=30−r²−10ir and L=[[A,B],[B,D]]. Prove det L=24a≠0. Derive the exact four-state recurrence with state (u[j],v[j−1],u[j−1],v[j−2]), transfer top block L⁻¹[[24r,−96i,−F,−C],[−96i,−24r,−C,−E]], bottom shift rows, forcing top block L⁻¹ and zero bottom rows.

With b=24r²+80ir−240 and c=420−46r², the denominator is d(z)=a+bz+cz²+conj(b)z³+conj(a)z⁴ and numerator N(z)=a+(−120−r²+22ir)z+2(r²+18)z². Their lack of common roots is to be derived, not assumed. Exact elimination uses resultant real part 2177280+946944r²>0 and the polynomial combination 70R(y)+867I(y)=−79939224−32957424y<0 for y=r²≥0.

The characteristic quartic is p(t)=at⁴+bt³+ct²+conj(b)t+conj(a). Its factor (t−1) has q(1)=120ir≠0. The Cayley cubic is 6(r²−10)x³+25rx²+5(r²−6)x+15r, with discriminant −25r⁴(120r⁴−3337r²+34200)−5269500r²−6480000<0. The inner quadratic discriminant is −5280431. At r²=10 the reduced quadratic discriminant is −14600 and the missing simple root is t=−1, q′(−1)=−100ir≠0. The excluded Cayley points satisfy R(−i)=−ia and R(i)=i conj(a), not the erroneous conjugate-only formula in an earlier source draft.

## Planned exact proof route and outstanding bridges

Derive four distinct nonzero roots (one outside, one inside, two on the circle) by complex cubic roots/conjugation and the exceptional quadratic case. Use direct finite determinant/adjugate polynomial identities instead of analytic generating functions. Then derive the expanding rank-one spectral projector Π, nonzero boundary coupling γ=Π₀₀, and T^j=λ^jΠ+Rⱼ with a bounded remainder from finite spectral decomposition. These are substantial proof obligations, never public hypotheses.

The terminal boundary denominator (T^n)₀₀=γλ^n+bounded remainder is eventually nonzero. Construct the actual finite Green operator, prove the exponential terms cancel using Π e eᵀ Π=γΠ, bound every inverse entry uniformly, and recover all coordinates including v[n−1] from state n. A 2n-dimensional entry bound gives a linear spectral inverse bound. Fixed band shifts give the uniform forward norm bound. Exact scaling by 80 preserves the condition number. No finite grid, fixed parameter sample or interval search substitutes for these all-parameter/all-size arguments.

Mathlib reuse planned: actual nonsingular inverse and determinant, finite-dimensional operator L2 norms, polynomial/Cubic roots and discriminants, matrix characteristic polynomial and spectral polynomial decomposition, finite sums, geometric decay. LeanCert audits the actual kernel proof closure; interval computation is unnecessary for the polynomial identities and inequalities. Existing MF12/IE13 project organization and dependency pins are reused with credit, not their mathematical results.

`verification/source_exact_check.py` reruns the retained independent source Gaussian-integer polynomial checker with output/source paths adapted and attribution retained. Its 31 exact identities are transcription diagnostics only. No proof bodies exist at the statement-review stage.
