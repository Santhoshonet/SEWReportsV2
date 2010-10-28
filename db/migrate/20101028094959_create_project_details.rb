class CreateProjectDetails < ActiveRecord::Migration
  def self.up
    create_table :project_details do |t|
      t.date :month
      t.string :location
      t.integer :PlannedValue
      t.integer :LREContract
      t.integer :LREPmc
      t.integer :ContractorIndex
      t.float :CPI
      t.float :SPI
      t.integer :MileStonebuild
      t.integer :MileStoneUnbuild
      t.integer :IssuesInternal
      t.integer :IssuesExternal
      t.integer :QualityIndex
      t.integer :HSCIndex
      t.float :MaterialAsphant
      t.float :MaterialConcrete
      t.float :MaterialHSteal
      t.float :MaterialRSteal
      t.integer :MachineAvailable
      t.integer :MachineUsed
      t.integer :MenAvailable
      t.integer :MenUsed

      t.timestamps
    end
  end

  def self.down
    drop_table :project_details
  end
end
