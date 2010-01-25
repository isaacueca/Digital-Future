package com.hyperisland.digitalfuture.view.components
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	
	import gs.TweenLite;

	public class Cloud extends MovieClip
	{
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// PROPERTIES
		//
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        private static const BUBBLE_POPUP_MAX_DURATION:int = 5; // sec
        
        private var _bubbles:Array;
        private var _categories:Array;
        private var _categoryTitles:Array;
        private var _contexts:Array;
        private var _timer:Timer;
        private var _legendButton:LegendButton;
        private var _legend:Legend;
        
        private var _step1:StepButton;
        private var _step2:StepButton;
        private var _step3:StepButton;
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// CONSTRUCTOR
		//
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
		
		public function Cloud()
		{
			super();
			_bubbles = new Array();
			_categories = new Array();
			_categoryTitles = new Array();
			_contexts = new Array();
			_timer = new Timer(30);
			_timer.addEventListener(TimerEvent.TIMER, onTimerHit);
			
			_step1 = new StepButton();
			_step1.stepnumber.text = '1';
			_step1.stepnumber.autoSize = TextFieldAutoSize.CENTER;
			_step2 = new StepButton();
			_step2.stepnumber.text = '2';
			_step2.stepnumber.autoSize = TextFieldAutoSize.CENTER;
			_step3 = new StepButton(); 
			_step3.stepnumber.text = '3';
			_step3.stepnumber.autoSize = TextFieldAutoSize.CENTER;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// PUBLIC
		//
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        public function get bubbles():Array
        {
        	return _bubbles;
        }
        
        public function set bubbles(value:Array):void
        {
        	_bubbles = value;
        }
        
        public function get categories():Array
        {
        	return _categories;
        }
        
        public function set categories(value:Array):void
        {
        	_categories = value;
        }
        
        public function set categoryTitles(value:Array):void
        {
        	_categoryTitles = value;
        }
        
        public function get contexts():Array
        {
        	return _contexts;
        }
        
        public function set contexts(value:Array):void
        {
        	_contexts = value;
        }
        
        public function addBubble(bubble:Bubble):void
        {
        	_bubbles.push(bubble);
        }
        
        public function showBubbles():void
        {
        	// Add categories
        	var index:int = 0;
        	for each(var categoryTitle:CategoryTitle in _categoryTitles)
        	{
        		this.addChild(categoryTitle);
        		if(index == 1 || index == 2)
        		{
        			categoryTitle.y = (this.stage.stageHeight / 2) - (categoryTitle.height / 2);
        			categoryTitle.x = index == 1 ? this.stage.stageWidth / 4 : (this.stage.stageWidth / 4) * 3;
        			categoryTitle.x -= 200;
        		}
        		else
        		{
        			categoryTitle.x = (this.stage.stageWidth / 2) - (categoryTitle.width / 2);
        			categoryTitle.y = index == 0 ? this.stage.stageHeight / 5 : (this.stage.stageHeight / 7) * 5;
        		}
        		categoryTitle.alpha = 0;
        		index++;
        	}
        	
        	
        	// Add Bubbles
        	trace('Number of bubbles' + _bubbles.length);
        	for each(var bubble:Bubble in _bubbles)
        	{
        		// Find random place
        		this.addChild(bubble);
        		bubble.circleCenterX = 100 + (Math.random() * (this.stage.stageWidth - 200));
        		bubble.circleCenterY = 100 + (Math.random() * (this.stage.stageHeight - 200));
        		bubble.calculateRadius();
        		var position:Array = bubble.calculateNewAngle();
        		bubble.x = position[0];
        		bubble.y = position[1];
        		bubble.showUp(BUBBLE_POPUP_MAX_DURATION * Math.random());
        		_timer.start();
        	}	
        	
        	// Add legend button
//        	this.addChild(_legendButton);
//			_legendButton.y = this.stage.stageHeight - 50;
//			_legendButton.x = 30;
//			_legendButton.buttonMode = true;
			
			_legend = new Legend(_contexts);
			this.addChild(_legend);
        	_legend.x = 20;
        	_legend.y = this.stage.stageHeight - _legend.height - 50;
        	_legend.alpha = 0;
			
			// Show steps
			var buttonY = this.stage.stageHeight - 50;
			var currentX = this.stage.stageWidth - 100 - 60;
			this.addChild(_step1);
			_step1.x = currentX;
			_step1.buttonMode = true;
			currentX -= _step2.width - 60;
			this.addChild(_step2);
			_step2.x = currentX;
			_step2.buttonMode = true;
			currentX -= _step3.width - 60;
			this.addChild(_step3);
			_step3.x = currentX;
			_step3.buttonMode = true;
			_step1.y = _step2.y = _step3.y = buttonY;
			
			_step1.addEventListener(MouseEvent.CLICK, onStep1Click);
			_step2.addEventListener(MouseEvent.CLICK, onStep2Click);
			_step3.addEventListener(MouseEvent.CLICK, onStep3Click);
        }
        
        private function onStep1Click(e:MouseEvent):void
        {
        	for each(var categoryTitle:CategoryTitle in _categoryTitles)
        	{
        		TweenLite.to(categoryTitle, 3, {alpha: 0});
        	}
        	TweenLite.to(_legend, 1, {alpha: 0});
        	for each(var bubble:Bubble in _bubbles)
        	{
        		bubble.changeColor(Bubble.GRAY_COLOR);
        	}
        	_timer.start();
        }
        
        private function onStep2Click(e:MouseEvent):void
        {
        	for each(var categoryTitle:CategoryTitle in _categoryTitles)
        	{
        		TweenLite.to(categoryTitle, 3, {alpha: 0});
        	}
        	TweenLite.to(_legend, 1, {alpha: 1});
        	for each(var bubble:Bubble in _bubbles)
        	{
        		bubble.changeColor(bubble.color);
        	}
        	_timer.start();
        }
        
        private function onStep3Click(e:MouseEvent):void
        {
        	for each(var colorbubble:Bubble in _bubbles)
        	{
        		colorbubble.changeColor(colorbubble.color);
        	}
        	TweenLite.to(_legend, 1, {alpha: 1});
        	
        	
        	// Show titles
        	for each(var categoryTitle:CategoryTitle in _categoryTitles)
        	{
        		TweenLite.to(categoryTitle, 3, {alpha: 1});
        	}
        	
        	
        	for each(var bubble:Bubble in _bubbles)
        	{
        		_timer.stop();
        		
        		// Find area for center points
        		var bubbleCategoryTitle:CategoryTitle = _categoryTitles[bubble.category.id_number - 1];
        		var newCenterPointX:Number = bubbleCategoryTitle.x + (Math.random() * bubbleCategoryTitle.width) + (Math.random() * 300) - 150;
        		var newCenterPointY:Number = bubbleCategoryTitle.y + (Math.random() * bubbleCategoryTitle.height) + (Math.random() * 300) - 150;
        		
        		var position:Array = bubble.calculateNewAngleWithStartingPoint(newCenterPointX, newCenterPointY);
        		// Move bubbles to new point
        		TweenLite.to(bubble, 3, {x:position[0], y:position[1], onComplete: function(){
        			bubble.circleCenterX = newCenterPointX;
        			bubble.circleCenterY = newCenterPointY;
					//_timer.start();
        		}});
        	}
        }
        
        private function onTimerHit(e:TimerEvent):void
        {
        	for each(var bubble:Bubble in _bubbles)
			{
				var position:Array = bubble.calculateNewAngle();
				bubble.x = position[0];
				bubble.y = position[1];
			}
        }
        
        

	}
}