class StateTransitions::StateTransition < StateTransitions::ApplicationRecord
  self.table_name = "state_transitions"

  belongs_to :resource, polymorphic: true
  belongs_to :user, optional: true, polymorphic: true

  validates :state_from, presence: true, if: :persisted?
  validates :state_to, presence: true
end
