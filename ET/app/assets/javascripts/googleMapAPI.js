$(document).ready(function startFunc(){
    //getLocation();
});

var gLatLngs;
function getLocation(LatLngs){
    gLatLngs = LatLngs;
    var message = "get your potition";
    document.getElementById("area_name").innerHTML = message;

    if(navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(successCallback,errorCallback);
    } else {
        message = "this Browser do not use GeolocationAPI";
        document.getElementById("area_name").innerHTML = message;
    }
}
function successCallback(pos) {
    var Potition_latitude  = pos.coords.latitude;
    var Potition_longitude = pos.coords.longitude;

    initializeGoogleMap(Potition_latitude,Potition_longitude);
}

function errorCallback(srror) {
    var message = "not available potition";
    document.getElementById("area_name").iinerHTML = message;
}

function initializeGoogleMap(x,y) {
    var useragent = navigator.userAgent;
    document.getElementById("area_name").innerHTML = 'fetch google map';
    
    var myLatlng = new google.maps.LatLng(x,y);
    var mapOptions = {
        zoom: 16,
        center: myLatlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    
    var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
    var marker = new google.maps.Marker({
        position: myLatlng,
        draggable:true,
        map: map
    });
    
    //先にマップをクリックした時の処理
    google.maps.event.addListener(map,'click',
                                  function(event){
                                      if(marker){marker.setMap(null)};
                                      myLatlng = event.latLng;
                                      marker = new google.maps.Marker({
                                          position:event.latLng,
                                          draggable:true,
                                          map: map
                                      });
                                      google.maps.event.addListener(marker,'dragend',
                                                                    function(event){
                                                                        infotable(marker.getPosition().lat(),
                                                                                  marker.getPosition().lng());
                                                                        getAreaName(event.latLng);
                                                                    });
                                      infotable(marker.getPosition().lat(),
                                                marker.getPosition().lng());
                                      getAreaName(event.latLng);
                                  });
    
    //先にマーカードラッグが発生した場合の処理
    google.maps.event.addListener(marker,'dragend',
                                  function(event){
                                      google.maps.event.addListener(map,'click',
                                                                    function(event){
                                                                        if(marker){marker.setMap(null)};
                                                                        myLatlng = event.latLng;
                                                                        marker = new google.maps.Marker({
                                                                            position:event.latLng,
                                                                            draggable:true,
                                                                            map: map
                                                                        });
                                                                        google.maps.event.addListener(marker,'dragend',
                                                                                                      function(event){
                                                                                                          infotable(marker.getPosition().lat(),
                                                                                                                    marker.getPosition().lng());
                                                                                                          getAreaName(event.latLng);
                                                                                                      });
                                                                        infotable(marker.getPosition().lat(),
                                                                                  marker.getPosition().lng());
                                                                        getAreaName(event.latLng);
                                                                    });
                                      infotable(marker.getPosition().lat(),
                                                marker.getPosition().lng());
                                      getAreaName(event.latLng);
                                  });
    
    infotable(marker.getPosition().lat(),
              marker.getPosition().lng());
    getAreaName(myLatlng);
    
    console.log(gLatLngs);
    var MakerPoints = [];
    for(var i=0;i<gLatLngs.length;i++) {
        console.log(i);
        MakerPoints[i] = new google.maps.Marker({
            position: new google.maps.LatLng(gLatLngs[i]['lat'],gLatLngs[i]['lng']),
            map: map
        });
    }
}
function infotable(lat,lng,level){
    document.getElementById('id_lat').innerHTML = lat;
    document.getElementById('id_lng').innerHTML = lng;
}

function getAreaName(latLngNow){
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'location': latLngNow},
                     function(results,status){
                         if(status == google.maps.GeocoderStatus.OK){
                             document.getElementById('area_name').innerHTML = results[0].formatted_address.replace(/^日本, /, '');
                             
                         } else {
                             document.getElementById("area_name").innerHTML = 'error';
                         }
                     });
}
