$(function() {
        $('#asphalt').sparkline('html',{type:'bullet',width:'350px',height:'30px',performanceColor:'#006CC6', rangeColors:['#ddd','#bbb','#aaa']});
        $('#concrete').sparkline('html',{type:'bullet',width:'350px',height:'30px',performanceColor:'#FF9000',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']});
        $.jqplot.config.enablePlugins = true;
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
        plot1 = $.jqplot('chart-1', [s1,s2,s3], {
            axes: {
                pad: 10,
                xaxis: {
                    renderer: $.jqplot.DateAxisRenderer,
                    tickOptions:{
                      formatString:'%b-%Y',
                      showGridline: false
                    }
                },
                yaxis: {
                    tickOptions: {
                        formatString: '%.0f'
                    }
                }
            },
            highlighter: {
                sizeAdjust: 10,
                tooltipLocation: 'n',
                formatString: '<div class="jqplot-highlighter">%s, <strong>%s</strong></div>'
            },
            series: [
            { pointLabels:{show:false}, markerOptions: { style: 'filledCircle', size: 15, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
            { pointLabels:{show:false}, markerOptions: { style: 'filledCircle', size: 15, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
            { pointLabels:{show:false}, showLine: false, markerOptions: { style: 'filledCircle', size: 15, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} }
            ],

            seriesColors: ["#00BD39", "#FFE800", "#FF2300"]

        });
        plot2 = $.jqplot('chart-2', [s4, s5, s6], {
            axes: {
                pad: 10,
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    renderer: $.jqplot.DateAxisRenderer,
                    tickOptions: {
                        formatString: '%b-%Y',
                        showGridline: false
                    }
                },
                yaxis: {
                    tickOptions: {
                        formatString: '%.0f'
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
            { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'filledDiamond', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
            { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'filledSquare', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} }
            ],

            seriesColors: ["#FF9000", "#006CC6", "#00BD39"],
            legend: {
                renderer: $.jqplot.EnhancedLegendRenderer,
                show: true,
                showSwatches: true,
                labels: ['PV Cum', 'LRE Contractor', 'LRE PMC'],
                rendererOptions: {
                    numberRows: 1
                },
                placement: 'outside',
                location: 's',
                marginTop: '30px'
            }

        });
        plot3 = $.jqplot('chart-3', [s7, s8], {
            fontFamily:"'Tahoma",
            fontSize:"1em",
            axes: {
                pad: 10,
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    renderer: $.jqplot.DateAxisRenderer,
                    tickOptions: {
                        formatString: '%b-%Y',
                        showGridline: false
                    }
                },
                yaxis: {
                    tickOptions: {
                        formatString: '%.2f'
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
            { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'filledDiamond', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} }
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
                marginTop: '30px'
            }
        });
        plot4 = $.jqplot('chart-4',[s9,s10],{
            seriesDefaults: {
                renderer:$.jqplot.DonutRenderer,
                shadow: false,
                rendererOptions:{
                    sliceMargin: 1,
                    dataLabels:'label'
                }
            },
            seriesColors: ["#FF9000","#006CC6"],
            series:[
                    {rendererOptions: {diameter: 125, innerDiameter:-25,startAngle: 180}},
                    {rendererOptions: {diameter: 250, innerDiameter:-125,startAngle: -90, showDataLabels:true}}
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
                marginTop: '28px'
                    }
        });
 });