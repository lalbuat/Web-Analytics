// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require_directory.


$(document).ready(function(){

	$(".dropdown").show();

	$("#setting").on("hover",function(){
		$(".dropdown").toggle();
	});

	$("#embedcodediv").hide();
	console.log("1");

	$("#embedcodediv .close").on("click",function(){
		$("#embedcodediv").hide();
		return false;
	});



	$("#seeAnalytics").hide();

	$("#seeAnalytics .close").on("click",function(){
		$("#seeAnalytics").hide();
		return false;
	});

	$("#seeAnalytics").on("click",function(e){
		if (e.target.className != "analyticsPallete") {
			$("#seeAnalytics").hide();
		};
	});

	$("#websiteRegistration").hide();

});


function takeEmbed(wid){
	
	var txt = "<script>jastraker = {};";
	txt += "jastraker.wid = "+wid;
	txt +="</script>";
	txt += "<script src='http://localhost/javascript/traker.js'>";

	$("#embedcodediv textarea").text(txt);
	$("#embedcodediv").show();
	console.log("Alpha");
	return false;
}

function giveAnalytics(url,tracking_id){
	var url = url
	var tracking_id = tracking_id;

	var options = {
			chart: {
	            type: 'line'
	        },
			tooltip:{
				shared: true,
				crosshairs: true
			},
	    	title:{
	    		text:'Visits at your site'
	    	},
	    	yAxis:{
	    		title:{
	    			text:'Number of views'
	    		}
	    	},
	        xAxis: {
	        	title:{
	        		text:'Time'
	        	},
	        	categories: [],
	        },

	        series: []
	    };

	$.ajax(url+tracking_id, {
		success: function(data){
			var lines = data.split('\n');

			var series = {
				name:'Views',
				data:[]
			};

			$.each(lines, function(lineNo,line){

				var items = line.split(',');

				if(lineNo > 0){

					$.each(items, function(itemNo, item){
						console.log(itemNo+"---------"+item);
						if(itemNo == 0){
							console.log("pushing to X axis----"+item);
							options.xAxis.categories.push(item);	
						} 
						else if(itemNo == 1)
							series.data.push(parseFloat(item));
					});

				}

			});

			options.series.push(series);

			console.log(options);

			$('#graph').highcharts(options);
		}
	});
	$("#seeAnalytics").show();
}

console.log("P");
