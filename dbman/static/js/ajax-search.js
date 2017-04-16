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
    $('.search-field').keydown(getSearchResults);
    $('#search-crime').change(getSearchResults);
});

function searchSuccess(data, textStatus, jqXHR){
    $('#search-results').html(data);
}
function getSearchResults(event) {
    console.log(event.target.name);
        if (event.keyCode == 13 || event.target.name == "crime") {
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
