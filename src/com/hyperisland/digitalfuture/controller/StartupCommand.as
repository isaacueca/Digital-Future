package com.hyperisland.digitalfuture.controller
{
	import org.puremvc.async.patterns.command.AsyncMacroCommand;

	public class StartupCommand extends AsyncMacroCommand
	{
		override protected function initializeAsyncMacroCommand():void
		{
			addSubCommand(ModelPrepCommand);
			addSubCommand(ViewPrepCommand);
			addSubCommand(LoadContextCommand);
			addSubCommand(LoadCategoriesCommand);
			addSubCommand(LoadStickiesCommand);
			addSubCommand(LoadFirstPageCommand);
		}
		
	}
}