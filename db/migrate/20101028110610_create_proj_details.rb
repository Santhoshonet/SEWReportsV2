class CreateProjDetails < ActiveRecord::Migration
  def self.up
    create_table :proj_details do |t|
      t.date :month
      t.integer :PercentageProgress
      t.integer :PlannedValue
      t.integer :EarnedValue
      t.float :ActualCost
      t.integer :LRESite
      t.integer :LREPmc
      t.float :CPI
      t.float :SPI
      t.integer :MileStoneBilled
      t.integer :MileStoneUnbilled
      t.integer :InternalIssues
      t.integer :ExternalIssues
      t.integer :QualityIndex
      t.integer :HSCIndex
      t.float :ProcuredAsphant
      t.float :BilledAsphant
      t.float :ProcuredConcrete
      t.float :BilledConcrete
      t.float :ProcuredHSteal
      t.float :BilledHSteal
      t.float :ProcuredRSteal
      t.float :BilledRSteal
      t.integer :MachineAvailability
      t.integer :MachineUsed
      t.integer :ManpowerAvailability
      t.integer :ManpowerUsed

      t.timestamps
    end
  end

  def self.down
    drop_table :proj_details
  end
end
