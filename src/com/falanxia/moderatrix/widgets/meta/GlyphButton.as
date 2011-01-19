/*
 * Falanxia Moderatrix.
 *
 * Copyright (c) 2011 Falanxia (http://falanxia.com)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.falanxia.moderatrix.widgets.meta {
	import com.falanxia.moderatrix.enums.DebugLevel;
	import com.falanxia.moderatrix.enums.MouseStatus;
	import com.falanxia.moderatrix.events.ButtonEvent;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.meta.GlyphButtonSkin;
	import com.falanxia.moderatrix.widgets.ButtonCore;
	import com.falanxia.moderatrix.widgets.Image;
	import com.falanxia.moderatrix.widgets.ScaleButton;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.types.RGBA;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;

	import flash.display.DisplayObjectContainer;



	public class GlyphButton extends MorphSprite implements IWidget {


		public var button:ScaleButton;
		public var glyphOut:Image;
		public var glyphHover:Image;
		public var glyphFocus:Image;

		protected var _skin:GlyphButtonSkin;

		private var _debugLevel:String;



		public function GlyphButton(skin:GlyphButtonSkin, displayConfig:Object = null, displayParent:DisplayObjectContainer = null,
		                            debugLevel:String = null) {
			var c:Object = displayConfig == null ? new Object() : displayConfig;
			var dl:String = (debugLevel == null) ? DebugLevel.NONE : debugLevel;
			var dc:RGBA = DisplayUtils.RED;

			button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			glyphOut = new Image(skin.glyphSkin.glyphOutSkin, {mouseEnabled:false, mouseChildren:false}, this, dl);
			glyphHover = new Image(skin.glyphSkin.glyphHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);
			glyphFocus = new Image(skin.glyphSkin.glyphFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);

			button.debugColor = dc;
			glyphOut.debugColor = dc;
			glyphHover.debugColor = dc;
			glyphFocus.debugColor = dc;

			this.skin = skin;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.focusRect = false;

			button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			if(c.width == undefined) c.width = skin.buttonSkin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.buttonSkin.bitmapSize.height;

			super(c, displayParent);

			_skin = skin;
			_debugLevel = dl;
		}



		/**
		 * Destroys GlyphButton instance and frees it for GC.
		 */
		override public function destroy():void {
			button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			DisplayUtils.removeChildren(this, button, glyphOut, glyphHover, glyphFocus);

			forceRelease();

			button.destroy();
			glyphOut.destroy();
			glyphHover.destroy();
			glyphFocus.destroy();

			super.destroy();

			button = null;
			glyphOut = null;
			glyphHover = null;
			glyphFocus = null;

			_skin = null;
			_debugLevel = null;
		}



		public function draw():void {
			button.draw();
			glyphOut.draw();
			glyphHover.draw();
			glyphFocus.draw();
		}



		public function forceRelease():void {
			button.forceRelease();
		}



		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		override public function get tabEnabled():Boolean {
			return button.tabEnabled;
		}



		override public function set tabEnabled(enabled:Boolean):void {
			button.tabEnabled = enabled;
		}



		override public function get tabIndex():int {
			return button.tabIndex;
		}



		override public function set tabIndex(index:int):void {
			button.tabIndex = index;
		}



		/**
		 * Get current skin.
		 * @return Current skin
		 */
		public function get skin():ISkin {
			return _skin;
		}



		/**
		 * Set skin.
		 * @param value Skin
		 */
		public function set skin(value:ISkin):void {
			if(value != null) {
				_skin = GlyphButtonSkin(value);

				button.skin = _skin.buttonSkin;

				if(_skin.glyphSkin != null) {
					glyphOut.skin = _skin.glyphSkin.glyphOutSkin;
					glyphHover.skin = _skin.glyphSkin.glyphHoverSkin;
					glyphFocus.skin = _skin.glyphSkin.glyphFocusSkin;
				}
			}
		}



		override public function get width():Number {
			return button.width;
		}



		override public function set width(value:Number):void {
			button.width = value;
			glyphOut.x = Math.round((value - glyphOut.width) / 2);
			glyphHover.x = Math.round((value - glyphHover.width) / 2);
			glyphFocus.x = Math.round((value - glyphFocus.width) / 2);
		}



		override public function get height():Number {
			return button.height;
		}



		override public function set height(value:Number):void {
			button.height = value;
			glyphOut.y = Math.round((value - glyphOut.height) / 2);
			glyphHover.y = Math.round((value - glyphHover.height) / 2);
			glyphFocus.y = Math.round((value - glyphFocus.height) / 2);
		}



		public function set areEventsEnabled(value:Boolean):void {
			button.areEventsEnabled = value;

			this.buttonMode = value;
			this.useHandCursor = value;
		}



		public function get areEventsEnabled():Boolean {
			return button.areEventsEnabled;
		}



		public function get mouseStatus():String {
			return button.mouseStatus;
		}



		public function set mouseStatus(value:String):void {
			button.mouseStatus = value;
		}



		public function get debugLevel():String {
			return _debugLevel;
		}



		public function set debugLevel(value:String):void {
			_debugLevel = value;

			button.debugLevel = value;
			glyphOut.debugLevel = value;
			glyphHover.debugLevel = value;
			glyphFocus.debugLevel = value;
		}



		public function get currentGlyph():Image {
			var out:Image;

			if(button.mouseStatus == MouseStatus.OUT) out = glyphOut;
			if(button.mouseStatus == MouseStatus.HOVER) out = glyphHover;
			if(button.mouseStatus == MouseStatus.FOCUS) out = glyphFocus;

			return out;
		}



		private function onButtonHoverInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverInDuration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				new TweenMax(glyphOut, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(glyphHover, hoverInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(glyphFocus, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonHoverOutTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverOutDuration:Number = _skin.buttonSkin.settings["hoverOutDuration"];

				new TweenMax(glyphOut, hoverOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(glyphHover, hoverOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(glyphFocus, hoverOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonFocusInTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusInDuration:Number = _skin.buttonSkin.settings["focusInDuration"];

				new TweenMax(glyphOut, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(glyphHover, focusInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(glyphFocus, focusInDuration, {alpha:1, ease:Cubic.easeOut});
			}
		}



		private function onButtonDragConfirmedTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var hoverInDuration:Number = _skin.buttonSkin.settings["hoverInDuration"];

				new TweenMax(glyphOut, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(glyphHover, hoverInDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(glyphFocus, hoverInDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonReleasedInsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusOutDuration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				new TweenMax(glyphOut, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(glyphHover, focusOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(glyphFocus, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}



		private function onButtonReleasedOutsideTween(e:ButtonEvent):void {
			if(_skin != null && _skin.buttonSkin != null && _skin.buttonSkin.settings != null) {
				var focusOutDuration:Number = _skin.buttonSkin.settings["focusOutDuration"];

				new TweenMax(glyphOut, focusOutDuration, {alpha:1, ease:Cubic.easeOut});
				new TweenMax(glyphHover, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
				new TweenMax(glyphFocus, focusOutDuration, {alpha:0, ease:Cubic.easeIn});
			}
		}
	}
}
