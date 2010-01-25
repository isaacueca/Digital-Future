package com.hyperisland.digitalfuture.view.components
{
	import com.hyperisland.digitalfuture.model.vo.ContextVO;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import gs.TweenLite;

	public class Legend extends MovieClip
	{
		private var _context:Array;
		
		public function Legend(context:Array)
		{
			super();
			
			_context = context;
			
			var startY = 0;
			var currentX = 20;
			for each(var contextItem:ContextVO in _context)
			{
				var legendItem:LegendItem = new LegendItem();
				TweenLite.to(legendItem.contextColor, 1, {tint: contextItem.color});
				legendItem.contextName.text = contextItem.name;
				legendItem.contextName.autoSize = TextFieldAutoSize.LEFT;
				legendItem.mouseover.width = legendItem.contextName.width;
				legendItem.buttonMode = true; 
				this.addChild(legendItem);
				legendItem.x = currentX;
				legendItem.y = startY;
				startY += 25;
			}
		}
		
	}
}