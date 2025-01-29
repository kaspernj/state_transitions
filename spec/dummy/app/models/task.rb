class Task < ApplicationRecord
  include StateTransitions

  track_state_transitions
end
