# Revelation principle in Lean 4

This library proves the dominant-strategy revelation principle for agents
indexed by `ι`, with type spaces `Θ i`, message spaces `M i`, outcomes `X`,
and private-value utilities `u i : X → Θ i → ℝ`. A mechanism maps message
profiles to outcomes. The strategy `σ i` maps an agent's type to a message.

The theorem `Revelation.revelation_principle` takes a mechanism `mech`,
utilities `u`, strategies `σ`, and an outcome function `f`. It assumes
`himpl : ∀ θ, mech (fun i => σ i (θ i)) = f θ` and
`hdom : ∀ i, IsDominantStrategy mech u σ i`. The dominance condition says
that for every true type `t`, message profile `m`, and deviation `m'`,
playing `σ i t` gives agent `i` at least as much utility as `m'` when all
other messages are fixed.

The conclusion is
`IsDSIC (directMechanism mech σ) u ∧ ∀ θ, directMechanism mech σ θ = f θ`.
Here `directMechanism mech σ` applies the original strategies to a reported
type profile. The proof translates a unilateral type-report change into the
corresponding unilateral message change, applies `hdom`, and uses `himpl`
for the outcome equality.

Run `lake build` to build the library. Run `bash scripts/verify-palomar.sh`
to check the standalone Challenge, declarations, axioms, and comparator.
