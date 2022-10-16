Rails.application.routes.draw do
  mount StateTransitions::Engine => "/state_transitions"
end
