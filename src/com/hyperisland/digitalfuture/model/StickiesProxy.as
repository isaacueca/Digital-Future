package com.hyperisland.digitalfuture.model
{
	import com.hyperisland.digitalfuture.controller.LoadStickiesCommand;
	import com.hyperisland.digitalfuture.model.business.XMLLoaderDelegate;
	import com.hyperisland.digitalfuture.model.vo.StickyVO;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class StickiesProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "com.hyperisland.digitalfuture.model.StickiesProxy";
		public static const XMLNAME:String = "http://www.2sites.be/cas/hypercas/wp-content/uploads/presentation/data/stickies.xml";
		
		private var _stickies:Array;
		private var _command:LoadStickiesCommand;
		private var _debugger:MonsterDebugger;
		
		public function StickiesProxy(name:String = NAME)
		{
			super(name);
			_debugger = new MonsterDebugger();
			MonsterDebugger.trace(this, 'Debugger in StickiesProxy registered');
		}
		
		public function get stickies():Array
		{
			return _stickies;
		}
		
		public function set stickies(value:Array):void
		{
			_stickies = value;
		}
		
		public function loadStickies(command:LoadStickiesCommand):void
		{
			_command = command;
			var xmlDelegate:XMLLoaderDelegate = new XMLLoaderDelegate(XMLNAME, onXMLResult, onXMLFault);
			xmlDelegate.loadXML();
		}
		
		public function onXMLResult(e:Event):void
		{
			_stickies = new Array();
			var stickiesLoader:URLLoader = URLLoader(e.target);
			var stickiesXML:XML = new XML(stickiesLoader.data);
			var stickies:XMLList = stickiesXML.sticky;
			
			for(var i:int = 0 ; i < stickies.length() ; i++)
			{
				var stickyXML:XML = stickies[i];
				var stickyVO:StickyVO = new StickyVO();
				stickyVO.id = stickyXML.id;
				stickyVO.tagline = stickyXML.tagline;
				stickyVO.category = stickyXML.category;
				stickyVO.context = stickyXML.context;
				stickyVO.size = stickyXML.size;
				_stickies.push(stickyVO);
			}
			_command.stickiesLoaded();
			
		}
		
		public function onXMLFault(e:IOErrorEvent):void
		{
			var errorText:String = "Unable to load the context-XML in com.hyperisland.digitalfuture.model.StickiesProxy";
			trace(errorText);
			MonsterDebugger.trace(this, errorText, MonsterDebugger.COLOR_ERROR);
		}
	}
}