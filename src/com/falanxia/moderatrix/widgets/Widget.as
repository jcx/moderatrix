// Falanxia Moderatrix.
//
// Copyright (c) 2010 Falanxia (http://falanxia.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.constants.DebugLevel;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.display.QSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;



	/**
	 * @todo Comment
	 * @todo Width & height not applied in the constructor
	 * @todo Check for children and remove them on destroy()
	 */
	public class Widget extends MorphSprite {


		/** @todo Comment */
		public static const DRAW:String = "draw";

		/** @todo Comment */
		public static var initialDebugLevel:String;

		protected static const _DEBUG_PADDING:Number = 4;

		protected static var _allWidgets:Array;

		protected var _allIdx:uint;
		protected var _config:Object;
		protected var _size:Rectangle = new Rectangle(0, 0, 0, 0);
		protected var _debugLevel:String;
		protected var _debugColor:RGBA;
		protected var _debugSpr:QSprite;
		protected var _contentSpr:QSprite;



		/** @todo Comment */
		public function Widget(config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null):void {
			if(config == null) _config = new Object();
			else _config = config;

			_debugColor = SkinManager.debugColor;

			super(_config);

			if(_config.x != undefined) this.x = _config.x;
			if(_config.y != undefined) this.y = _config.y;
			if(_config.width != undefined) this.width = _config.width;
			if(_config.height != undefined) this.height = _config.height;

			if(parent != null) parent.addChild(this);

			if(_allWidgets == null) _allWidgets = new Array();

			_allWidgets.push(this);

			_allIdx = _allWidgets.length - 1;

			_init();

			if(debugLevel == null) {
				if(initialDebugLevel != null) {
					this.debugLevel = initialDebugLevel;
				}
			}
			else this.debugLevel = debugLevel;
		}



		/** @todo Comment */
		public function destroy():void {
			_removeChildren();
		}



		/** @todo Comment */
		public static function initStage(stage:Stage):void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}



		/** @todo Comment */
		public function draw():void {
			if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
				if(!_size.isEmpty()) {
					DisplayUtils.clear(_debugSpr);
					DisplayUtils.drawRect(_debugSpr, _size, _debugColor);
					DisplayUtils.strokeBounds(_debugSpr, _size, _debugColor, 5);
				}
			}

			dispatchEvent(new Event(Widget.DRAW));
		}



		/** @todo Comment */
		override public function addChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.addChild(child);
			else out = _contentSpr.addChild(child);

			return out;
		}



		/** @todo Comment */
		override public function removeChild(child:DisplayObject):DisplayObject {
			var out:DisplayObject;

			try {
				if(_contentSpr == null && super.contains(child)) out = super.removeChild(child);
				else {
					if(_contentSpr.contains(child)) out = _contentSpr.removeChild(child);
				}
			}
			catch(err:Error) {
				// TODO: Fix me. This stinks, somewhere something here is totally wrong
			}

			return out;
		}



		/** @todo Comment */
		override public function contains(child:DisplayObject):Boolean {
			var out:Boolean;

			if(_contentSpr == null) out = super.contains(child);
			else out = _contentSpr.contains(child);

			return out;
		}



		/** @todo Comment */
		override public function swapChildrenAt(index1:int, index2:int):void {
			if(_contentSpr == null) super.swapChildrenAt(index1, index2);
			else _contentSpr.swapChildrenAt(index1, index2);
		}



		/** @todo Comment */
		override public function getChildByName(name:String):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.getChildByName(name);
			else out = _contentSpr.getChildByName(name);

			return out;
		}



		/** @todo Comment */
		override public function removeChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.removeChildAt(index);
			else out = _contentSpr.removeChildAt(index);

			return out;
		}



		/** @todo Comment */
		override public function getChildIndex(child:DisplayObject):int {
			var out:int;

			if(_contentSpr == null) out = super.getChildIndex(child);
			else out = _contentSpr.getChildIndex(child);

			return out;
		}



		/** @todo Comment */
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.addChildAt(child, index);
			else out = _contentSpr.addChildAt(child, index);

			return out;
		}



		/** @todo Comment */
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void {
			if(_contentSpr == null) super.swapChildren(child1, child2);
			else _contentSpr.swapChildren(child1, child2);
		}



		/** @todo Comment */
		override public function getChildAt(index:int):DisplayObject {
			var out:DisplayObject;

			if(_contentSpr == null) out = super.getChildAt(index);
			else _contentSpr.getChildAt(index);

			return out;
		}



		/** @todo Comment */
		override public function setChildIndex(child:DisplayObject, index:int):void {
			if(_contentSpr == null) super.setChildIndex(child, index);
			else _contentSpr.setChildIndex(child, index);
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		override public function set width(w:Number):void {
			_size.width = Math.round(w);
			_invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}



		/** @todo Comment */
		override public function get width():Number {
			return _size.width;
		}



		/** @todo Comment */
		override public function set height(h:Number):void {
			_size.height = Math.round(h);
			_invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}



		/** @todo Comment */
		override public function get height():Number {
			return _size.height;
		}



		/** @todo Comment */
		override public function get size():Rectangle {
			return _size;
		}



		/**
		 * Rescales to new size.
		 * @param rect New size as {@code Rectangle}
		 */
		override public function set size(rect:Rectangle):void {
			_size = rect;
			_invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}



		/** @todo Comment */
		public static function set allDebugLevel(value:String):void {
			for each(var i:IWidget in _allWidgets) {
				if(i != null) i.debugLevel = value;
			}
		}



		/** @todo Comment */
		override public function set x(value:Number):void {
			super.x = Math.round(value);
		}



		/** @todo Comment */
		override public function set y(value:Number):void {
			super.y = Math.round(value);
		}



		/** @todo Comment */
		public function get config():Object {
			return _config;
		}



		/** @todo Comment */
		public function set debugLevel(value:String):void {
			if(value == DebugLevel.ALWAYS) {
				_debugSpr.visible = true;

				this.removeEventListener(MouseEvent.ROLL_OVER, _onDebugOver);
				this.removeEventListener(MouseEvent.ROLL_OUT, _onDebugOut);
			}
			else {
				_debugSpr.visible = false;

				this.addEventListener(MouseEvent.ROLL_OVER, _onDebugOver, false, 0, true);
				this.addEventListener(MouseEvent.ROLL_OUT, _onDebugOut, false, 0, true);
			}

			_debugLevel = value;
		}



		/** @todo Comment */
		public function get debugLevel():String {
			return _debugLevel;
		}



		/** @todo Comment */
		public function set debugColor(value:RGBA):void {
			_debugColor = value;
			draw();
		}



		/** @todo Comment */
		public function get debugColor():RGBA {
			return _debugColor;
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		protected function _init():void {
			_addChildren();
			_invalidate();
		}



		/** @todo Comment */
		protected function _addChildren():void {
			// FIXME: For some reason _debugSpr is below _contentSpr

			_contentSpr = new QSprite({mouseEnabled:false}, this);
			_debugSpr = new QSprite({mouseEnabled:false, mouseChildren:false}, this);
		}



		/** @todo Comment */
		protected function _removeChildren():void {
			this.removeEventListener(MouseEvent.ROLL_OVER, _onDebugOver);
			this.removeEventListener(MouseEvent.ROLL_OUT, _onDebugOut);

			_allWidgets[_allIdx] = null;

			DisplayUtils.removeChildren(this, _contentSpr, _debugSpr);
		}



		/** @todo Comment */
		protected function _invalidate():void {
			addEventListener(Event.ENTER_FRAME, _onInvalidate, false, 0, true);
		}



		/* ★ EVENT LISTENERS ★ */


		/** @todo Comment */
		protected function _onDebugOver(event:MouseEvent):void {
			_debugSpr.visible = true;
		}



		/** @todo Comment */
		protected function _onDebugOut(event:MouseEvent):void {
			_debugSpr.visible = false;
		}



		/** @todo Comment */
		private function _onInvalidate(event:Event):void {
			removeEventListener(Event.ENTER_FRAME, _onInvalidate);

			draw();
		}
	}
}
