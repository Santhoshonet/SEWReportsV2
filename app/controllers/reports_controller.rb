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


    @sum_of_all_pv = 0.00
    @sum_of_all_lrepmc = 0.00
    @sum_of_all_procurred_asphault = 0.00
    @sum_of_all_billed_asphault = 0.00
    @sum_of_all_procurred_concrete = 0.00
    @sum_of_all_billed_concrete = 0.00
    @sum_of_all_procurred_hsteel = 0.00
    @sum_of_all_billed_hsteel = 0.00
    @sum_of_all_procurred_rsteel = 0.00
    @sum_of_all_billed_rsteel = 0.00
    @sum_of_all_machine_availability = 0.00
    @sum_of_all_machine_usage = 0.00
    @sum_of_all_manpower_availability = 0.00
    @sum_of_all_manpower_usage = 0.00

    flash[:issuelastmonth] == ''
    flash[:issuelastbeforemonth] == ''
    
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

      begin
          if !projdetail.ProcuredAsphant.nil?
            @sum_of_all_procurred_asphault += projdetail.ProcuredAsphant
          end
      rescue
      end

      begin
          if !projdetail.BilledAsphant.nil?
            @sum_of_all_billed_asphault += projdetail.BilledAsphant
          end
      rescue
      end

      begin
          if !projdetail.ProcuredConcrete.nil?
            @sum_of_all_procurred_concrete += projdetail.ProcuredConcrete
          end
      rescue
      end

      begin
          if !projdetail.BilledConcrete.nil?
            @sum_of_all_billed_concrete += projdetail.BilledConcrete
          end
      rescue
      end

      begin
          if !projdetail.ProcuredHSteal.nil?
            @sum_of_all_procurred_hsteel += projdetail.ProcuredHSteal
          end
      rescue
      end

      begin
          if !projdetail.BilledHSteal.nil?
            @sum_of_all_billed_hsteel += projdetail.BilledHSteal
          end
      rescue
      end

      begin
          if !projdetail.ProcuredRSteal.nil?
            @sum_of_all_procurred_rsteel += projdetail.ProcuredRSteal
          end
      rescue
      end

      begin
          if !projdetail.BilledRSteal.nil?
            @sum_of_all_billed_rsteel += projdetail.BilledRSteal
          end
      rescue
      end

      begin
          if !projdetail.MachineAvailability.nil?
            @sum_of_all_machine_availability += projdetail.MachineAvailability
          end
      rescue
      end

      begin
          if !projdetail.MachineUsed.nil?
            @sum_of_all_machine_usage += projdetail.MachineUsed
          end
      rescue
      end

      begin
          if !projdetail.ManpowerAvailability.nil?
            @sum_of_all_manpower_availability += projdetail.ManpowerAvailability
          end
      rescue
      end

      begin
          if !projdetail.ManpowerUsed.nil?
            @sum_of_all_manpower_usage += projdetail.ManpowerUsed
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

    @previous_pv_cum = 0.00
    @previous_lre_site_cum = 0.00
    @previous_lre_pmc_cum = 0.00
    

    @project_details.each_with_index do |projdetail,index|

      currentmonth = DateTime.now.month;
      projmonth = projdetail.month.month;
      projyear = projdetail.month.year;
      currentyear = DateTime.now.year;
      # Section of Calculating the basic cummulative values
      begin
          if !projdetail.PlannedValue.nil? and !projdetail.PercentageProgress.nil? and !projdetail.ActualCost.nil?
              @sum_of_cum_pv += projdetail.PlannedValue
              result =  @sum_of_cum_pv.to_d * (projdetail.PercentageProgress.to_s.to_d / 100)
              @sum_of_cum_ev = result
              @sum_of_cum_actualcost += projdetail.ActualCost
          end
          unless projdetail.LRESite.nil?
            @sum_of_cum_lresite += projdetail.LRESite
          end
          unless projdetail.LREPmc.nil?
            @sum_of_cum_lrepmc += projdetail.LREPmc
          end
      rescue Exception => exc
        puts "Error at generating values for basic cummulative values due to  " + exc.message
      end

      # For Graph 1 [Contract budget confidence & Contract re-estimate confidence]
      begin
          if projmonth <= currentmonth and projyear == currentyear
            if !@contract_budget_confidence.has_key?(projdetail.month.strftime("%Y-%b-1"))
               
                cpi = (@sum_of_cum_ev / @sum_of_cum_actualcost)
                spi = (@sum_of_cum_ev / @sum_of_cum_pv)

                # for contract_budget_confidence
                result = (@sum_of_all_pv - @sum_of_cum_pv) / (@sum_of_all_pv - @sum_of_cum_actualcost)
                result = cpi / result
                result = (result - 1) * 10
                if result.nan? or result.infinite?
                  #@contract_budget_confidence[projdetail.month.strftime("%Y-%b-1")] = 1
                else
                  @contract_budget_confidence[projdetail.month.strftime("%Y-%b-1")] = result
                end

                # for contract_reestimate_confidence
                result =( ( (cpi) / ( (@sum_of_all_pv - @sum_of_cum_pv) / ( @sum_of_all_lrepmc - @sum_of_cum_actualcost) ) ) - 1 ) * 10

                
                if result.nan? or result.infinite?
                  #@contract_reestimate_confidence[projdetail.month.strftime("%Y-%b-1")] = 1
                else
                  @contract_reestimate_confidence[projdetail.month.strftime("%Y-%b-1")] = result
                end
              end
          end
       rescue Exception => exc
          puts "Error at generating values for @contract_budget_confidence due to " + exc.message
       end


      # For Graph 2 [Estimate Confidence] [LRE Site & LRE PMC]
      begin
          if !@pv_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
              if @previous_pv_cum != @sum_of_cum_pv
                @pv_cummulative[projdetail.month.strftime("%Y-%b-1")] = @sum_of_cum_pv
                @previous_pv_cum = @sum_of_cum_pv
              end
          end
          if !@lre_site.has_key?(projdetail.month.strftime("%Y-%b-1"))
              if @previous_lre_site_cum != @sum_of_cum_lresite
                @lre_site[projdetail.month.strftime("%Y-%b-1")] = @sum_of_cum_lresite
                @previous_lre_site_cum = @sum_of_cum_lresite
              end
          end
          if !@lre_pmc.has_key?(projdetail.month.strftime("%Y-%b-1"))
              if @previous_lre_pmc_cum != @sum_of_cum_lrepmc
                @lre_pmc[projdetail.month.strftime("%Y-%b-1")] = @sum_of_cum_lrepmc
                @previous_lre_pmc_cum = @sum_of_cum_lrepmc
              end
          end
      rescue Exception => exc
          puts "Error at generating values for Estimate Confidence due to " + exc.message
      end


      # For Graph 3 [Cost vs Schedule]
      begin
        if projmonth < currentmonth   and projyear == currentyear
          cpi = (@sum_of_cum_ev / @sum_of_cum_actualcost)
          spi = (@sum_of_cum_ev / @sum_of_cum_pv)
          if !@cpi_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                @cpi_cummulative[projdetail.month.strftime("%Y-%b-1")] = cpi
          end
          if !@spi_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                @spi_cummulative[projdetail.month.strftime("%Y-%b-1")] = spi
          end
        end
      rescue Exception => exc
          puts "Error at generating values for Cost Vs Schedule due to " + exc.message
      end

      # For Issues Analysis
      begin
          if projyear == currentyear
            if projmonth == currentmonth - 1
              # yes it is lastmonth
              extiss = 0
              if !projdetail.ExternalIssues.nil?
                extiss = projdetail.ExternalIssues
              end
              intiss = 0
              if !projdetail.InternalIssues.nil?
                intiss = projdetail.InternalIssues
              end
              flash[:issuelastmonth] = "External," + extiss.to_s + "#Internal," + intiss.to_s
              flash[:donuttitle_outer] = projdetail.month.strftime('%b-%Y') 
            elsif projmonth == currentmonth - 2
              # yes it is before to last month
              extiss = 0
              if !projdetail.ExternalIssues.nil?
                extiss = projdetail.ExternalIssues
              end
              intiss = 0
              if !projdetail.InternalIssues.nil?
                intiss = projdetail.InternalIssues
              end
              flash[:issuelastbeforemonth] = "External," + extiss.to_s + "#Internal," + intiss.to_s
              flash[:donuttitle_inner] = projdetail.month.strftime('%b-%Y')
            end
          end
      rescue Exception => exc
        puts "Error at generating values for Issue Analysis due to " + exc.message
      end

    end

    if flash[:issuelastmonth] == ''
        flash[:issuelastmonth] = "External,0#Internal,0"
    end

    if flash[:issuelastbeforemonth] == ''
        flash[:issuelastbeforemonth] == "External,0#Internal,0"
    end


    # for contract_budget_confidence
    flash[:contract_budget_confidence] = ''
    @contract_budget_confidence.each_with_index do |cbc,index|
        if index < @contract_budget_confidence.length - 1
          flash[:contract_budget_confidence] += "#{cbc[0]},#{cbc[1]}"
          if index < @contract_budget_confidence.length
            flash[:contract_budget_confidence] += '#'
          end
        end
    end


    # for contract_reestimate_confidence
    flash[:contract_reestimate_confidence] = ''
    @contract_reestimate_confidence.each_with_index do |crc,index|
        if index < @contract_budget_confidence.length - 1
          flash[:contract_reestimate_confidence] += "#{crc[0]},#{crc[1]}"
          if index < @contract_budget_confidence.length
            flash[:contract_reestimate_confidence] += '#'
          end
        end
    end


    # for pv cummulative
    flash[:pv_cummulative] = ''
    @pv_cummulative.each_with_index do |crc,index|
        flash[:pv_cummulative] += "#{crc[0]},#{crc[1]}"
        if index < @pv_cummulative.length
          flash[:pv_cummulative] += '#'
        end
    end


    # for lresite cummulative
    flash[:lresite_cummulative] = ''
    @lre_site.each_with_index do |crc,index|
        flash[:lresite_cummulative] += "#{crc[0]},#{crc[1]}"
        if index < @lre_site.length
          flash[:lresite_cummulative] += '#'
        end
    end


    # for lrepmc cummulative
    flash[:lrepmc_cummulative] = ''
    @lre_pmc.each_with_index do |crc,index|
        flash[:lrepmc_cummulative] += "#{crc[0]},#{crc[1]}"
        if index < @lre_pmc.length
          flash[:lrepmc_cummulative] += '#'
        end
    end


    # for cpi cummulative
    flash[:cpi_cummulative] = ''
    @cpi_cummulative.each_with_index do |crc,index|
        if index < @cpi_cummulative.length - 1
          flash[:cpi_cummulative] += "#{crc[0]},#{crc[1]}"
          if index < @cpi_cummulative.length
            flash[:cpi_cummulative] += '#'
          end
        end
    end


    # for spi cummulative
    flash[:spi_cummulative] = ''
    @spi_cummulative.each_with_index do |crc,index|
        if index < @spi_cummulative.length - 1        
          flash[:spi_cummulative] += "#{crc[0]},#{crc[1]}"
          if index < @spi_cummulative.length
            flash[:spi_cummulative] += '#'
          end
        end
    end


    # for Asphault usage
    flash[:asphault_cummulative] = 0
    flash[:asphault_cummulative] = (@sum_of_all_billed_asphault / @sum_of_all_procurred_asphault) * 10

    flash[:concrete_cummulative] = 0
    flash[:concrete_cummulative] = (@sum_of_all_billed_concrete / @sum_of_all_procurred_concrete)  * 10

    flash[:hsteel_cummulative] = 0
    flash[:hsteel_cummulative] =  (@sum_of_all_billed_hsteel / @sum_of_all_procurred_hsteel)  * 10

    flash[:rsteel_cummulative] = 0
    flash[:rsteel_cummulative] = (@sum_of_all_billed_rsteel / @sum_of_all_procurred_rsteel) * 10

    flash[:machine_usage_cummulative] = 0
    flash[:machine_usage_cummulative] = (@sum_of_all_machine_usage / @sum_of_all_machine_availability ) * 10

    flash[:man_power_usage_cummulative] = 0
    flash[:man_power_usage_cummulative] = (@sum_of_all_manpower_usage / @sum_of_all_manpower_availability) * 10


  end
end
