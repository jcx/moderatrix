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

package com.falanxia.moderatrix.skin {
	import com.falanxia.emitor.Asset;
	import com.falanxia.moderatrix.enums.SkinType;
	import com.falanxia.moderatrix.interfaces.IBitmapSkin;
	import com.falanxia.moderatrix.interfaces.ISkin;

	import flash.display.BitmapData;
	import flash.utils.Dictionary;



	/**
	 * Image skin.
	 *
	 * Image skin to be used with the Image widget.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class ImageSkin extends Skin implements ISkin, IBitmapSkin {


		public static const IMAGE_BITMAP:uint = 0;

		protected var _bitmapSources:Vector.<BitmapData>;



		/**
		 * Constructor.
		 * ID is autogenerated if it's empty
		 * @param displayConfig Config Object (optional)
		 * @param id Skin ID (optional)
		 * @param asset Asset (optional)
		 */
		public function ImageSkin(displayConfig:Object = null, id:String = null, asset:Asset = null) {
			super(SkinType.IMAGE, displayConfig, id);

			_bitmapSources = new Vector.<BitmapData>();

			_bitmapSources[IMAGE_BITMAP] = new BitmapData(1, 1, true, 0x00000000);

			if(asset != null) parseAsset(asset);
		}



		/**
		 * Destroys the ImageSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_bitmapSources[IMAGE_BITMAP].dispose();

			_bitmapSources = null;
		}



		/**
		 * Parse asset.
		 * @param value Asset
		 * @see Asset
		 */
		public function parseAsset(value:Asset):void {
			getBitmapsFromAtlas(new <BitmapData>[value.getChunkByURL(_config.image).bitmap.bitmapData]);
		}



		/**
		 * Get bitmaps from vector of BitmapData.
		 * @param value Source vector of BitmapData
		 */
		public function getBitmapsFromAtlas(value:Vector.<BitmapData>):void {
			var bitmap:BitmapData = value[0];

			_bitmapSize.width = bitmap.width;
			_bitmapSize.height = bitmap.height;

			_bitmapSources[IMAGE_BITMAP] = value[0];
		}



		/**
		 * Set bitmap sources BitmapData.
		 * @param value Vector of bitmap sources
		 */
		public function set bitmapSources(value:Vector.<BitmapData>):void {
			checkSize(value[IMAGE_BITMAP]);

			_bitmapSources = value;
		}



		/**
		 * Get bitmap sources BitmapData.
		 * @return Vector of bitmap sources
		 */
		public function get bitmapSources():Vector.<BitmapData> {
			return _bitmapSources;
		}



		override protected function resetSettings():Dictionary {
			var set:Dictionary = new Dictionary();

			set["paddingTop"] = 0;
			set["paddingLeft"] = 0;

			return set;
		}
	}
}
