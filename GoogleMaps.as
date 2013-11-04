package
	{
		import flash.display.Stage;
		import flash.display.MovieClip;
		import flash.net.URLLoader;
		import flash.net.URLRequest;
		import flash.events.Event;
		import flash.geom.Point;
		//importação das Classes do Google Maps
		import com.google.maps.LatLng;
		import com.google.maps.Map;
		import com.google.maps.MapEvent;
		import com.google.maps.MapType;
		import com.google.maps.LatLngBounds;
		import com.google.maps.MapMouseEvent;
		import com.google.maps.InfoWindowOptions;
		import com.google.maps.controls.ZoomControl;
		import com.google.maps.controls.PositionControl;
		import com.google.maps.controls.MapTypeControl;
		import com.google.maps.overlays.MarkerOptions;
		import com.google.maps.overlays.Marker;
		import com.google.maps.styles.FillStyle;
		import com.google.maps.styles.StrokeStyle;		
		
		
		public class GoogleMaps extends MovieClip
			{
					public var urlXml:URLRequest=new URLRequest("localizacoes.xml");
					public var carregadorXml:URLLoader=new URLLoader(urlXml);
					public var localXml:XML = new XML();
					public var map:Map;
			
					public function GoogleMaps():void
						{
							carregadorXml.addEventListener(Event.COMPLETE, montalocais);
						}
				
		public function montalocais(evt:Event):void
						{
							localXml=XML(carregadorXml.data);
							map = new Map();
							map.key = "ABQIAAAAhNR5XRuv8JoUe_TTku2F1hQTHXKORVLD73iSmEksCNT020OBexS2W_QfUTtQ8M-kAF5sjfzeCyW-MQ";
								
							map.sensor = "false";
							map.setSize(new Point(720, 480));
							map.addEventListener(MapEvent.MAP_READY, onMapReady);
							addChild(map);
							
						}
						
						
						
	function onMapReady(event:MapEvent):void 
				{
					map.setCenter(new LatLng(localXml.local[0].@latitude, localXml.local[0].@longitude), 13);
					map.addControl(new ZoomControl());
					map.addControl(new PositionControl());
					map.addControl(new MapTypeControl());
					
					for (var i:uint= 0; i< localXml.local.length(); i++)
						{
								if(isNaN(localXml.local[i].@latitude) || isNaN(localXml.local[i].@longitude))
									{
										trace("não é numero")
									}
								else
									{
										var name:String = localXml.local[i].@nome;
										var address:String = localXml.local[i].@endereco;
										var latlng:LatLng = new LatLng(localXml.local[i].@latitude, localXml.local[i].@longitude);
										var marker:Marker = createMarker(latlng, name, address);
										map.addOverlay(marker);
										trace(i);
									}
						}					
				}
						
						
						
						
	  function createMarker(latlng:LatLng, name:String, address:String): Marker 
					{
						var marker:Marker = new Marker(latlng, new MarkerOptions
							(
											{
												strokeStyle: new StrokeStyle({color: 0xfece01}),
												fillStyle: new FillStyle({color: 0x5aba52, alpha: 0.8}),
												radius: 12,
												hasShadow: true
											}
									  ));
						var html:String = "<b>" + name + "</b> <br/>" + address;
					
						marker.addEventListener(MapMouseEvent.CLICK, function(e:MapMouseEvent):void 
							{
								marker.openInfoWindow(new InfoWindowOptions({contentHTML:html}));
							}
					);
					return marker;
				 } 
						
						

			}	
	}




