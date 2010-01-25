package com.hyperisland.digitalfuture.view.components
{
	import com.hyperisland.digitalfuture.model.vo.CategoryVO;
	import com.hyperisland.digitalfuture.model.vo.ContextVO;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import gs.TweenLite;
	import gs.easing.Elastic;
	
	import nl.demonsters.debugger.MonsterDebugger;

	public class Bubble extends MovieClip
	{
		public static const GRAY_COLOR:uint = 0x999999;
		
		private static const MIN_RADIUS:int = 500;
		private static const MAX_RADIUS:int = 5000;
		private static const GROW_RATIO:int = 30;
		
		
		private var _taglineComponent:Tagline;
		private var _circle:MovieClip;

		private var _tagline:String;
		private var _category:CategoryVO;
		private var _context:ContextVO;

		private var _color:uint;
		private var _size:int;
		private var _angle:Number;
		private var _angleAdd:Number;
		private var _radius:Number;
		private var _circleCenterX:Number;
		private var _circleCenterY:Number;
		private var _debugger:MonsterDebugger;
		
		public function Bubble(tagline:String, size:int, category:CategoryVO, context:ContextVO)
		{
			super();
			
			_tagline = tagline;
			_category = category;
			_context = context;
			_color = _context.color;
			_size = size;
			_debugger = new MonsterDebugger();
			MonsterDebugger.trace(this, this);
			
			var tempAngle = Math.random();
			if(tempAngle <= 0.5) 
			{
				_angleAdd = 1;
			}
			else
			{
				_angleAdd = -1;
			}
			_angle = 0;
			
			// Draw Circle
			_circle = new MovieClip();
			_circle.graphics.beginFill(GRAY_COLOR);
			_circle.graphics.drawEllipse(0 - (_size * GROW_RATIO / 2),0 - (_size * GROW_RATIO / 2),_size * GROW_RATIO,_size * GROW_RATIO);
			_circle.graphics.endFill();
			this.addChild(_circle);
			_circle.alpha = 0.7;
			
			// Tagline
			_taglineComponent = new Tagline();
			this.addChild(_taglineComponent);
			var taglineTextField:TextField = _taglineComponent.tagline_input as TextField;
			taglineTextField.text = _tagline;
			taglineTextField.autoSize = TextFieldAutoSize.LEFT;
			_taglineComponent.background.width = taglineTextField.width;
			_taglineComponent.background.height = taglineTextField.height;
			
			_taglineComponent.x = 0;
			_taglineComponent.y = 0;
			_taglineComponent.alpha = 0;
			
			// Events
			_circle.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_circle.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		public function get circleCenterX():Number
		{
			return _circleCenterX;
		}
		
		public function set circleCenterX(value:Number):void
		{
			_circleCenterX = value;
		}
		
		public function get circleCenterY():Number
		{
			return _circleCenterY;
		}
		
		public function set circleCenterY(value:Number):void
		{
			_circleCenterY = value;
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function get tagline():String
		{
			return _tagline;
		}
		
		public function get category():CategoryVO
		{
			return _category;
		}
		
		
		public function getCategoryID():int
		{
			return _category.id_number;
		}
		
		public function getContextID():int
		{
			return _context.id;
		}
		
		public function showUp(duration:Number):void
		{
			TweenLite.from(_circle,duration, { scaleX: 0, scaleY:0, ease:Elastic.easeOut});
		}
		
		public function calculateNewAngle():Array
		{
			_angle += (0.01 * _angleAdd);
			var posX:Number = _circleCenterX + Math.cos(_angle) * _radius;
			var posY:Number = _circleCenterY + Math.sin(_angle) * _radius;
			return [posX, posY];
		}
		
		public function calculateNewAngleWithStartingPoint(startX:Number, startY:Number):Array
		{
			_angle += (0.01 * _angleAdd);
			var posX:Number = startX + Math.cos(_angle) * _radius;
			var posY:Number = startY + Math.sin(_angle) * _radius;
			return [posX, posY];
		}
		
		public function calculateRadius():void
		{
			_radius = Math.random() * 50;
		}
		
		public function changeColor(color:uint):void
		{
			TweenLite.to(_circle, 3, {tint: color});
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			_taglineComponent.alpha = 1;
			TweenLite.from(_taglineComponent, 0.5, {scaleX: 0 , scaleY: 0, ease:Elastic.easeOut});
		}
			
		private function onMouseOut(e:MouseEvent):void
		{
			TweenLite.to(_taglineComponent, 0.5, {alpha: 0});
		}
		
		 
	}
}