$(document).ready(function() 
    { 


        var contributions = [];

        $('#chart div').each(function(i, bar) {
            var contribution = parseFloat($(bar).find('.contribution').text());
            contributions.push(contribution);
        });

        function getMaxOfArray(numArray) {
            return Math.max.apply(null, numArray);
        }
        var max = getMaxOfArray(contributions);

        $('#chart div').each(function(i, bar) {
          var contribution = parseFloat($(bar).find('.contribution').text()); 
          var bar_percent = (contribution / max) * .8 * 100;
          $(bar).width(bar_percent+'%');
        });

    } 
); 
$(document).ready(function() 
    { 

       $(".agentTable").tablesorter(); 

   } 
); 
