package
{
	import com.hyperisland.digitalfuture.ApplicationFacade;
	
	import flash.display.MovieClip;

	public class DocumentRoot extends MovieClip
	{
		public function DocumentRoot()
		{
			var facade:ApplicationFacade = ApplicationFacade.getInstance();
			facade.startup(this);
		}
		
	}
}