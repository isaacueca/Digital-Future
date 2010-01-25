package com.hyperisland.digitalfuture.controller
{
	import com.hyperisland.digitalfuture.model.StickiesProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.async.patterns.command.AsyncCommand;

	public class LoadStickiesCommand extends AsyncCommand
	{
		override public function execute(notification:INotification):void
		{
			var stickiesProxy:StickiesProxy = facade.retrieveProxy(StickiesProxy.NAME) as StickiesProxy;
			stickiesProxy.loadStickies(this);
		}
		
		public function stickiesLoaded():void
		{
			commandComplete();
		}
	}
}