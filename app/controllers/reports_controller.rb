class ReportsController < ApplicationController

  def index

    @project_details = ProjDetail.find(:all,:order => 'month')

    @contract_budget_confidence = Hash.new
    @contract_reestimate_confidence = Hash.new

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
    @project_details.each do |projdetail|
       begin
          if !@contract_budget_confidence.has_key?(projdetail.month.strftime("%Y-%b-1"))

            @sum_of_cum_pv += projdetail.PlannedValue
            @sum_of_cum_ev += (@sum_of_all_pv * projdetail.PercentageProgress / 100)
            @sum_of_cum_actualcost += projdetail.ActualCost
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
       rescue
       end
    end


    # for contract_budget_confidence
    flash[:contract_budget_confidence] = '['
    @contract_budget_confidence.each_with_index do |cbc,index|
        flash[:contract_budget_confidence] += "['#{cbc[0]}',#{cbc[1]}]"
        if index != 0 and index < @contract_budget_confidence.length
          flash[:contract_budget_confidence] += ','
        end
    end
    flash[:contract_budget_confidence] += ']'


    # for contract_reestimate_confidence
    flash[:contract_reestimate_confidence] = '['
    @contract_reestimate_confidence.each_with_index do |crc,index|
        flash[:contract_reestimate_confidence] += "['#{crc[0]}',#{crc[1]}]"
        if index != 0 and index < @contract_budget_confidence.length
          flash[:contract_reestimate_confidence] += ','
        end
    end
    flash[:contract_reestimate_confidence] += ']'


  end
end
