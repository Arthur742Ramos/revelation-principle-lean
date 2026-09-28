module

public import Mathlib.Basic.Real.Basic

/-!
# Revelation principle statements

This module stands alone for the Palomar comparator. The incentive-compatibility
predicate and theorem have placeholder bodies (two placeholders total).
-/

namespace Revelation

section
variable {ι : Type*} [DecidableEq ι]

/-- A mechanism maps message profiles to outcomes. -/
@[expose] public def Mechanism (ι : Type*) (M : ι → Type*) (X : Type*) : Type _ :=
  (∀ i, M i) → X

end

/-- Playing `σ i t` is optimal against every profile of other messages. -/
public def IsDominantStrategy {ι : Type*} [DecidableEq ι]
    {Θ M : ι → Type*} {X : Type*}
    (mech : Mechanism ι M X) (u : ∀ i, X → Θ i → ℝ)
    (σ : ∀ i, Θ i → M i) (i : ι) : Prop :=
  ∀ (t : Θ i) (m : ∀ i, M i) (m' : M i),
    u i (mech (Function.update m i (σ i t))) t ≥
    u i (mech (Function.update m i m')) t

/-- The direct mechanism applies the original strategies to reported types. -/
public def directMechanism {ι : Type*} {Θ M : ι → Type*} {X : Type*}
    (mech : Mechanism ι M X) (σ : ∀ i, Θ i → M i) :
    Mechanism ι Θ X :=
  fun θ => mech (fun i => σ i (θ i))

/-- Truth-telling is dominant in the direct mechanism. -/
public def IsDSIC {ι : Type*} [DecidableEq ι] {Θ : ι → Type*} {X : Type*}
    (dir : Mechanism ι Θ X) (u : ∀ i, X → Θ i → ℝ) : Prop := sorry

/-- Dominant-strategy implementation yields a truthful direct mechanism
with the same outcome function. -/
public theorem revelation_principle {ι : Type*} [DecidableEq ι]
    {Θ M : ι → Type*} {X : Type*}
    (mech : Mechanism ι M X) (u : ∀ i, X → Θ i → ℝ)
    (σ : ∀ i, Θ i → M i) (f : (∀ i, Θ i) → X)
    (himpl : ∀ θ, mech (fun i => σ i (θ i)) = f θ)
    (hdom : ∀ i, IsDominantStrategy mech u σ i) :
    IsDSIC (directMechanism mech σ) u ∧
    ∀ θ, directMechanism mech σ θ = f θ := sorry

end Revelation
