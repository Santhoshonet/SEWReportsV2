$(function() {


    function generateArray(str) {
        if (str != null && str != "") {
            var split = str.split('#');
            var array = new Array(split.length);
            for (var i = 0; i < split.length; i++) {
                split[i] = $.trim(split[i]);
                if(split[i] != null && split[i] != "")
                {
                    array[i] = new Array(2);
                    var split2 = split[i].split(",");
                    if (split2.length > 1) {
                        array[i][0] = $.trim(split2[0]);
                        array[i][1] = parseFloat($.trim(split2[1]),2);
                    }
                    else {
                        array[i][0] = 0;
                        array[i][1] = 0;
                    }
                }
            }
            return array;
        }
        else
        {
            var array = new Array(1);
            array[0] = new Array(2);
            array[0][0] = 0;
            array[0][1] = 0;
            return array;
        }
    };

        $('#asphalt').sparkline('html',{type:'bullet',width:'250px',height:'20px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']});
        $('#concrete').sparkline('html',{type:'bullet',width:'250px',height:'20px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']});
        $('#hsteel').sparkline('html',{type:'bullet',width:'250px',height:'20px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']});
        $('#rsteel').sparkline('html',{type:'bullet',width:'250px',height:'20px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']});
        $('#machine').sparkline('html',{type:'bullet',width:'250px',height:'20px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']});
        $('#hr').sparkline('html',{type:'bullet',width:'250px',height:'20px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']});
        $.jqplot.config.enablePlugins = true;
