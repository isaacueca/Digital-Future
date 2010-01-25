package com.hyperisland.digitalfuture.model
{
	import com.hyperisland.digitalfuture.controller.LoadContextCommand;
	import com.hyperisland.digitalfuture.model.business.XMLLoaderDelegate;
	import com.hyperisland.digitalfuture.model.vo.ContextVO;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class ContextProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "com.hyperisland.digitalfuture.model.ContextProxy";
		private static const XMLNAME:String = "http://www.2sites.be/cas/hypercas/wp-content/uploads/presentation/data/context.xml";
		
		private var _context:Array;
		private var _command:LoadContextCommand;
		private var _debugger:MonsterDebugger;
		
		public function ContextProxy(name:String = NAME)
		{
			super(name);
			_debugger = new MonsterDebugger;
			MonsterDebugger.trace(this, 'Debugger in ContextProxy registered');
		}
		
		public function get context():Array
		{
			return _context;
		}
		
		public function set context(value:Array):void
		{
			_context = value;
		}
		
		public function loadContext(command:LoadContextCommand):void
		{
			_command = command;
			var xmlDelegate:XMLLoaderDelegate = new XMLLoaderDelegate(XMLNAME, onXMLResult, onXMLFault);
			xmlDelegate.loadXML();
		}
		
		public function onXMLResult(e:Event):void
		{
			_context = new Array();
			var contextLoader:URLLoader = URLLoader(e.target);
			var contextXML:XML = new XML(contextLoader.data);
			var contextItems:XMLList = contextXML.context;
			
			for(var i:int = 0 ; i < contextItems.length() ; i++)
			{
				var contextItemXML:XML = contextItems[i];
				var contextVO:ContextVO = new ContextVO();
				contextVO.id = contextItemXML.id;
				contextVO.name = contextItemXML.name;
				contextVO.color = contextItemXML.color;
				_context.push(contextVO);
			}
			_command.contextLoaded();
		}
		
		public function onXMLFault(e:IOErrorEvent):void
		{
			var errorText:String = "Unable to load the context-XML in com.hyperisland.digitalfuture.model.ContextProxy";
			trace(errorText);
			MonsterDebugger.trace(this, errorText, MonsterDebugger.COLOR_ERROR);
		}
		
		
		
		
		
	}
}