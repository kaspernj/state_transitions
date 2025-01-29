module StateTransitions
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def self.inherited(child)
      super

      child.extend ClassMethods
    end

    module ClassMethods
      def current_table_name
        current_table = current_scope.arel.source.left

        case current_table
        when Arel::Table
          current_table.name
        when Arel::Nodes::TableAlias
          current_table.right
        else
          raise "Couldn't figure out the current table name"
        end
      end
    end
  end
end
