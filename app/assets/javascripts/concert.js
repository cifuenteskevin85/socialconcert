$(function() {
  $( "#datepicker" ).datepicker();
  $( "#datepicker" ).datepicker("option", "dateFormat",'yy-mm-dd' );
  $('#concert_name_art').autocomplete({
    minLength: 1,
    focus: function() { return false; },
    source: function(request, response) {
      SC.get('/users', { q: request }, function(artists) {
        if(artists.length == 0) return;
        response( $.map( artists, function( item ) {
            return {
                label: item.full_name + ' - ' + item.city + '(' + item.country + ')',
                value: item.full_name,
                id: item.id
            }
        }));
      });
    },
    select: function(event, song) {
      $('#concert_name_art').val(song.item.id);
      SC.get('/users/' + song.item.id + '/tracks', function(tracks) {
        var select = '';
        for(t in tracks) {
          select += '<option value="' + tracks[t].permalink_url + '">' + tracks[t].title + '</option>';
        } 
        $('#concert_song').html(select);
      });
    }
  }); 
});