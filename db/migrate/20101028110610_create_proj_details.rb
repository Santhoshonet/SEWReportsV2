class CreateProjDetails < ActiveRecord::Migration
  def self.up
    create_table :proj_details do |t|
      t.date :month
      t.integer :PercentageProgress
      t.decimal :PlannedValue
      t.decimal :EarnedValue
      t.float :ActualCost
      t.decimal :LRESite
      t.decimal :LREPmc
      t.float :CPI
      t.float :SPI
      t.decimal :MileStoneBilled
      t.decimal :MileStoneUnbilled
      t.decimal :InternalIssues
      t.decimal :ExternalIssues
      t.decimal :QualityIndex
      t.decimal :HSCIndex
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
