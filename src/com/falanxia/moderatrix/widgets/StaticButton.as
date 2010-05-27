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
	import com.falanxia.moderatrix.globals.*;
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.moderatrix.skin.*;
	import com.falanxia.utilitaris.display.*;
	import com.falanxia.utilitaris.utils.*;
	import com.greensock.*;
	import com.greensock.easing.*;

	import flash.display.*;



	/**
	 * TODO: Documentation
	 */
	public class StaticButton extends ButtonCore implements IWidget {


		private var outBM:QBitmap;
		private var hoverBM:QBitmap;
		private var focusBM:QBitmap;



		/**
		 * TODO: Documentation
		 * @param skin
		 * @param config
		 * @param parent
		 * @param debugLevel
		 */
		public function StaticButton(skin:ButtonSkin, config:Object = null, parent:DisplayObjectContainer = null,
		                             debugLevel:String = null) {
			var c:Object;

			if(config == null) {
				c = new Object();
			}
			else {
				c = config;
			}

			super(skin, c, parent, (debugLevel == null) ? SkinManager.debugLevel : debugLevel);
		}



		/**
		 * Destroys {@code StaticButton} instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			forceRelease();
			removeChildren();

			outBM.destroy();
			hoverBM.destroy();
			focusBM.destroy();

			outBM = null;
			hoverBM = null;
			focusBM = null;
		}



		/**
		 * TODO: Documentation
		 */
		override public function draw():void {
			super.draw();

			activeSpr.size = _size;
		}



		/* ★ SETTERS & GETTERS ★ */


		/**
		 * TODO: Documentation
		 * @param skin
		 */
		override public function set skin(skin:ButtonSkin):void {
			super.skin = skin;

			outBM.bitmapData = _skin.outBD;
			hoverBM.bitmapData = _skin.hoverBD;
			focusBM.bitmapData = _skin.focusBD;

			draw();
		}



		/* ★ PROTECTED METHODS ★ */


		/**
		 * TODO: Documentation
		 */
		override protected function init():void {
			super.init();

			isMorphWidthEnabled = false;
			isMorphHeightEnabled = false;
			isChangeWidthEnabled = false;
			isChangeHeightEnabled = false;
		}



		/**
		 * TODO: Documentation
		 */
		override protected function addChildren():void {
			super.addChildren();

			outBM = new QBitmap({}, contentSpr);
			hoverBM = new QBitmap({alpha:0}, contentSpr);
			focusBM = new QBitmap({alpha:0}, contentSpr);
		}



		/**
		 * Remove children.
		 */
		override protected function removeChildren():void {
			super.removeChildren();

			DisplayUtils.removeChildren(contentSpr, outBM, hoverBM, focusBM);
		}



		/**
		 * TODO: Documentation
		 */
		override protected function hoverInTween():void {
			new TweenLite(outBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(hoverBM, _skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(focusBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super.hoverInTween();
		}



		/**
		 * TODO: Documentation
		 */
		override protected function hoverOutTween():void {
			new TweenLite(outBM, _skin.hoverOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(hoverBM, _skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(focusBM, _skin.hoverOutDuration, {alpha:0, ease:Sine.easeIn});

			super.hoverOutTween();
		}



		/**
		 * TODO: Documentation
		 */
		override protected function focusInTween():void {
			new TweenLite(outBM, _skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(hoverBM, _skin.focusInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(focusBM, _skin.focusInDuration, {alpha:1, ease:Sine.easeOut});

			super.focusInTween();
		}



		/**
		 * TODO: Documentation
		 */
		override protected function dragConfirmedTween():void {
			new TweenLite(outBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(hoverBM, _skin.hoverInDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(focusBM, _skin.hoverInDuration, {alpha:0, ease:Sine.easeIn});

			super.dragConfirmedTween();
		}



		/**
		 * TODO: Documentation
		 */
		override protected function releasedInsideTween():void {
			new TweenLite(outBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(hoverBM, _skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(focusBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super.releasedInsideTween();
		}



		/**
		 * TODO: Documentation
		 */
		override protected function releasedOutsideTween():void {
			new TweenLite(outBM, _skin.focusOutDuration, {alpha:1, ease:Sine.easeOut});
			new TweenLite(hoverBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});
			new TweenLite(focusBM, _skin.focusOutDuration, {alpha:0, ease:Sine.easeIn});

			super.releasedOutsideTween();
		}
	}
}
