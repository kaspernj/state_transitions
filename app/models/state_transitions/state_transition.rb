class StateTransitions::StateTransition < ApplicationRecord
  validates :from_state, :to_state, presence: true
end
