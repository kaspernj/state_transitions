require "rails_helper"

describe StateTransitions do
  describe "#current_state_transition" do
    it "returns the state transition for the current state" do
      task = Task.create!(name: "Test task")
      task.update!(state: "in_progress")
      task.update!(state: "new")
      task.update!(state: "in_progress")

      last_state_transition = task.state_transitions.last!

      expect(task.current_state_transition.id).to eq last_state_transition.id
    end
  end
end
