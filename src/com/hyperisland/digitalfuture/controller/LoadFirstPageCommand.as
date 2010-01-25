package com.hyperisland.digitalfuture.controller
{
	import com.hyperisland.digitalfuture.ApplicationFacade;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.async.patterns.command.AsyncCommand;

	public class LoadFirstPageCommand extends AsyncCommand
	{
		public override function execute(notification:INotification):void
		{
			sendNotification(ApplicationFacade.LOAD_PAGE);
			commandComplete();
		}
	}
}