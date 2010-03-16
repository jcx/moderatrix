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
	import com.falanxia.moderatrix.constants.Align;
	import com.falanxia.moderatrix.constants.DebugLevel;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.skin.LabelSkin;
	import com.falanxia.utilitaris.display.QTextField;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;



	/** @todo Comment */
	public class Label extends Widget {


		protected var _skin:LabelSkin;
		protected var _textField:QTextField;
		protected var _textFormat:TextFormat;

		private var _isWidthOverriden:Boolean;
		private var _isHeightOverriden:Boolean;
		private var _vAlign:String;
		private var _isInput:Boolean;



		/** @todo Comment */
		public function Label(skin:LabelSkin, config:Object = null, text:String = "", parent:DisplayObjectContainer = null,
		                      debugLevel:String = null) {
			var c:Object;

			if(config == null) c = new Object();
			else c = config;

			//noinspection NegatedIfStatementJS
			if(skin != null) super(c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
			else throw new Error("No skin defined");

			_isWidthOverriden = (c.width != undefined);
			_isHeightOverriden = (c.height != undefined);

			this.skin = skin;
			this.text = text;
		}



		/**
		 * Destroys {@code Label} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			removeChildren();

			_textField.destroy();

			_skin = null;
			_textField = null;
			_textFormat = null;
			_vAlign = null;
		}



		/**
		 * @todo Comment
		 * @todo Optmimize
		 */
		override public function draw():void {
			super.draw();

			if(_skin != null) {
				var rect:Rectangle = new Rectangle(_skin.paddingLeft, _skin.paddingTop, _size.width - _skin.paddingLeft - _skin.paddingRight, _size.height - _skin.paddingTop - _skin.paddingBottom);

				if(_size.width != 0) _textField.width = rect.width;

				if(_size.height != 0) {
					// set label height
					_textField.height = rect.height;

					// non-top alignment
					if(_vAlign == Align.CENTER) {
						_textField.y = Math.round((rect.height - _textField.textHeight) / 2) + _skin.paddingTop;
					}
					if(_vAlign == Align.BOTTOM) {
						_textField.y = rect.height - _textField.textHeight + _skin.paddingTop;
					}
				}

				if(_debugLevel == DebugLevel.ALWAYS || _debugLevel == DebugLevel.HOVER) {
					if(!_size.isEmpty()) DisplayUtils.strokeBounds(debugSpr, rect, _debugColor, 5);
				}
			}
		}



		/* ★ SETTERS & GETTERS ★ */

		/** @todo Comment */
		override public function get tabEnabled():Boolean {
			return _textField.tabEnabled;
		}



		/** @todo Comment */
		override public function set tabIndex(index:int):void {
			_textField.tabIndex = index;
		}



		/** @todo Comment */
		override public function get tabIndex():int {
			return _textField.tabIndex;
		}



		/** @todo Comment */
		override public function set tabEnabled(enabled:Boolean):void {
			_textField.tabEnabled = enabled;
		}



		/** @todo Comment */
		override public function set debugLevel(value:String):void {
			super.debugLevel = value;

			_textField.border = (_debugLevel == DebugLevel.ALWAYS);
		}



		/** @todo Comment */
		public function get skin():LabelSkin {
			return _skin;
		}



		/** @todo Comment */
		public function set skin(skin:LabelSkin):void {
			_skin = skin;

			_vAlign = _skin.vAlign;

			_textFormat = new TextFormat();
			_textFormat.align = _skin.hAlign;
			_textFormat.blockIndent = _skin.blockIndent;
			_textFormat.bold = _skin.bold;
			_textFormat.bullet = _skin.bullet;
			_textFormat.color = _skin.color;
			_textFormat.font = _skin.font;
			_textFormat.indent = _skin.indent;
			_textFormat.italic = _skin.italic;
			_textFormat.kerning = _skin.kerning;
			_textFormat.leading = _skin.leading;
			_textFormat.leftMargin = _skin.marginLeft;
			_textFormat.letterSpacing = _skin.letterSpacing;
			_textFormat.rightMargin = _skin.marginRight;
			_textFormat.size = _skin.size;
			_textFormat.underline = _skin.underline;
			_textFormat.url = _skin.url;

			_textField.setTextFormat(_textFormat);
			_textField.defaultTextFormat = _textFormat;
			_textField.position = new Point(_skin.paddingLeft, _skin.paddingTop);
			_textField.filters = _skin.filters;
			_textField.sharpness = _skin.sharpness;
			_textField.thickness = _skin.thickness;
			_textField.alpha = _skin.alpha;
			_textField.embedFonts = (_skin.font != "");

			if(_size.width == 0) _size.width = _skin.assetSize.width;
			if(_size.height == 0) _size.height = _skin.assetSize.height;

			draw();
		}



		/** @todo Comment */
		public function get text():String {
			return _textField.text;
		}



		/** @todo Comment */
		public function set text(value:String):void {
			var v:String = value;

			if(_textField != null) {
				_textField.defaultTextFormat = _textFormat;

				if(v != null) {
					if(v == "") {
						// fix alignment problem when empty string was applied to the html enabled TextField
						// noinspection ReuseOfLocalVariableJS
						v = "&nbsp;";
					}

					_textField.htmlText = v;
				}
			}

			draw();
		}



		/** @todo Comment */
		public function get textField():TextField {
			return _textField;
		}



		/** @todo Comment */
		override public function get width():Number {
			return (_isWidthOverriden) ? _textField.width : _textField.textWidth + _skin.paddingLeft + _skin.paddingRight;
		}



		/** @todo Comment */
		override public function get height():Number {
			return (_isHeightOverriden) ? _textField.height : _textField.textHeight + _skin.paddingTop + _skin.paddingBottom;
		}



		/** @todo Comment */
		override public function get x():Number {
			return super.x - _skin.paddingLeft;
		}



		/** @todo Comment */
		override public function get y():Number {
			return super.y - _skin.paddingTop;
		}



		/** @todo Comment */
		public function get isInput():Boolean {
			return _isInput;
		}



		/** @todo Comment */
		public function get isPassword():Boolean {
			return _textField.displayAsPassword;
		}



		/** @todo Comment */
		public function set isPassword(value:Boolean):void {
			_textField.displayAsPassword = value;
		}



		/** @todo Comment */
		public function set isInput(value:Boolean):void {
			if(_textField != null) {
				_textField.type = (value) ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
				_textField.selectable = value;
				_textField.multiline = !value;
				_textField.condenseWhite = !value;

				if(value) _textField.autoSize = TextFieldAutoSize.NONE;

				_textFormat.kerning = !value;
				_textField.setTextFormat(_textFormat);
			}

			_isInput = value;
		}



		/* ★ PROTECTED METHODS ★ */


		/** @todo Comment */
		override protected function init():void {
			super.init();

			_textFormat = new TextFormat();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		/** @todo Comment */
		override protected function addChildren():void {
			super.addChildren();

			_textField = new QTextField({width:2880, autoSize:(_isWidthOverriden) ? TextFieldAutoSize.NONE : Align.LEFT, borderColor:_debugColor, border:(_debugLevel == DebugLevel.ALWAYS)}, contentSpr);
		}



		/** @todo Comment */
		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, _textField);
		}



		/* ★ EVENT LISTENERS ★ */


		/** @todo Comment */
		override protected function onDebugOver(event:MouseEvent):void {
			super.onDebugOver(event);

			if(_debugLevel == DebugLevel.HOVER) {
				_textField.border = true;
			}
		}



		/** @todo Comment */
		override protected function onDebugOut(event:MouseEvent):void {
			super.onDebugOut(event);

			if(_debugLevel == DebugLevel.HOVER) {
				_textField.border = false;
			}
		}
	}
}
