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

package com.falanxia.moderatrix.skin {
	import com.falanxia.moderatrix.enums.*;
	import com.falanxia.moderatrix.interfaces.*;

	import flash.display.*;



	/**
	 * Image skin.
	 *
	 * Image skin to be used with the Image widget.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class ImageSkin extends Skin implements ISkin, IAssetSkin {


		protected var _paddingTop:Number;
		protected var _paddingLeft:Number;
		protected var _assetSources:Vector.<BitmapData>;

		private var oldPaddingTop:Number;
		private var oldPaddingLeft:Number;



		/**
		 * Constructor.
		 * ID is autogenerated if it's empty
		 * @param id Skin ID (optional)
		 */
		public function ImageSkin(id:String = null) {
			super(SkinType.IMAGE, id);

			_paddingTop = 0;
			_paddingLeft = 0;
			_assetSources = new Vector.<BitmapData>;

			_assetSources[0] = new BitmapData(1, 1, true, 0x00000000);
		}



		/**
		 * Destroys the ImageSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			_assetSources[0].dispose();

			_assetSources = null;
		}



		/**
		 * Get assets from vector of BitmapData.
		 * @param value Source vector of BitmapData
		 */
		public function getAssetsFromAtlas(value:Vector.<BitmapData>):void {
			var imageSource:BitmapData = value[0];

			_assetSize.width = imageSource.width;
			_assetSize.height = imageSource.height;

			_assetSources[0] = value[0];
		}



		/**
		 * Parse config Object.
		 * @param value Config Object
		 */
		override public function parseConfig(value:Object):void {
			super.parseConfig(value);

			oldPaddingTop = _paddingTop;
			oldPaddingLeft = _paddingLeft;

			if(value.paddingTop != undefined) _paddingTop = value.paddingTop;
			if(value.paddingLeft != undefined) _paddingLeft = value.paddingLeft;
		}



		/**
		 * Revert config to the last known state.
		 */
		override public function revertConfig():void {
			super.revertConfig();

			_paddingTop = oldPaddingTop;
			_paddingLeft = oldPaddingLeft;
		}



		/**
		 * Get top padding.
		 * @return Top padding
		 */
		public function get paddingTop():Number {
			return _paddingTop;
		}



		/**
		 * Set top padding.
		 * @param value Top padding
		 */
		public function set paddingTop(value:Number):void {
			_paddingTop = value;
		}



		/**
		 * Get left padding.
		 * @return Left padding
		 */
		public function get paddingLeft():Number {
			return _paddingLeft;
		}



		/**
		 * Set left padding.
		 * @param value Left padding
		 */
		public function set paddingLeft(value:Number):void {
			_paddingLeft = value;
		}



		/**
		 * Set asset source BitmapData
		 * @param value Vector of asset source BitmapData
		 */
		public function set assetSources(value:Vector.<BitmapData>):void {
			checkSize(value[0]);

			_assetSources = value;
		}



		/**
		 * Get asset source BitmapData
		 * @return Vector of asset source BitmapData
		 */
		public function get assetSources():Vector.<BitmapData> {
			return _assetSources;
		}
	}
}
