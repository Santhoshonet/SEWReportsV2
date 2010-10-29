class ReportsController < ApplicationController

  def index

    @project_details = ProjDetail.find(:all,:order => 'month')

    @contract_budget_confidence = Hash.new
    @contract_reestimate_confidence = Hash.new

    @pv_cummulative = Hash.new
    @lre_site = Hash.new
    @lre_pmc = Hash.new
    @cpi_cummulative = Hash.new
    @spi_cummulative = Hash.new
    @asphault_usage_cummulative = Hash.new
    @concrete_usage_cummulative = Hash.new
    @hsteel_usage_cummulative = Hash.new
    @rsteel_usage_cummulative = Hash.new
    @machine_usage_cummulative = Hash.new
    @manpower_usage_cummulative = Hash.new

    @sum_of_all_pv = 0.00
    @sum_of_all_lrepmc = 0.00
    # For Calculating all the summary values  here
    @project_details.each do |projdetail|

      begin
        unless projdetail.PlannedValue.nil? and projdetail.PlannedValue.empty?
          @sum_of_all_pv += projdetail.PlannedValue
        end
      rescue
      end

      begin
          unless projdetail.LREPmc.nil? and projdetail.empty?
            @sum_of_all_lrepmc += projdetail.LREPmc
          end
      rescue
      end

    end

    # Actual Calculation goes here
    @sum_of_cum_pv =0.00
    @sum_of_cum_actualcost = 0.00
    @sum_of_cum_ev = 0.00
    @sum_of_cum_lresite = 0.00
    @sum_of_cum_lrepmc = 0.00

    @project_details.each_with_index do |projdetail,index|

      # Section of Calculating the basic cummulative values
      begin
          if !projdetail.PlannedValue.nil? and !projdetail.PercentageProgress.nil? and !projdetail.ActualCost.nil?
              @sum_of_cum_pv += projdetail.PlannedValue
              @sum_of_cum_ev += (@sum_of_all_pv * projdetail.PercentageProgress / 100)
              @sum_of_cum_actualcost += projdetail.ActualCost
          end
          unless projdetail.LRESite.nil?
            @sum_of_cum_lresite += projdetail.LRESite
          end
          unless projdetail.LREPmc.nil?
            @sum_of_cum_lrepmc += projdetail.LREPmc
          end
      rescue
        puts "Error at generating values for basic cummulative values due to  " + exc.message
      end

      # For Graph 1 [Contract budget confidence & Contract re-estimate confidence]
      begin
          if !@contract_budget_confidence.has_key?(projdetail.month.strftime("%Y-%b-1"))
              cpi = (@sum_of_cum_ev / @sum_of_cum_actualcost)
              spi = (@sum_of_cum_ev / @sum_of_cum_pv)

              # for contract_budget_confidence
              result = ((cpi) / ( (@sum_of_all_pv - @sum_of_cum_pv) / (@sum_of_all_pv - @sum_of_cum_actualcost))) * 10
              if result.nan? or result.infinite?
                @contract_budget_confidence[projdetail.month.strftime("%Y-%b-1")] = 1
              else
                @contract_budget_confidence[projdetail.month.strftime("%Y-%b-1")] = result
              end

              # for contract_reestimate_confidence
              result = ( (cpi) / ( (@sum_of_all_pv - @sum_of_cum_pv) / ( @sum_of_all_lrepmc - @sum_of_cum_actualcost) ) )
              if result.nan? or result.infinite?
                @contract_reestimate_confidence[projdetail.month.strftime("%Y-%b-1")] = 1
              else
                @contract_reestimate_confidence[projdetail.month.strftime("%Y-%b-1")] = result
              end
          end
       rescue Exception => exc
          puts "Error at generating values for @contract_budget_confidence due to " + exc.message
       end


      # For Graph 2 [Estimate Confidence] [LRE Site & LRE PMC]
      begin
          if !@pv_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
            @pv_cummulative[projdetail.month.strftime("%Y-%b-1")] = @sum_of_cum_pv
            @lre_site[projdetail.month.strftime("%Y-%b-1")] = @sum_of_cum_lresite
            @lre_pmc[projdetail.month.strftime("%Y-%b-1")] = @sum_of_cum_lrepmc
          end
      rescue Exception => exc
          puts "Error at generating values for Estimate Confidence due to " + exc.message
      end


      # For Graph 3 [Cost vs Schedule]
      begin
          cpi = (@sum_of_cum_ev / @sum_of_cum_actualcost)
          spi = (@sum_of_cum_ev / @sum_of_cum_pv)
          if !@cpi_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                @cpi_cummulative[projdetail.month.strftime("%Y-%b-1")] = cpi
          end
          if !@spi_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                @spi_cummulative[projdetail.month.strftime("%Y-%b-1")] = spi
          end
      rescue Exception => exc
          puts "Error at generating values for Cost Vs Schedule due to " + exc.message
      end


      # Graph 5 [Asphault usage]
      begin
          if !projdetail.ProcuredAsphant.nil? and !projdetail.BilledAsphant.nil?
              if !@asphault_usage_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                result = ( (projdetail.ProcuredAsphant - projdetail.BilledAsphant) / (projdetail.ProcuredAsphant) ) * 10
                if result.nan? or result.infinite?
                  @asphault_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = 0
                else
                  @asphault_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = result
                end
              end
          end
      rescue Exception => exc
        puts "Error at generating values for Asphault usage due to " + exc.message
      end

      # for [Concrete usage]
      begin
          if !projdetail.ProcuredConcrete.nil? and projdetail.BilledConcrete.nil?
            if !@concrete_usage_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                result = ( (projdetail.ProcuredConcrete - projdetail.BilledConcrete) / (projdetail.ProcuredConcrete) ) * 10
                if result.nan? or result.infinite?
                    @concrete_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = 0
                else
                    @concrete_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = result
                end
            end            
          end
      rescue Exception => exc
        puts "Error at generating values for Concrete usage due to " + exc.message
      end

      # for HSteel usage
      begin
          if !projdetail.ProcuredHSteal.nil? and projdetail.BilledHSteal.nil?
            if !@hsteel_usage_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                result = ( (projdetail.ProcuredHSteal - projdetail.BilledHSteal) / (projdetail.ProcuredHSteal) ) * 10
                if result.nan? or result.infinite?
                    @hsteel_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = 0
                else
                    @hsteel_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = result
                end
            end
          end
      rescue Exception => exc
        puts "Error at generating values for HSteel usage due to " + exc.message
      end


      # for RSteel usage
      begin
          if !projdetail.ProcuredRSteal.nil? and projdetail.BilledRSteal.nil?
            if !@rsteel_usage_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                result = ( (projdetail.ProcuredRSteal - projdetail.BilledRSteal) / (projdetail.ProcuredRSteal) ) * 10
                if result.nan? or result.infinite?
                    @rsteel_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = 0
                else
                    @rsteel_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = result
                end
            end
          end
      rescue Exception => exc
        puts "Error at generating values for RSteel usage due to " + exc.message
      end



      # for Machine usage
      begin
          if !projdetail.MachineAvailability.nil? and projdetail.MachineUsed.nil?
            if !@machine_usage_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                result = ( (projdetail.MachineAvailability - projdetail.MachineUsed) / (projdetail.MachineAvailability) ) * 10
                if result.nan? or result.infinite?
                    @machine_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = 0
                else
                    @machine_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = result
                end
            end
          end
      rescue Exception => exc
        puts "Error at generating values for machine usage due to " + exc.message
      end


      # for manpower usage
      begin
          if !projdetail.ManpowerAvailability.nil? and projdetail.ManpowerUsed.nil?
            if !@manpower_usage_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                result = ( (projdetail.ManpowerAvailability - projdetail.ManpowerUsed) / (projdetail.ManpowerAvailability) ) * 10
                if result.nan? or result.infinite?
                    @manpower_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = 0
                else
                    @manpower_usage_cummulative[projdetail.month.strftime("%Y-%b-1")] = result
                end
            end
          end
      rescue Exception => exc
        puts "Error at generating values for manpower usage due to " + exc.message
      end


      # For Issues Analysis
      begin
          if index == @project_details.length - 1
            # yes it is lastmonth
            extiss = 0
            if !projdetail.ExternalIssues.nil?
              extiss = projdetail.ExternalIssues
            end
            intiss = 0
            if !projdetail.InternalIssues.nil?
              extiss = projdetail.InternalIssues
            end
            flash[:issuelastmonth] = "'External'," + extiss.to_s + "#'Internal'," + intiss.to_s
          elsif index == @project_details.length - 2
            # yes it is before to last month
            extiss = 0
            if !projdetail.ExternalIssues.nil?
              extiss = projdetail.ExternalIssues
            end
            intiss = 0
            if !projdetail.InternalIssues.nil?
              extiss = projdetail.InternalIssues
            end
            flash[:issuelastbeforemonth] = "'External'," + extiss.to_s + "#'Internal'," + intiss.to_s
          end
      rescue Exception => exc
        puts "Error at generating values for Issue Analysis due to " + exc.message
      end

    end

    # for contract_budget_confidence
    flash[:contract_budget_confidence] = ''
    @contract_budget_confidence.each_with_index do |cbc,index|
        flash[:contract_budget_confidence] += "#{cbc[0]},#{cbc[1]}"
        if index != 0 and index < @contract_budget_confidence.length
          flash[:contract_budget_confidence] += '#'
        end
    end


    # for contract_reestimate_confidence
    flash[:contract_reestimate_confidence] = ''
    @contract_reestimate_confidence.each_with_index do |crc,index|
        flash[:contract_reestimate_confidence] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @contract_budget_confidence.length
          flash[:contract_reestimate_confidence] += '#'
        end
    end


    # for pv cummulative
    flash[:pv_cummulative] = ''
    @pv_cummulative.each_with_index do |crc,index|
        flash[:pv_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @pv_cummulative.length
          flash[:pv_cummulative] += '#'
        end
    end


    # for lresite cummulative
    flash[:lresite_cummulative] = ''
    @lre_site.each_with_index do |crc,index|
        flash[:lresite_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @lre_site.length
          flash[:lresite_cummulative] += '#'
        end
    end


    # for lrepmc cummulative
    flash[:lrepmc_cummulative] = ''
    @lre_pmc.each_with_index do |crc,index|
        flash[:lrepmc_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @lre_pmc.length
          flash[:lrepmc_cummulative] += '#'
        end
    end


    # for cpi cummulative
    flash[:cpi_cummulative] = ''
    @cpi_cummulative.each_with_index do |crc,index|
        flash[:cpi_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @cpi_cummulative.length
          flash[:cpi_cummulative] += '#'
        end
    end


    # for spi cummulative
    flash[:spi_cummulative] = ''
    @spi_cummulative.each_with_index do |crc,index|
        flash[:spi_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @spi_cummulative.length
          flash[:spi_cummulative] += '#'
        end
    end


    # for Asphault usage
    flash[:asphault_cummulative] = ''
    @asphault_usage_cummulative.each_with_index do |crc,index|
        flash[:asphault_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @asphault_usage_cummulative.length
          flash[:asphault_cummulative] += '#'
        end
    end


    # for Concrete usage
    flash[:concrete_cummulative] = ''
    @concrete_usage_cummulative.each_with_index do |crc,index|
        flash[:concrete_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @concrete_usage_cummulative.length
          flash[:concrete_cummulative] += '#'
        end
    end


    # for HSteal usage
    flash[:hsteel_cummulative] = ''
    @hsteel_usage_cummulative.each_with_index do |crc,index|
        flash[:hsteel_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @hsteel_usage_cummulative.length
          flash[:hsteel_cummulative] += '#'
        end
    end



    # for RSteal usage
    flash[:rsteel_cummulative] = ''
    @rsteel_usage_cummulative.each_with_index do |crc,index|
        flash[:rsteel_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @rsteel_usage_cummulative.length
          flash[:rsteel_cummulative] += '#'
        end
    end


    # for Machine usage
    flash[:machine_usage_cummulative] = ''
    @machine_usage_cummulative.each_with_index do |crc,index|
        flash[:machine_usage_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @machine_usage_cummulative.length
          flash[:machine_usage_cummulative] += '#'
        end
    end


    # for Manpower usage
    flash[:man_power_usage_cummulative] = ''
    @manpower_usage_cummulative.each_with_index do |crc,index|
        flash[:man_power_usage_cummulative] += "#{crc[0]},#{crc[1]}"
        if index != 0 and index < @manpower_usage_cummulative.length
          flash[:man_power_usage_cummulative] += '#'
        end
    end


    
  end
end
