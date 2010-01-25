package com.hyperisland.digitalfuture.controller
{
	import com.hyperisland.digitalfuture.model.CategoryProxy;
	import com.hyperisland.digitalfuture.model.ContextProxy;
	import com.hyperisland.digitalfuture.model.StickiesProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.async.patterns.command.AsyncCommand;

	public class ModelPrepCommand extends AsyncCommand
	{
		override public function execute(notification:INotification):void
		{
			// Register proxies here
			facade.registerProxy(new ContextProxy(ContextProxy.NAME));
			facade.registerProxy(new CategoryProxy(CategoryProxy.NAME));
			facade.registerProxy(new StickiesProxy(StickiesProxy.NAME));
			commandComplete();
		}
		
	}
}