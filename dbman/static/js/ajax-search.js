$(function(){
    $.ajax({
        type: "GET",
        url: "/search/getCrimeList",
        data: {
            'crime' : $('#search-crime').val(),
            'csrfmiddlewaretoken' : $("input[name=csrfmiddlewaretoken]").val()
        },
        success: function(data, textStatus, jqXHR){
           $('#search-crime').append(data);
        },
        dataType: 'html'
    });
    $('.search-field').keyup(getSearchResults);
    $('#search-crime').change(getSearchResults);
});

function searchSuccess(data, textStatus, jqXHR){
    $('#search-results').html(data);
}
function getSearchResults(event) {
    console.log(event.target.name);
        // if (event.keyCode == 13 || event.target.name == "crime") {
            
        // }
    if ($('#search-reportNum').val() == '' && $('#search-crime').val() == ''){
        $('#search-results').html("<p>Fill in one or more of the above fields.</p>")
    } else {
        
            $.ajax({
                type: "POST",
                url: "/search/",
                data: {
                    'reportNum' : $('#search-reportNum').val(),
                    'crime' : $('#search-crime').val(),
                    'csrfmiddlewaretoken' : $("input[name=csrfmiddlewaretoken]").val()
                },
                success: searchSuccess,
                dataType: 'html'

            });
    }
    }
