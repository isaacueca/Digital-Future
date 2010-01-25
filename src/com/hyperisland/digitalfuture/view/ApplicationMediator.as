package com.hyperisland.digitalfuture.view
{
	import com.hyperisland.digitalfuture.ApplicationFacade;
	import com.hyperisland.digitalfuture.view.components.Cloud;
	
	import flash.display.MovieClip;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class ApplicationMediator extends Mediator implements IMediator
	{
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// PROPERTIES
		//
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public static const NAME:String = "ApplicationMediator";
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// PUBLIC
		//
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
		public function ApplicationMediator(viewComponent:Object)
		{
			super(NAME, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationFacade.LOAD_PAGE
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case ApplicationFacade.LOAD_PAGE:
					/* TEST XML FETCHING
					trace("================ CONTEXT ================"); 
					var contextProxy:ContextProxy = facade.retrieveProxy(ContextProxy.NAME) as ContextProxy;
					for each(var contextItem:ContextVO in contextProxy.context)
					{
						trace(contextItem.name);
					}
					
					trace("================ CATEGORIES ================");
					var categoryProxy:CategoryProxy = facade.retrieveProxy(CategoryProxy.NAME) as CategoryProxy;
					for each(var categoryItem:CategoryVO in categoryProxy.categories)
					{
						trace(categoryItem.name);
					}
					
					trace("================ STICKIES ================");
					var stickyProxy:StickiesProxy = facade.retrieveProxy(StickiesProxy.NAME) as StickiesProxy;
					for each(var stickyItem:StickyVO in stickyProxy.stickies)
					{
						trace(stickyItem.tagline);
					}
					*/
					
					var cloud:Cloud = new Cloud();
					facade.registerMediator(new CloudMediator(cloud));
					digitalFuture.addChild(cloud);
					cloud.showBubbles();
				
					break;
			}
		}
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// PROTECTED
		//
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
        protected function get digitalFuture():MovieClip
		{
            return viewComponent as MovieClip
        }
		
	}
}