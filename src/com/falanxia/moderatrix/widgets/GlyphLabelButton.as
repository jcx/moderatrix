/*
 * Falanxia Moderatrix.
 *
 * Copyright (c) 2010 Falanxia (http://falanxia.com)
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

package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.enums.MouseStatus;
	import com.falanxia.moderatrix.events.ButtonEvent;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.skin.GlyphLabelButtonSkin;
	import com.falanxia.utilitaris.display.MorphSprite;
	import com.falanxia.utilitaris.enums.Align;
	import com.falanxia.utilitaris.utils.DisplayUtils;
	import com.falanxia.utilitaris.utils.ObjectUtils;
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;

	import flash.display.DisplayObjectContainer;



	/** @todo Comment */
	public class GlyphLabelButton extends MorphSprite {


		protected var _skin:GlyphLabelButtonSkin;
		protected var _button:ScaleButton;
		protected var _glyphOut:Image;
		protected var _glyphHover:Image;
		protected var _glyphFocus:Image;
		protected var _labelOut:Label;
		protected var _labelHover:Label;
		protected var _labelFocus:Label;

		private var _debugLevel:String;



		/** @todo Comment */
		public function GlyphLabelButton(skin:GlyphLabelButtonSkin, config:Object = null, text:String = "", parent:DisplayObjectContainer = null,
		                                 debugLevel:String = null) {
			var c:Object;

			if(config == null) {
				c = new Object();
			}
			else {
				c = config;
			}

			var dl:String = (debugLevel == null) ? SkinManager.debugLevel : debugLevel;

			_button = new ScaleButton(skin.buttonSkin, {}, this, dl);
			_glyphOut = new Image(skin.glyphSkin.glyphOutSkin, {mouseEnabled:false, mouseChildren:false}, this, dl);
			_glyphHover = new Image(skin.glyphSkin.glyphHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);
			_glyphFocus = new Image(skin.glyphSkin.glyphFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, this, dl);
			_labelOut = new Label(skin.labelOutSkin, {mouseEnabled:false, mouseChildren:false}, "", this, dl);
			_labelHover = new Label(skin.labelHoverSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, "", this, dl);
			_labelFocus = new Label(skin.labelFocusSkin, {alpha:0, mouseEnabled:false, mouseChildren:false}, "", this, dl);
			_button.debugColor = SkinManager.debugColor;
			_glyphOut.debugColor = SkinManager.debugColor;
			_glyphHover.debugColor = SkinManager.debugColor;
			_glyphFocus.debugColor = SkinManager.debugColor;
			_labelOut.debugColor = SkinManager.debugColor;
			_labelHover.debugColor = SkinManager.debugColor;
			_labelFocus.debugColor = SkinManager.debugColor;

			this.skin = skin;
			this.text = text;
			this.focusRect = false;

			_button.addEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween, false, 0, true);
			_button.addEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween, false, 0, true);
			_button.addEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween, false, 0, true);
			_button.addEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween, false, 0, true);
			_button.addEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween, false, 0, true);
			_button.addEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween, false, 0, true);

			if(c.width == undefined) c.width = skin.buttonSkin.assetSize.width;
			if(c.height == undefined) c.height = skin.buttonSkin.assetSize.height;

			//noinspection NegatedIfStatementJS
			if(skin != null) {
				super(c, parent);
			}
			else {
				throw new Error("No skin defined");
			}

			_skin = skin;
		}



		/**
		 * Destroys {@code GlyphLabelButton} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			forceRelease();
			removeChildren();

			_button.destroy();
			_glyphOut.destroy();
			_glyphHover.destroy();
			_glyphFocus.destroy();
			_labelOut.destroy();
			_labelHover.destroy();
			_labelFocus.destroy();

			_skin = null;
			_button = null;
			_glyphOut = null;
			_glyphHover = null;
			_glyphFocus = null;
			_labelOut = null;
			_labelHover = null;
			_labelFocus = null;
			_debugLevel = null;
		}



		/** @todo Comment */
		public function draw():void {
			_button.draw();
			_glyphOut.draw();
			_glyphHover.draw();
			_glyphFocus.draw();
			_labelOut.draw();
			_labelHover.draw();
			_labelFocus.draw();
		}



		/** @todo Comment */
		public function forceRelease():void {
			_button.forceRelease();
		}



		/** @todo Comment */
		public static function releaseAll():void {
			ButtonCore.releaseAll();
		}



		/** @todo Comment */
		public function autoWidth(padding:Number, max:Number = 500, morph:Boolean = false, morphAddons:Object = null):void {
			var s:Number = this.width;

			this.width = 2000;

			var w:Number = label.width + padding;
			if(w > max) w = max;

			if(morph) {
				if(morphAddons == null) morphAddons = new Object();
				ObjectUtils.assign(morphAddons, {width:w});
				this.width = s;
				this.morph(morphAddons);
			}
			else {
				this.width = w;
			}
		}



		/* ★ SETTERS & GETTERS ★ */


		/** @todo Comment */
		override public function get tabEnabled():Boolean {
			return _button.tabEnabled;
		}



		/** @todo Comment */
		override public function set tabEnabled(enabled:Boolean):void {
			_button.tabEnabled = enabled;
		}



		/** @todo Comment */
		override public function get tabIndex():int {
			return _button.tabIndex;
		}



		/** @todo Comment */
		override public function set tabIndex(index:int):void {
			_button.tabIndex = index;
		}



		/** @todo Comment */
		public function get skin():GlyphLabelButtonSkin {
			return _skin;
		}



		/** @todo Comment */
		public function set skin(skin:GlyphLabelButtonSkin):void {
			_skin = skin;

			_skin.labelOutSkin.hAlign = Align.LEFT;
			_skin.labelHoverSkin.hAlign = Align.LEFT;
			_skin.labelFocusSkin.hAlign = Align.LEFT;

			_button.skin = _skin.buttonSkin;
			_glyphOut.skin = _skin.glyphSkin.glyphOutSkin;
			_glyphHover.skin = _skin.glyphSkin.glyphHoverSkin;
			_glyphFocus.skin = _skin.glyphSkin.glyphFocusSkin;
			_labelOut.skin = _skin.labelOutSkin;
			_labelHover.skin = _skin.labelHoverSkin;
			_labelFocus.skin = _skin.labelFocusSkin;

			draw();
		}



		/** @todo Comment */
		override public function get width():Number {
			return _button.width;
		}



		/** @todo Comment */
		override public function set width(value:Number):void {
			_labelOut.width = 2000;
			_labelHover.width = 2000;
			_labelFocus.width = 2000;

			var labelOutWidth:Number = _labelOut.width;
			var labelHoverWidth:Number = _labelHover.width;
			var labelFocusWidth:Number = _labelFocus.width;
			var outWidth:Number = _glyphOut.width + labelOutWidth;
			var hoverWidth:Number = _glyphHover.width + labelHoverWidth;
			var focusWidth:Number = _glyphFocus.width + labelFocusWidth;
			var maxWidth:Number = Math.max(outWidth, hoverWidth, focusWidth);
			var labelWidth:Number = Math.max(labelOutWidth, labelHoverWidth, labelFocusWidth) + 10;

			_labelOut.width = labelWidth;
			_labelHover.width = labelWidth;
			_labelFocus.width = labelWidth; // FIXME: What the fuck!?

			_button.width = value;
			_glyphOut.x = Math.round((value - maxWidth) / 2);
			_glyphHover.x = Math.round((value - maxWidth) / 2);
			_glyphFocus.x = Math.round((value - maxWidth) / 2);
			_labelOut.x = _glyphOut.x + _glyphOut.width;
			_labelHover.x = _glyphHover.x + _glyphHover.width;
			_labelFocus.x = _glyphFocus.x + _glyphFocus.width;

			draw();
		}



		/** @todo Comment */
		override public function get height():Number {
			return _button.height;
		}



		/** @todo Comment */
		override public function set height(value:Number):void {
			_button.height = value;
			_glyphOut.y = Math.round((value - _glyphOut.height) / 2);
			_glyphHover.y = Math.round((value - _glyphHover.height) / 2);
			_glyphFocus.y = Math.round((value - _glyphFocus.height) / 2);
			_labelOut.y = Math.round((value - _labelOut.height) / 2);
			_labelHover.y = Math.round((value - _labelHover.height) / 2);
			_labelFocus.y = Math.round((value - _labelFocus.height) / 2);

			draw();
		}



		/** @todo Comment */
		public function set areEventsEnabled(value:Boolean):void {
			_button.areEventsEnabled = value;
			this.buttonMode = value;
			this.useHandCursor = value;

			draw();
		}



		/** @todo Comment */
		public function get areEventsEnabled():Boolean {
			return _button.areEventsEnabled;
		}



		/** @todo Comment */
		public function get mouseStatus():String {
			return _button.mouseStatus;
		}



		/** @todo Comment */
		public function set mouseStatus(value:String):void {
			_button.mouseStatus = value;
		}



		/** @todo Comment */
		public function get debugLevel():String {
			return _debugLevel;
		}



		/** @todo Comment */
		public function set debugLevel(value:String):void {
			_debugLevel = value;
			_button.debugLevel = value;
			_glyphOut.debugLevel = value;
			_glyphHover.debugLevel = value;
			_glyphFocus.debugLevel = value;
		}



		/** @todo Comment */
		public function get glyph():Image {
			var out:Image;

			if(_button.mouseStatus == MouseStatus.OUT) out = _glyphOut;
			if(_button.mouseStatus == MouseStatus.HOVER) out = _glyphHover;
			if(_button.mouseStatus == MouseStatus.FOCUS) out = _glyphFocus;

			return out;
		}



		/** @todo Comment */
		public function get glyphOut():Image {
			return _glyphOut;
		}



		/** @todo Comment */
		public function get glyphHover():Image {
			return _glyphHover;
		}



		/** @todo Comment */
		public function get glyphFocus():Image {
			return _glyphFocus;
		}



		/** @todo Comment */
		public function get text():String {
			return _labelOut.text;
		}



		/** @todo Comment */
		public function set text(value:String):void {
			_labelOut.text = value;
			_labelHover.text = value;
			_labelFocus.text = value;

			draw();
		}



		/** @todo Comment */
		public function get label():Label {
			var out:Label;

			if(_button.mouseStatus == MouseStatus.OUT) out = _labelOut;
			if(_button.mouseStatus == MouseStatus.HOVER) out = _labelHover;
			if(_button.mouseStatus == MouseStatus.FOCUS) out = _labelFocus;

			return out;
		}



		/** @todo Comment */
		public function get labelOut():Label {
			return _labelOut;
		}



		/** @todo Comment */
		public function get labelHover():Label {
			return _labelHover;
		}



		/** @todo Comment */
		public function get labelFocus():Label {
			return _labelFocus;
		}



		/** @todo Comment */
		public function get button():ScaleButton {
			return _button;
		}



		/* ★ PRIVATE METHODS ★ */


		/**
		 * Remove children.
		 */
		private function removeChildren():void {
			_button.removeEventListener(ButtonEvent.HOVER_IN_TWEEN, onButtonHoverInTween);
			_button.removeEventListener(ButtonEvent.HOVER_OUT_TWEEN, onButtonHoverOutTween);
			_button.removeEventListener(ButtonEvent.FOCUS_IN_TWEEN, onButtonFocusInTween);
			_button.removeEventListener(ButtonEvent.DRAG_CONFIRMED_TWEEN, onButtonDragConfirmedTween);
			_button.removeEventListener(ButtonEvent.RELEASED_INSIDE_TWEEN, onButtonReleasedInsideTween);
			_button.removeEventListener(ButtonEvent.RELEASED_OUTSIDE_TWEEN, onButtonReleasedOutsideTween);

			DisplayUtils.removeChildren(this, _button, _glyphOut, _glyphHover, _glyphFocus, _labelOut, _labelHover, _labelFocus);
		}



		/* ★ EVENT LISTENERS ★ */


		/** @todo Comment */
		private function onButtonHoverInTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		/** @todo Comment */
		private function onButtonHoverOutTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphHover, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphFocus, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelOut, _skin.buttonSkin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelHover, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelFocus, _skin.buttonSkin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		/** @todo Comment */
		private function onButtonFocusInTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphFocus, _skin.buttonSkin.focusInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelOut, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelHover, _skin.buttonSkin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelFocus, _skin.buttonSkin.focusInDuration, {alpha:1, ease:Sine.easeOut});
		}



		/** @todo Comment */
		private function onButtonDragConfirmedTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelOut, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelHover, _skin.buttonSkin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelFocus, _skin.buttonSkin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
		}



		/** @todo Comment */
		private function onButtonReleasedInsideTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphHover, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelOut, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelHover, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}



		/** @todo Comment */
		private function onButtonReleasedOutsideTween(e:ButtonEvent):void {
			new TweenLite(_glyphOut, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_glyphHover, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_glyphFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelOut, _skin.buttonSkin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(_labelHover, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(_labelFocus, _skin.buttonSkin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
		}
	}
}
