package com.hyperisland.digitalfuture.view
{
	import com.hyperisland.digitalfuture.model.CategoryProxy;
	import com.hyperisland.digitalfuture.model.ContextProxy;
	import com.hyperisland.digitalfuture.model.StickiesProxy;
	import com.hyperisland.digitalfuture.model.vo.CategoryVO;
	import com.hyperisland.digitalfuture.model.vo.ContextVO;
	import com.hyperisland.digitalfuture.model.vo.StickyVO;
	import com.hyperisland.digitalfuture.view.components.Bubble;
	import com.hyperisland.digitalfuture.view.components.Cloud;
	
	import flash.text.TextFieldAutoSize;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class CloudMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "com.hyperisland.digitalfuture.view.CloudMediator";
		
		public function CloudMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
        
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		override public function handleNotification(notification:INotification):void
		{
		}
		
		override public function onRegister():void
		{
			// Get XML-information
			var contextProxy:ContextProxy = facade.retrieveProxy(ContextProxy.NAME) as ContextProxy;
			cloud.contexts = contextProxy.context;
			
			var categoryProxy:CategoryProxy = facade.retrieveProxy(CategoryProxy.NAME) as CategoryProxy;
			cloud.categories = categoryProxy.categories;
			
			var categoryList:Array = new Array();
			for each(var categoryVO:CategoryVO in categoryProxy.categories)
			{
				var categoryTitle:CategoryTitle = new CategoryTitle();
				categoryTitle.categorytitle.text = categoryVO.name;
				categoryTitle.categorytitle.autoSize = TextFieldAutoSize.LEFT;
				categoryList.push(categoryTitle);				
			}
			cloud.categoryTitles = categoryList;
			
			
			var stickyProxy:StickiesProxy = facade.retrieveProxy(StickiesProxy.NAME) as StickiesProxy;
			// Make bubbles
			var stickies:Array = stickyProxy.stickies;
			for each(var sticky:StickyVO in stickies)
			{
				var stickyCategory:CategoryVO = null;
				for each(var category:CategoryVO in cloud.categories)
				{
					if(category.id_number == sticky.category)
					{
						stickyCategory = category;
					}
				}
				var stickyContext:ContextVO = null;
				for each(var context:ContextVO in cloud.contexts)
				{
					if(context.id == sticky.context)
					{
						stickyContext = context;
					}
				}
				var bubble:Bubble = new Bubble(sticky.tagline, sticky.size, stickyCategory, stickyContext);
				cloud.addBubble(bubble);
			}
		}
		
		protected function get cloud():Cloud
		{
			return viewComponent as Cloud;
		}
	}
}