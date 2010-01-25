package com.hyperisland.digitalfuture.controller
{
	import com.hyperisland.digitalfuture.view.ApplicationMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.async.patterns.command.AsyncCommand;

	public class ViewPrepCommand extends AsyncCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.registerMediator(new ApplicationMediator(notification.getBody()));
			
			commandComplete();
		}
		
	}
}