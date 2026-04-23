var wms_layers = [];


        var lyr_GoogleSatellite_0 = new ol.layer.Tile({
            'title': 'Google Satellite',
            'type':'base',
            'opacity': 1.000000,
            
            
            source: new ol.source.XYZ({
            attributions: '&nbsp;&middot; <a href="https://www.google.at/permissions/geoguidelines/attr-guide.html">Map data ©2015 Google</a>',
                url: 'https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}'
            })
        });
var format_OSMPermukimanSleman_1 = new ol.format.GeoJSON();
var features_OSMPermukimanSleman_1 = format_OSMPermukimanSleman_1.readFeatures(json_OSMPermukimanSleman_1, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_OSMPermukimanSleman_1 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_OSMPermukimanSleman_1.addFeatures(features_OSMPermukimanSleman_1);
var lyr_OSMPermukimanSleman_1 = new ol.layer.Vector({
                declutter: false,
                source:jsonSource_OSMPermukimanSleman_1, 
                style: style_OSMPermukimanSleman_1,
                popuplayertitle: 'OSM Permukiman Sleman',
                interactive: true,
                title: '<img src="styles/legend/OSMPermukimanSleman_1.png" /> OSM Permukiman Sleman'
            });

lyr_GoogleSatellite_0.setVisible(true);lyr_OSMPermukimanSleman_1.setVisible(true);
var layersList = [lyr_GoogleSatellite_0,lyr_OSMPermukimanSleman_1];
lyr_OSMPermukimanSleman_1.set('fieldAliases', {'ID Lengkap': 'ID Lengkap', 'ID OSM': 'ID OSM', 'Tipe OSM': 'Tipe OSM', 'Bangunan': 'Bangunan', 'Kabupaten': 'Kabupaten', 'Negara': 'Negara', 'Kalurahan': 'Kalurahan', 'Kapanewon': 'Kapanewon', 'Provinsi': 'Provinsi', 'Keliling': 'Keliling', 'Luas': 'Luas', });
lyr_OSMPermukimanSleman_1.set('fieldImages', {'ID Lengkap': 'TextEdit', 'ID OSM': 'TextEdit', 'Tipe OSM': 'TextEdit', 'Bangunan': 'TextEdit', 'Kabupaten': 'TextEdit', 'Negara': 'TextEdit', 'Kalurahan': 'TextEdit', 'Kapanewon': 'TextEdit', 'Provinsi': 'TextEdit', 'Keliling': 'TextEdit', 'Luas': 'TextEdit', });
lyr_OSMPermukimanSleman_1.set('fieldLabels', {'ID Lengkap': 'inline label - visible with data', 'ID OSM': 'inline label - visible with data', 'Tipe OSM': 'inline label - visible with data', 'Bangunan': 'inline label - visible with data', 'Kabupaten': 'inline label - visible with data', 'Negara': 'inline label - visible with data', 'Kalurahan': 'inline label - visible with data', 'Kapanewon': 'inline label - visible with data', 'Provinsi': 'inline label - visible with data', 'Keliling': 'inline label - visible with data', 'Luas': 'inline label - visible with data', });
lyr_OSMPermukimanSleman_1.on('precompose', function(evt) {
    evt.context.globalCompositeOperation = 'normal';
});