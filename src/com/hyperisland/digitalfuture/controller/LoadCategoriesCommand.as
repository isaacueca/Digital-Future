package com.hyperisland.digitalfuture.controller
{
	import com.hyperisland.digitalfuture.model.CategoryProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.async.patterns.command.AsyncCommand;

	public class LoadCategoriesCommand extends AsyncCommand
	{
		override public function execute(notification:INotification):void
		{
			var categoryProxy:CategoryProxy = facade.retrieveProxy(CategoryProxy.NAME) as CategoryProxy;
			categoryProxy.loadCategories(this);
		}
		
		public function categoriesLoaded():void
		{
			commandComplete();
		}
		
	}
}