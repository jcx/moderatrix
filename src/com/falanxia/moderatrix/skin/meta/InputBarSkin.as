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

package com.falanxia.moderatrix.skin.meta {
	import com.falanxia.emitor.*;
	import com.falanxia.moderatrix.enums.*;
	import com.falanxia.moderatrix.interfaces.*;
	import com.falanxia.moderatrix.skin.*;

	import flash.display.*;



	/**
	 * Input bar skin.
	 *
	 * Input bar skin to be used with the InputBar widget.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class InputBarSkin extends Skin implements ISkin {


		protected var _barSkin:BarSkin;
		protected var _labelSkin:LabelSkin;



		/**
		 * Constructor.
		 * ID is autogenerated if it's empty
		 * @param config Config Object (optional)
		 * @param id Skin ID (optional)
		 * @param asset Asset (optional)
		 */
		public function InputBarSkin(config:Object = null, id:String = null, asset:Asset = null) {
			_barSkin = new BarSkin(config, id + "#bar");
			_labelSkin = new LabelSkin(config, id + "#label");

			super(SkinType.INPUT_BAR, config, id);

			if(asset != null) parseAsset(asset);
		}



		/**
		 * Destroys the InpuBarSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_barSkin.destroy();
			_labelSkin.destroy();

			_barSkin = null;
			_labelSkin = null;
		}



		/**
		 * Parse asset.
		 * @param value Asset
		 * @see Asset
		 */
		public function parseAsset(value:Asset):void {
			_barSkin.getBitmapsFromAtlas(new <BitmapData>[
				value.getChunkByURL(_config.bar.image).bitmap.bitmapData
			]);
		}



		/**
		 * Parse config Object.
		 * @param value Config Object
		 */
		override public function parseConfig(value:Object):void {
			super.parseConfig(value);

			if(value.bar != undefined) _barSkin.parseConfig(value.bar);
			if(value.label != undefined) _labelSkin.parseConfig(value.label);
		}



		/**
		 * Revert config to the last known state.
		 */
		override public function revertConfig():void {
			super.revertConfig();

			_barSkin.revertConfig();
			_labelSkin.revertConfig();
		}



		/**
		 * Get bar skin.
		 * @return Bar skin
		 */
		public function get barSkin():BarSkin {
			return _barSkin;
		}



		/**
		 * Set bar skin.
		 * @param source Bar skin
		 */
		public function set barSkin(source:BarSkin):void {
			_barSkin = source;
		}



		/**
		 * Get label skin.
		 * @return Label skin
		 */
		public function get labelSkin():LabelSkin {
			return _labelSkin;
		}



		/**
		 * Set label skin.
		 * @param source Label skin
		 */
		public function set labelSkin(source:LabelSkin):void {
			_labelSkin = source;
		}
	}
}