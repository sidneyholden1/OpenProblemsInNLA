# NR-03 — independent proof referee 2

**PASS — proof source, full frozen-target fidelity and independent local export consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, an independent AI agent, 2026-09-14. This review applies the local Tau Ceti adaptation in `docs/lean/REVIEW.md` across correctness, fidelity, degeneracies, computation reduction, API reuse and attribution. It is not an official Tau Ceti review. The two statement reviews were approved before this campaign's proof inspection. No mathematical source or metadata was edited by this referee.

The reviewed implementation is the preserved published snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not the observed current upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. This is an independent reverification of George Stepaniants's existing AI-assisted formalization, not a claim of new authorship. Source mathematical credit is Sidney Holden (the full n=7 counterexample), with the credits and Apache-2.0 notices retained. Canonical/full informal sources were read in the hash-bound statement review and remain unchanged at the frozen gate.

## Proof inspection and target coverage

The ten exports establish nonnegativity of the actual Boolean-indexed squared matrix, its order 128 at n=7, existence and attained minimality of genuine nonnegative rank, the generic factorization upper bound and scaled-certificate bridge, and the concrete scaled certificate, real factorization, rank ≤127, strict failure of full rank, and negation of the original all-n≥3 target. The theorem does not claim the exact minimum rank is 127. Its real matrix product equality covers every pair of Boolean vectors, not merely a sampled or restricted support.

The complete active closure contains 48 generated literal row modules plus ten structural modules. I read the structural arguments in full and checked every byte of all 48 row files against the fully reviewed literal template, including predecessor imports, all 384 consecutive row declarations and their proofs. Each row proves its family identity for every second index in Fin 128 using decide +kernel; all 128 first indices in each of Singleton, Pair and Four are consumed by FamilyIdentities. referee-2-row-coverage.json records the exhaustive check. The complementary 64-column contribution is reduced structurally to its unique representative using mask complementation and the closed bit identity. This avoids redundant full products in the large row reductions. The remaining closed arithmetic covers every possible cardinality/dot count with t≤s; those hypotheses are proved for the actual mask values.

The encoding proves maskVector(maskOfVector a)=a for every Boolean vector and the exact natural/real dot bridge, so all real-indexed matrix entries follow from the finite mask certificates. Index splitting is exactly 127=64+7+21+35. All column denominators are proved positive; common positive scales are canceled only after nonzero justification. The piecewise natural square handles both sides of the subtraction and is proved equal to the real square, avoiding truncated natural subtraction. Natural W,V coefficients give actual real nonnegativity. Nat.find is used only after proving a factorization exists and is accompanied by attained minimality and the upper-bound theorem.

This is exact kernel computation and algebra. LeanCert is used for transitive kernel trust audits, not an artificial interval estimate. The source mathematical construction is Sidney Holden's n=7 counterexample, and the preserved formalization is George Stepaniants's. Generated comments saying verification was awaited are historical scaffolding, not assumptions or proof holes; current evidence is reported separately. The independent full source/certificate fidelity checks from the approved statement report remain applicable.

## Fresh evidence and limitations

I independently inspected the entire active local dependency closure (58 files, 4513 lines), excluding duplicated historical snapshots, and compared every active file byte-for-byte with the preserved Git source. Every file in `statement-gate.json` was rehashed unchanged. The coordinator's fresh `lake build Solution` receipt records exit 0 and its retained log hash matches; this full build was run by the coordinator, not by this referee. I then ran my own fresh import consumer using the pinned macOS aarch64 Lean 4.33.1 runtime. It queries the actual type, prints transitive axioms and executes `#assert_trust kernel` for every one of the 10 comparator exports below. Consumer exit is 0; every export has exactly `propext`, `Classical.choice`, `Quot.sound`, with no holes, native reduction axioms or custom axioms. The actual printed types were compared with the approved Challenge signatures and source route. These checks do not replace isolated Linux Comparator statement equality or its sandbox/rejection controls; that remains a separate gate, and no historical Linux PASS is substituted here.

