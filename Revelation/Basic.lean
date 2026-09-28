module

public import Mathlib.Basic.Real.Basic

namespace Revelation

variable {ι : Type*} [DecidableEq ι]

/-- A mechanism is message spaces plus an outcome function on message profiles. -/
@[expose] public def Mechanism (ι : Type*) (M : ι → Type*) (X : Type*) : Type _ :=
  (∀ i, M i) → X

/-- Dominant strategy: with true type `t`, playing `σ i t` beats every
deviation `m'`, against every message profile `m` of the others. -/
public def IsDominantStrategy {Θ M : ι → Type*} {X : Type*}
    (mech : Mechanism ι M X) (u : ∀ i, X → Θ i → ℝ)
    (σ : ∀ i, Θ i → M i) (i : ι) : Prop :=
  ∀ (t : Θ i) (m : ∀ i, M i) (m' : M i),
    u i (mech (Function.update m i (σ i t))) t ≥
    u i (mech (Function.update m i m')) t

/-- The direct revelation mechanism: elicit types, then play the equilibrium
strategies on the agents' behalf. -/
public def directMechanism {Θ M : ι → Type*} {X : Type*}
    (mech : Mechanism ι M X) (σ : ∀ i, Θ i → M i) :
    Mechanism ι Θ X :=
  fun θ => mech (fun i => σ i (θ i))

/-- DSIC: truth-telling is a dominant strategy in a direct mechanism. -/
public def IsDSIC {Θ : ι → Type*} {X : Type*}
    (dir : Mechanism ι Θ X) (u : ∀ i, X → Θ i → ℝ) : Prop :=
  ∀ i, IsDominantStrategy dir u (fun _ t => t) i

end Revelation
