function generateArray(str) {
        if (str != null && str != "") {
            var split = str.split('#');
            var array = new Array(split.length);
            for (var i = 0; i < split.length; i++) {
                array[i] = new Array(2);
                var split2 = split[i].split(",");
                if (split2.length > 1) {
                    array[i][0] = split2[0];
                    array[i][1] = split2[1];
                }
                else {
                    array[i][0] = null;
                    array[i][1] = null;
                }
            }
            return array;
        }
        else
        {
            var array = new Array(1);
            return array;
        }
    }
var s1 = generateArray($('#contract_budget_confidence').html());  // Contract Confidence
var s2 = generateArray($('#contract_reestimate_confidence').html());  // Contract Confidence
var s3 = [[]];
var s4 = generateArray($('#pv_cummulative').html());  // PV Cummulative
var s5 = generateArray($('#lresite_cummulative').html());  // LRE Site Cummulative
var s6 = generateArray($('#lrepmc_cummulative').html());  // LRE PMC Cummulative
var s7 = generateArray($('#cpi_cummulative').html());  // CPI Cummulative
var s8 = generateArray($('#spi_cummulative').html());  // SPI Cummulative
var s9 = generateArray($('#issuelastmonth').html());  // Last month External & Internal Issues
var s10= generateArray($('#issuelastbeforemonth').html()); // Last before month External & Internal Issues