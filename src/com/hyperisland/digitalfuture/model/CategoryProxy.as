package com.hyperisland.digitalfuture.model
{
	import com.hyperisland.digitalfuture.controller.LoadCategoriesCommand;
	import com.hyperisland.digitalfuture.model.business.XMLLoaderDelegate;
	import com.hyperisland.digitalfuture.model.vo.CategoryVO;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class CategoryProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "com.hyperisland.digitalfuture.model.CategoryProxy";
		public static const XMLNAME:String = "http://www.2sites.be/cas/hypercas/wp-content/uploads/presentation/data/categories.xml";
		
		private var _categories:Array;
		private var _command:LoadCategoriesCommand;
		private var _debugger:MonsterDebugger;
		
		public function CategoryProxy(name:String = NAME)
		{
			super(name);
			_debugger = new MonsterDebugger();
			MonsterDebugger.trace(this, 'Debugger in CategoryProxy registered');
		}
		
		public function get categories():Array
		{
			return _categories;
		}
		
		public function set categories(value:Array):void
		{
			_categories = value;
		}
		
		public function loadCategories(command:LoadCategoriesCommand):void
		{
			_command = command;
			var xmlDelegate:XMLLoaderDelegate = new XMLLoaderDelegate(XMLNAME, onXMLResult, onXMLFault);
			xmlDelegate.loadXML();
		}
		
		public function onXMLResult(e:Event):void
		{
			_categories = new Array();
			var categoriesLoader:URLLoader = URLLoader(e.target);
			var categoriesXML:XML = new XML(categoriesLoader.data);
			var categoriesItems:XMLList = categoriesXML.category;
			
			for(var i:int = 0 ; i < categoriesItems.length() ; i++)
			{
				var categoryXML:XML = categoriesItems[i];
				var categoryVO:CategoryVO = new CategoryVO();
				categoryVO.id_number = categoryXML.number;
				categoryVO.name = categoryXML.name;
				trace(categoryVO.name);
				_categories.push(categoryVO);
			}
			_command.categoriesLoaded();
			
		}
		
		public function onXMLFault(e:IOErrorEvent):void
		{
			var errorText:String = "Unable to load the context-XML in com.hyperisland.digitalfuture.model.CategoryProxy";
			trace(errorText);
			MonsterDebugger.trace(this, errorText, MonsterDebugger.COLOR_ERROR);
		}
		
	}
}