class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  acts_as_paranoid column: :deleted, sentinel_value: false

  def paranoia_restore_attributes
    {
      updated_at: current_time_from_proper_timezone,
      deleted: false,
    }
  end

  def paranoia_destroy_attributes
    {
      updated_at: current_time_from_proper_timezone,
      deleted: true
    }
  end

end
