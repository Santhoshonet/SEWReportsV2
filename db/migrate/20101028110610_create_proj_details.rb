class CreateProjDetails < ActiveRecord::Migration
  def self.up
    create_table :proj_details do |t|
      t.date :month
      t.integer :PercentageProgress
      t.decimal :PlannedValue ,:precision => 32 , :scale => 2
      t.decimal :EarnedValue ,:precision => 32  , :scale => 2
      t.decimal :ActualCost, :precision => 32    , :scale => 2
      t.decimal :LRESite, :precision => 32     , :scale => 2
      t.decimal :LREPmc, :precision => 32     , :scale => 2
      t.decimal :CPI                     ,:precision => 32        , :scale => 2
      t.decimal :SPI                                      ,:precision => 32      , :scale => 2
      t.integer :MileStoneBilled
      t.integer :MileStoneUnbilled
      t.integer :InternalIssues
      t.integer :ExternalIssues
      t.integer :QualityIndex
      t.integer :HSCIndex
      t.integer :ProcuredAsphant
      t.integer :BilledAsphant
      t.integer :ProcuredConcrete
      t.integer :BilledConcrete
      t.integer :ProcuredHSteal
      t.integer :BilledHSteal
      t.integer :ProcuredRSteal
      t.integer :BilledRSteal
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
