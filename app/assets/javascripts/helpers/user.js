function UserZoomLevel(map) {
  map.on('zoomend',function(e){
    var zl  = map.getZoom();
    localStorage.setItem('UserZoomLevel',zl);
    console.log(e.target.getZoom());
    console.log(e.target.getCenter());
    var newUrl = addParam(window.location.href, "zoom", zl);
    console.log(newUrl);
    window.history.pushState(null, document.title, newUrl);
  });
  map.on('moveend',function(e){
    console.log(e.target.getCenter());
    var latlng = e.target.getCenter();
    var newUrl = addParam(window.location.href, "lat", latlng.lat);
    newUrl = addParam(newUrl, "lon", latlng.lng);
    console.log(newUrl);
    window.history.pushState(null, document.title, newUrl);
  });
}
function addParam(currentUrl,key,val) {
    var url = new URL(currentUrl);
    url.searchParams.set(key, val);
    return url.href;
}

function UserMapBounds(map) {
  map.on('dragend',function(e){
    var bounds = map.getBounds();
    var northeast = bounds.getNorthEast();
    var southwest = bounds.getSouthWest();
    localStorage.setItem('UserMapBoundsNE',northeast['lat']+','+northeast['lng']);
    localStorage.setItem('UserMapBoundsSW',southwest['lat']+','+southwest['lng']);

  });

}