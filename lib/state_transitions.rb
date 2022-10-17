require "state_transitions/version"
require "state_transitions/engine"

module StateTransitions
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def track_state_transitions
      has_many :state_transitions,
        as: :resource,
        class_name: "StateTransitions::StateTransition",
        dependent: :destroy

      after_save :save_state_transition, if: :saved_change_to_state?
    end
  end

  def save_state_transition
    StateTransitions::StateTransition.create!(
      resource: self,
      state_from: saved_change_to_state.fetch(0),
      state_to: saved_change_to_state.fetch(1),
      user: StateTransitions::Current.user
    )
  end
end
