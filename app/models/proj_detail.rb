class ProjDetail < ActiveRecord::Base

  validates_presence_of :PercentageProgress
  validates_presence_of :PlannedValue
  validates_presence_of :ActualCost
  validates_presence_of :LREPmc
  validates_presence_of :LRESite

  validates_numericality_of :PercentageProgress,:PlannedValue,:ActualCost, :LRESite, :LREPmc

  
end
