module

public import Revelation.Basic
import all Revelation.Basic

namespace Revelation

variable {ι : Type*} [DecidableEq ι]

/-- A dominant-strategy implementation yields a truthful direct mechanism
with the same outcome function. -/
public theorem revelation_principle {Θ M : ι → Type*} {X : Type*}
    (mech : Mechanism ι M X) (u : ∀ i, X → Θ i → ℝ)
    (σ : ∀ i, Θ i → M i) (f : (∀ i, Θ i) → X)
    (himpl : ∀ θ, mech (fun i => σ i (θ i)) = f θ)
    (hdom : ∀ i, IsDominantStrategy mech u σ i) :
    IsDSIC (directMechanism mech σ) u ∧
    ∀ θ, directMechanism mech σ θ = f θ := by
  constructor
  · intro i t θ t'
    let m : ∀ i, M i := fun j => σ j (θ j)
    have update_strategy (s : Θ i) :
        (fun j => σ j ((Function.update θ i s) j)) =
          Function.update m i (σ i s) := by
      funext j
      by_cases h : j = i
      · subst j
        simp [m]
      · simp [m, h]
    simpa only [IsDSIC, IsDominantStrategy, directMechanism,
      update_strategy] using hdom i t m (σ i t')
  · intro θ
    exact himpl θ

end Revelation
