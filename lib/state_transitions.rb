require "state_transitions/version"
require "state_transitions/engine"

module StateTransitions
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def track_state_transitions
      model_class = self

      has_one :current_state_transition,
        lambda {
          where(
            <<~SQL.squish
              #{current_table_name}.id = (
                SELECT current_state_transition.id
                FROM state_transitions AS current_state_transition
                WHERE
                  current_state_transition.resource_type = #{current_table_name}.resource_type AND
                  current_state_transition.resource_id = #{current_table_name}.resource_id
                ORDER BY current_state_transition.created_at DESC
                LIMIT 1
              )
            SQL
          )
        },
        as: :resource,
        class_name: "StateTransitions::StateTransition"

      has_many :state_transitions,
        as: :resource,
        class_name: "StateTransitions::StateTransition",
        dependent: :destroy

      after_save :save_state_transition, if: :saved_change_to_state?
    end

    def define_first_state_transition_scope(state)
      sql = <<~SQL.squish
        #{current_table_name}.id = (
          SELECT first_state_transition.id
          FROM state_transitions AS first_state_transition
          WHERE
            first_state_transition.resource_type = #{current_table_name}.resource_type AND
            first_state_transition.resource_id = #{current_table_name}.resource_id AND
            first_state_transition.state_to = ?
          ORDER BY first_state_transition.created_at
          LIMIT 1
        )
      SQL

      has_one :"first_#{state}_state_transition",
        -> { where(sql, state) },
        as: :resource,
        class_name: "StateTransitions::StateTransition"
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
