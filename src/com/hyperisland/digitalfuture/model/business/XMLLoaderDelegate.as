package com.hyperisland.digitalfuture.model.business
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLLoaderDelegate
	{
		private var _url:String;
		private var _onResult:Function;
		private var _onFault:Function;
		
		public function XMLLoaderDelegate(url:String, resultFunction:Function, faultFunction:Function)
		{
			_url = url;
			_onResult = resultFunction;
			_onFault = faultFunction;
		}
		
		public function loadXML():void 
		{
			var request:URLRequest = new URLRequest(_url);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, _onResult);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _onFault);
			loader.load(request);
		}
	}
}