package com.hyperisland.digitalfuture
{
	import com.hyperisland.digitalfuture.controller.StartupCommand;
	
	import flash.display.MovieClip;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	public class ApplicationFacade extends Facade implements IFacade
	{
		// Commands
		public static const STARTUP_COMMAND					:String = "startUpCommand";
		public static const LOAD_CONTEXT_COMMAND			:String = "loadContextCommand";
		public static const LOAD_CATEGORIES_COMMAND			:String = "loadCategoriesCommand";
		public static const LOAD_STICKIES_COMMAND			:String = "loadStickiesCommand";
		// Notifications
		public static const LOAD_PAGE						:String = "loadPage";
			
		public function ApplicationFacade()
		{
			ApplicationFacade.getInstance().initializeController()
		}
		
		public static function getInstance(): ApplicationFacade 
		{            
            if (instance == null) 
			{
				instance = new ApplicationFacade();
			}
            return instance as ApplicationFacade;
        }
        
        override protected function initializeController():void
        {
        	super.initializeController();
        	
        	registerCommand(STARTUP_COMMAND, StartupCommand);
        }
        
        public function startup(flashMovie:MovieClip) :void 
        {
           sendNotification(STARTUP_COMMAND,flashMovie);
        }
		
		
	}
}