class CreateProjDetails < ActiveRecord::Migration
  def self.up
    create_table :proj_details do |t|
      t.date :month
      t.integer :PercentageProgress
      t.decimal :PlannedValue
      t.decimal :EarnedValue
      t.decimal :ActualCost
      t.decimal :LRESite
      t.decimal :LREPmc
      t.decimal :CPI
      t.decimal :SPI
      t.decimal :MileStoneBilled
      t.decimal :MileStoneUnbilled
      t.decimal :InternalIssues
      t.decimal :ExternalIssues
      t.decimal :QualityIndex
      t.decimal :HSCIndex
      t.decimal :ProcuredAsphant
      t.decimal :BilledAsphant
      t.decimal :ProcuredConcrete
      t.decimal :BilledConcrete
      t.decimal :ProcuredHSteal
      t.decimal :BilledHSteal
      t.decimal :ProcuredRSteal
      t.decimal :BilledRSteal
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
