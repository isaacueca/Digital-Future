package com.hyperisland.digitalfuture.controller
{
	import com.hyperisland.digitalfuture.model.ContextProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.async.patterns.command.AsyncCommand;

	public class LoadContextCommand extends AsyncCommand
	{
		override public function execute(notification:INotification):void
		{
			var contextProxy:ContextProxy = facade.retrieveProxy(ContextProxy.NAME) as ContextProxy;
			contextProxy.loadContext(this);
		}
		
		public function contextLoaded():void
		{
			commandComplete();
		}
	}
}