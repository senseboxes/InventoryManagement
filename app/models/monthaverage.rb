class Monthaverage < ApplicationRecord
  belongs_to :inventory  
  
    def init_value
      self[:january] = 0
      self[:february] = 0
      self[:march] = 0
      self[:april] = 0
      self[:may] = 0
      self[:june] = 0
      self[:july] = 0
      self[:august] = 0
      self[:september] = 0
      self[:october] = 0
      self[:november] = 0
      self[:december] =  0
      self[:january_c] = 0
      self[:february_c] = 0
      self[:march_c] = 0
      self[:april_c] = 0
      self[:may_c] = 0
      self[:june_c] = 0
      self[:july_c] = 0
      self[:august_c] = 0
      self[:september_c] = 0
      self[:october_c] = 0
      self[:november_c] = 0
      self[:december_c] =  0
      self[:y_index] = 0
      self[:m_index] = 0
      self[:y_sum] =  0
      self[:y_avg] =  0
      self[:m_avg] =  0   
    end
    
end
