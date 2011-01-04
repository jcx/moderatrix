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

package com.falanxia.moderatrix.widgets {
	import com.falanxia.moderatrix.enums.DebugLevel;
	import com.falanxia.moderatrix.globals.SkinManager;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.interfaces.IWidget;
	import com.falanxia.moderatrix.skin.BarSkin;
	import com.falanxia.utilitaris.display.ScaleBitmapSprite;
	import com.falanxia.utilitaris.utils.DisplayUtils;

	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;



	/**
	 * Bar.
	 *
	 * Bar is a resizable bitmap element.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class Bar extends Widget implements IWidget {


		protected var bodySBS:ScaleBitmapSprite;



		/**
		 * Constructor.
		 * @param skin Initial skin
		 * @param config Config Object
		 * @param parent Parent DisplayObjectContainer
		 * @param debugLevel Initial debug level
		 * @see DebugLevel
		 */
		public function Bar(skin:BarSkin, config:Object = null, parent:DisplayObjectContainer = null, debugLevel:String = null) {
			var c:Object = config == null ? new Object() : config;
			var dl:String = (debugLevel == null) ? SkinManager.defaultDebugLevel : debugLevel;

			if(c.width == undefined) c.width = skin.bitmapSize.width;
			if(c.height == undefined) c.height = skin.bitmapSize.height;

			super(c, parent, dl);

			this.skin = skin;

			draw();
		}



		/**
		 * Destroys Bar instance and frees it for GC.
		 */
		override public function destroy():void {
			bodySBS.destroy();

			super.destroy();

			_skin = null;
			bodySBS = null;
		}



		/**
		 * Draw the widget.
		 */
		override public function draw():void {
			if(_skin != null && _skin.settings != null && _size != null) {
				super.draw();

				var settings:Dictionary = _skin.settings;
				var rect:Rectangle = new Rectangle(settings["paddingLeft"], settings["paddingTop"], _size.width - settings["paddingLeft"] - settings["paddingRight"], _size.height - settings["paddingTop"] - settings["paddingBottom"]);

				if(_size.width != 0 && !isNaN(_size.width)) {
					bodySBS.width = rect.width;
					bodySBS.x = rect.x;
				}

				if(_size.height != 0 && !isNaN(_size.height)) {
					bodySBS.height = rect.height;
					bodySBS.y = rect.y;
				}

				if(_debugLevel != DebugLevel.NONE) {
					DisplayUtils.strokeBounds(debugSpr, rect, _debugColor, 5);
				}
			}
		}



		/**
		 * Set skin.
		 * @param value Skin
		 */
		override public function set skin(value:ISkin):void {
			if(value != null) {
				super.skin = value;

				if(_skin.bitmapSize != null) {
					if(_size.width == 0) _size.width = _skin.bitmapSize.width;
					if(_size.height == 0) _size.height = _skin.bitmapSize.height;
				}

				var skin:BarSkin = BarSkin(_skin);

				if(skin.bitmapSources != null) {
					var rect:Rectangle = skin.bitmapSources[BarSkin.GUIDE_BITMAP].getColorBoundsRect(0x00FF0000, 0x00000000, false);

					bodySBS.setData(skin.bitmapSources[BarSkin.BAR_BITMAP], rect);
				}
			}
		}



		/**
		 * Get current width.
		 * @return Current width
		 */
		override public function get width():Number {
			if(_skin != null && _skin.settings != null) {
				var settings:Dictionary = _skin.settings;

				return _size == null ? 0 : _size.width + settings["paddingLeft"] + settings["paddingRight"];
			} else {
				return 0;
			}
		}



		/**
		 * Get current height.
		 * @return Current height
		 */
		override public function get height():Number {
			if(_skin != null && _skin.settings != null) {
				var settings:Dictionary = _skin.settings;

				return _size == null ? 0 : _size.height + settings["paddingTop"] + settings["paddingBottom"];
			} else {
				return 0;
			}
		}



		override protected function init():void {
			super.init();

			isMorphWidthEnabled = true;
			isMorphHeightEnabled = true;
			isChangeWidthEnabled = true;
			isChangeHeightEnabled = true;
		}



		override protected function addChildren():void {
			super.addChildren();

			bodySBS = new ScaleBitmapSprite();

			DisplayUtils.addChildren(contentSpr, bodySBS);
		}



		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, bodySBS);
		}
	}
}
