# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101028110610) do

  create_table "proj_details", :force => true do |t|
    t.date     "month"
    t.integer  "PercentageProgress"
    t.decimal  "PlannedValue",         :precision => 32, :scale => 2
    t.decimal  "EarnedValue",          :precision => 32, :scale => 2
    t.decimal  "ActualCost",           :precision => 32, :scale => 2
    t.decimal  "LRESite",              :precision => 32, :scale => 2
    t.decimal  "LREPmc",               :precision => 32, :scale => 2
    t.decimal  "CPI",                  :precision => 32, :scale => 2
    t.decimal  "SPI",                  :precision => 32, :scale => 2
    t.integer  "MileStoneBilled"
    t.integer  "MileStoneUnbilled"
    t.integer  "InternalIssues"
    t.integer  "ExternalIssues"
    t.integer  "QualityIndex"
    t.integer  "HSCIndex"
    t.integer  "ProcuredAsphant"
    t.integer  "BilledAsphant"
    t.integer  "ProcuredConcrete"
    t.integer  "BilledConcrete"
    t.integer  "ProcuredHSteal"
    t.integer  "BilledHSteal"
    t.integer  "ProcuredRSteal"
    t.integer  "BilledRSteal"
    t.integer  "MachineAvailability"
    t.integer  "MachineUsed"
    t.integer  "ManpowerAvailability"
    t.integer  "ManpowerUsed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_details", :force => true do |t|
    t.date     "month"
    t.string   "location"
    t.integer  "PlannedValue"
    t.integer  "LREContract"
    t.integer  "LREPmc"
    t.integer  "ContractorIndex"
    t.float    "CPI"
    t.float    "SPI"
    t.integer  "MileStonebuild"
    t.integer  "MileStoneUnbuild"
    t.integer  "IssuesInternal"
    t.integer  "IssuesExternal"
    t.integer  "QualityIndex"
    t.integer  "HSCIndex"
    t.float    "MaterialAsphant"
    t.float    "MaterialConcrete"
    t.float    "MaterialHSteal"
    t.float    "MaterialRSteal"
    t.integer  "MachineAvailable"
    t.integer  "MachineUsed"
    t.integer  "MenAvailable"
    t.integer  "MenUsed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