The relevant actual Mathlib definitions and semantics (PSD/MatrixOrder, CFC, norms, spectrum, finite indices and rank where applicable) were inspected in this review and the linked statement review. CFC square-root uniqueness requires the supplied positive square identity; real powers require the supplied nonnegative matrix and nonzero positive indices. For projects using numerical point certificates, LeanCert's checked dyadic theorem derives domain validity and enclosure soundness before strict comparison; the printed Boolean evidence is kernel reduction, not a numerical oracle. This dependency inspection is targeted semantic review, not line-by-line reauditing all of Mathlib or LeanCert. Trust closure and the later Comparator provide separate mechanical coverage.

### Export inventory

- `NLA.NR03.cMatrix_nonnegative` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.NR03.boolVec_seven_card` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.NR03.nonnegative_rank_attained_minimal` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.NR03.rank_le_of_factorization` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.NR03.scaled_certificate_gives_factorization` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.NR03.witness_scaled_certificate` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.NR03.witness_factorization` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.NR03.witness_rank_upper_bound` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.NR03.witness_not_full_rank` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.NR03.not_targetStatement` — actual type queried, standard-three axiom closure, kernel trust PASS.

### Exact source binding

`referee-2-active-inputs.json` SHA-256: `6ca85d955866e513e520e4c1825bc8f118b23a7643e5b54983961ea75301fbb0`. This manifest contains the exact active file paths, byte sizes, line counts and all individual SHA-256 values listed below. `referee-2-proof-checks.json` binds the consumer scripts/logs, fresh coordinator receipt/log, frozen gate and any numerical/row evidence by hash.

| Active module | SHA-256 |
| --- | --- |
| `Solution` | `4a0ae10fcd53d4a894a7e72b9d39c4fad8da1e814428b9df16648d85abb9ddb1` |
| `NLA.NR03.Rank` | `1eafa31999df79f099079c00df9fb794321e6af97e98048dfb36171e4c7fda4e` |
| `NLA.NR03.Certificate` | `05cd28513d8e2e7285f1e2039db944cd8beffface3c72df7fc4079555e624fdc` |
| `NLA.NR03.CertificateBridge` | `96e7f3d3611fd91b06080cf1d096cb6b9df8b73b69786c7599f703c496ebcc2b` |
| `NLA.NR03.Index` | `c404d36ba7ce9888f5bf31ac959ccc78be2a380d628b83972f6c8940cb709370` |
| `NLA.NR03.FamilyDefs` | `1e01f68f20dafa07be2e2a3beca832f0a3925b90a0e1fcc496d087082bdf9415` |
| `NLA.NR03.Encoding` | `4408496c44153ff61a6ca89f87a243d2bbb908c1ef9e20bf2384720a44391657` |
| `NLA.NR03.Definitions` | `5157fd499d2f63d218012f96bee43f30e5f57e5a2353fde13878af46d30fda04` |
| `NLA.NR03.FamilyIdentities` | `9772ad9df0c7e2953a28a415b35d3b831332f309ed6cea5b94861be9f9f04dfa` |
| `NLA.NR03.Core` | `1e61cc3df229557d8d12e4c3608d15007a89b786f5270da2985fd5a84aed7ea5` |
| `NLA.NR03.RowCertificate.Four.Block15` | `fd0f46cc382069bc780c4a8d3fd1a1b7902860ca0b55b2efaebffdd2dd0ce862` |
| `NLA.NR03.RowCertificate.Four.Block14` | `42d4cc2ed30b60631a2835e7fe6ae30eeda8c385c5c459d11eeb7975c4deced4` |
| `NLA.NR03.RowCertificate.Four.Block13` | `6258b117a10dc3a73f736ff206a71de1e5f1acd742c5689ef60b3f5b87f6af01` |
| `NLA.NR03.RowCertificate.Four.Block12` | `e0cff5ab40f32edda9389b25e63a2401659eaca2067485a7c2fddf72c677fb7f` |
| `NLA.NR03.RowCertificate.Four.Block11` | `625aff3fd3d278a8292a8472ededc751793f72a779b0f38a4bfedc136f3a04cd` |
| `NLA.NR03.RowCertificate.Four.Block10` | `65e445c3e879079d686ac8cc01c61af9bca0534f059dbf41a47495e7e8eab1f1` |
| `NLA.NR03.RowCertificate.Four.Block09` | `f4c421e0082bf84ea1c4eada8b6c56340f9a260ee01b61fc2b380a7ed3c11ace` |
| `NLA.NR03.RowCertificate.Four.Block08` | `6c2436cae31570c2e76f362dbdfc53a9649d64f9ff5ef53d45a617eaa584bbcb` |
| `NLA.NR03.RowCertificate.Four.Block07` | `358a86b85ceeba6db3ca10834c0b77bcdaf7f5164312090ca2a6a007da2917a5` |
| `NLA.NR03.RowCertificate.Four.Block06` | `bbf486b448a4c3d738e7237f6ff9474352f2886fedf61c151710396012336d69` |
| `NLA.NR03.RowCertificate.Four.Block05` | `f1f5fabbe981666d5318c61aee881f2cc4ae04fb80eab7b26b76fbbce55e1bfd` |
| `NLA.NR03.RowCertificate.Four.Block04` | `4d63a0ad31b2f577b8d1ca04ab632e0b0c9605373fa4cd97a05f60a0080aabee` |
| `NLA.NR03.RowCertificate.Four.Block03` | `6cdcbc3b790dc1184ffc3892c1911fd633d1c710085bbdb80a17833f9fcb8d08` |
| `NLA.NR03.RowCertificate.Four.Block02` | `ac881c24bc2731c5681c2e171d08c2d9653c88fcdb11b2d14eb80fcac07bd6fc` |
| `NLA.NR03.RowCertificate.Four.Block01` | `a485ca8012cef2a0f1805405456c1f5833a239af8ac087c6ea4161e26d781368` |
| `NLA.NR03.RowCertificate.Four.Block00` | `a43707705632f40f408440e3fd1bee24c27cf4c3401a51388ac36a0ee042f5bc` |
| `NLA.NR03.RowCertificate.Pair.Block15` | `ed4f0f3125528d843621ee6b127996702ddd146400a4423948eed0629f70ddc1` |
| `NLA.NR03.RowCertificate.Pair.Block14` | `3c6258955331769cbe18a0c75656c4d84e7ad04dea9ac477fd1551ab8e342ad7` |
| `NLA.NR03.RowCertificate.Pair.Block13` | `3bcaae822d8c2e06324fb5904253e0c693c5dd13fea55fc1283bfaeb8fa859cd` |
| `NLA.NR03.RowCertificate.Pair.Block12` | `ea32035cdd452eee117dd9b19d76448878504e618898ec4c197d3af00276dd4f` |
| `NLA.NR03.RowCertificate.Pair.Block11` | `2e6da70b667a7bacbdd768bb90eef82633c26e1c066308d3fba0332e40cf457b` |
| `NLA.NR03.RowCertificate.Pair.Block10` | `3b43ca67c12597b6e9340028df7c6235278ba90f571121d05f53a5a8915ae2c1` |
| `NLA.NR03.RowCertificate.Pair.Block09` | `0334d8faa53ae47388cdc90c0f090dce265ffa1242c01fc0e29be10d187c3612` |
| `NLA.NR03.RowCertificate.Pair.Block08` | `2fd52c986852f1d8d457d19c0e89b63600c4b86e66d9f3a20592b75050ac577f` |
| `NLA.NR03.RowCertificate.Pair.Block07` | `69aaba7da3f6f2e747b72c345a5b62c41a36f82ec20983e31e183860657f4a55` |
| `NLA.NR03.RowCertificate.Pair.Block06` | `149b3c3d82f0eb02f04140e39d3167d24d9e7e3f3ebef4e42f5daa0bb9134a1d` |
| `NLA.NR03.RowCertificate.Pair.Block05` | `7cffa3bc8c74278da598a7695b9f3fd96e3f847a50d5b6e7bf0fc418b6cdeb51` |
| `NLA.NR03.RowCertificate.Pair.Block04` | `743c60c863391b3e0f253ffe5de3194988fa121fb258ed63b4f5a70d86f30655` |
| `NLA.NR03.RowCertificate.Pair.Block03` | `d95e7bb8709d5f000bb61a92074cf9160cea53a1f2894e7e491c5df384730b4d` |
| `NLA.NR03.RowCertificate.Pair.Block02` | `1d5247c1ca46504ecd7ab585a12bcbdbfa347ca60c242d057fd47e1643fb6b4e` |
| `NLA.NR03.RowCertificate.Pair.Block01` | `cf858d4232535d02fb4d162e64816d832a910869250656da9b3ba0c4750aab2d` |
| `NLA.NR03.RowCertificate.Pair.Block00` | `b79f22173a1dedf9478561976b34de2551b01e9e76afa3d43c34269d03937993` |
| `NLA.NR03.RowCertificate.Singleton.Block15` | `bb417e14367b068e28174b3a2869a47a0945f4833b439c1215b74604adfa6944` |
| `NLA.NR03.RowCertificate.Singleton.Block14` | `8f1a93acca83c5a2a9f9ecff3b1697ba80288a969ea34eb7136f2f9ece93013e` |
| `NLA.NR03.RowCertificate.Singleton.Block13` | `9dc6961bc34f0496eb65403888d4e342f1c20d0398100cbe7a5210509ffbf618` |
| `NLA.NR03.RowCertificate.Singleton.Block12` | `711dc5ebfed0c4c8ae5600fd659d943768fa106115e239f9f397cde23dcc145b` |
| `NLA.NR03.RowCertificate.Singleton.Block11` | `6ccfa9ce029fe61deb72c2198b9646ba298efc42a56de1158f37e45acf569764` |
| `NLA.NR03.RowCertificate.Singleton.Block10` | `4332d0f3e70b34bcc047ae7e78537627bab6fddcb2180b6c793ac0931c36cc07` |
| `NLA.NR03.RowCertificate.Singleton.Block09` | `797f23a6d42e101dee622acd3a7df0b35c21e0e7b7a796de51765e8c97e3761e` |
| `NLA.NR03.RowCertificate.Singleton.Block08` | `47a1c810bf1088f4f364ebfd75a9090f1550a32efcc350f4fe58ed206b9d24c6` |
| `NLA.NR03.RowCertificate.Singleton.Block07` | `af55aa164e07c06050fb1862f92b0e6a23f950e9a6e33ae5a8680c8dc245621d` |
| `NLA.NR03.RowCertificate.Singleton.Block06` | `dbea7d8edfe49408c6442cb1f7c536ee0e4d86391be78aeb86d32a52621585c4` |
| `NLA.NR03.RowCertificate.Singleton.Block05` | `76876af51590835038837ebbedfd8963f2d514f8162e871b9cdc8653a6799d15` |
| `NLA.NR03.RowCertificate.Singleton.Block04` | `f80ff26a2aa1fb86ae4cd59f57a49e916656c2ab50d572aef5a988462ce71d28` |
| `NLA.NR03.RowCertificate.Singleton.Block03` | `143274fbbfbde939085c9b37b7ef20966813f44a5afc6b24d74574deffff2e4b` |
| `NLA.NR03.RowCertificate.Singleton.Block02` | `9293dec609a90b25884e7b6488da69072ceb97245f3d18bd34e997a3448c177e` |
| `NLA.NR03.RowCertificate.Singleton.Block01` | `f092d372933088c042d140413a238b32f630810d39fe880262dff30f83f017d0` |
| `NLA.NR03.RowCertificate.Singleton.Block00` | `de06fa4cd43fc6ad6982ebf821958f6c8267106d50dda8ce9d9b3cfec5913d61` |