/**
        s1 = [['2010-Apr-1', -3], ['2010-May-1', -2], ['2010-Jun-1', -1],['2010-Jul-1', 0],['2010-Aug-1', 1]];
        s2 = [['2010-Apr-1', -2], ['2010-May-1', -1], ['2010-Jun-1', 0],['2010-Jul-1', 2],['2010-Aug-1', 3]];
        s3 = [[]];
        s4 = [['2010-Apr-1', 2367000000], ['2010-May-1', 2624200000], ['2010-Jun-1', 2868300000], ['2010-Jul-1', 3030300000], ['2010-Aug-1', 3185600000], ['2010-Sep-1', 3835600000], ['2010-Oct-1', 4092900000]];
        s5 = [['2010-Apr-1', 2367000000], ['2010-May-1', 2624200000], ['2010-Jun-1', 2868300000], ['2010-Jul-1', 3030300000], ['2010-Aug-1', 3185600000], ['2010-Sep-1', 3835600000], ['2010-Oct-1', 3442983913], ['2010-Nov-1', 3663378233], ['2010-Dec-1', 3908902001], ['2011-Jan-1', 4210881992],['2011-Feb-1', 4414413344]];
        s6 = [['2010-Apr-1', 2367000000], ['2010-May-1', 2624200000], ['2010-Jun-1', 2868300000], ['2010-Jul-1', 3030300000], ['2010-Aug-1', 3185600000], ['2010-Sep-1', 2760000000], ['2010-Oct-1', 3017383913], ['2010-Nov-1', 3237778233], ['2010-Dec-1', 3483301001], ['2011-Jan-1', 3785281992],['2011-Feb-1', 3988813344], ['2011-Mar-1', 4414413344]];
        s7 = [['2010-Feb-1', 0.05], ['2010-Mar-1', 0.1], ['2010-Apr-1', 0.175], ['2010-May-1', 0.2], ['2010-Jun-1', 0.25], ['2010-Jul-1', 0.3], ['2010-Aug-1', 0.35], ['2010-Sep-1', 0.4]];
        s8 = [['2010-Feb-1', 0.075], ['2010-Mar-1', 0.15], ['2010-Apr-1', 0.3], ['2010-May-1', 0.55], ['2010-Jun-1', 0.85], ['2010-Jul-1', 0.95], ['2010-Aug-1', 1.2], ['2010-Sep-1', 1.1]];
        s9 = [['External',70],['Internal',30]];
        s10= [['External',30],['Internal',70]];
**/

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

        var donuttitle = 'Outter circle ' + $('#donuttitle_outer').html() + ' , Inner circle ' + $('#donuttitle_inner').html();

   

        plot1 = $.jqplot('chart-1', [s1,s2], {
            grid:{
                borderWidth:0,
                shadow: false,
                backgroundColor: '#FFFFFF'
            },
            axes: {
                renderer: $.jqplot.LinearAxisRenderer,
                rendererOptions:{
                    tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                    labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                    },
                xaxis: {
                    renderer: $.jqplot.DateAxisRenderer,
                    borderWidth:1,
                    tickOptions:{
                        showMark: false,
                        formatString:'%b-%y',
                        showGridline:false
                    }
                },
                yaxis: {
                    labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                    min:-15,
                    max: 15,
                    borderWidth:1,
                    tickOptions: {
                        formatString: '%.0f'
                    },
                    label:'Current Efficiency / Required Efficiency',
                    labelOptions:{
                        fontFamily: 'Helvetica',
                        fontSize: '0.75em'
                    }
                }
            },
            highlighter: {
                sizeAdjust: 10,
                tooltipLocation: 'n',
                formatString: '<div class="jqplot-highlighter">%s, <strong>%s</strong></div>'
            },
            series: [
            { pointLabels:{show:false}, markerOptions: { style: 'filledCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
            { pointLabels:{show:false}, markerOptions: { style: 'filledCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} }
            ],

            seriesColors: ["#006CC6", "#FF9000"],
            legend: {
                renderer: $.jqplot.EnhancedLegendRenderer,
                show: true,
                showSwatches: true,
                labels: ['Budget', 'Re Estimate'],
                rendererOptions: {
                    numberRows: 1
                },
                placement: 'outside',
                location: 's',
                marginTop: '40px'
            }

        });
        plot2 = $.jqplot('chart-2', [s4, s5, s6], {
            grid:{
                borderWidth:0,
                shadow: false,
                backgroundColor: '#FFFFFF'
            },
            axes: {
                pad: 10,
                rendererOptions:{
                    tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                    labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                },
                xaxis: {
                    renderer: $.jqplot.DateAxisRenderer,
                    tickInterval: '4 months',
                    tickOptions: {
                        showMark: false,
                        formatString: '%b-%y',
                        showGridline: false
                    }
                },
                yaxis: {
                    tickOptions: {
                        formatString: '%.0f',
                        showGridline: true
                    }
                }
            },
            highlighter: {
                sizeAdjust: 10,
                tooltipLocation: 'n',
                bringSeriesToFront: true,
                useAxesFormatters: true,
                formatString: '<div class="jqplot-highlighter">%s, <strong>%s</strong></div>'
            },
            series: [
            { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'filledCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
            { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'filledCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
            { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'filledCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} }
            ],

            seriesColors: ["#FF9000", "#006CC6", "#00BD39"],
            legend: {
                renderer: $.jqplot.EnhancedLegendRenderer,
                show: true,
                showSwatches: true,
                labels: ['PV Cum', 'LRE Site', 'LRE PMC'],
                rendererOptions: {
                    numberRows: 1
                },
                placement: 'outside',
                location: 's',
                marginTop: '40px'
            }

        });
        plot3 = $.jqplot('chart-3', [s7, s8], {
            grid:{
                borderWidth:0,
                shadow: false,
                backgroundColor: '#FFFFFF'
            },
            axes: {
                renderer:{
                    renderer: $.jqplot.CanvasAxisTickRenderer,
                    renderer: $.jqplot.CanvasAxisLabelRenderer
                },
                xaxis: {
                    renderer: $.jqplot.DateAxisRenderer,
                    tickOptions: {
                        formatString: '%b-%y',
                        showGridline: false,
                        showMark: false
                    }
                },
                yaxis: {
                    min: -0.5,
                    max: 1.5, 
                    labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                    label: 'Index',
                    labelOptions: {
                        fontSize: '0.75em'
                    },
                    tickOptions: {
                        formatString: '%.2f',
                        showGridline: true
                    }
                }
            },
            highlighter: {
                sizeAdjust: 10,
                tooltipLocation: 'n',
                formatString: '<div class="jqplot-highlighter">%s, <strong>%s</strong></div>'
            },
            series: [
            { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'filledCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
            { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'filledCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} }
            ],
            seriesColors: ["#006CC6","#FF9000"],
            legend: {
                renderer: $.jqplot.EnhancedLegendRenderer,
                show: true,
                showSwatches: true,
                labels: ['Cost Performance', 'Schedule Performance'],
                rendererOptions: {
                    numberRows: 1
                },
                placement: 'outside',
                location: 's',
                marginTop: '40px'
            }
        });
        plot4 = $.jqplot('chart-4',[s9,s10],{
            title: donuttitle,
            grid:{
                borderWidth:0,
                shadow: false,
                backgroundColor:'#FFFFFF'
            },
            seriesDefaults: {
                renderer:$.jqplot.DonutRenderer,
                shadow: false,
                rendererOptions:{
                    sliceMargin: 1
                    /**dataLabels:'label'**/
                }
            },
            seriesColors: ["#FF9000","#006CC6"],
            series:[
                    {rendererOptions: {diameter: 125, innerDiameter:-25,startAngle: -90}},
                    {rendererOptions: {diameter: 250, innerDiameter:-125,startAngle: -90}}
                ],
            legend: {
                renderer: $.jqplot.EnhancedLegendRenderer,
                show: true,
                showSwatches: true,
                rendererOptions: {
                    numberRows: 1
                },
                placement: 'outside',
                location: 's',
                marginTop: '30px'
                    }
        });

 });