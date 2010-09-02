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
	 * Atlas skin.
	 *
	 * Atlas skin to be used with the Atlas widget.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class AtlasSkin extends Skin implements ISkin, IAssetSkin {


		protected var _assetSources:Vector.<BitmapData>;



		/**
		 * Constructor.
		 * ID is autogenerated if it's empty
		 * @param id Skin ID (optional)
		 */
		public function AtlasSkin(id:String = null) {
			super(SkinType.IMAGE, id);

			_assetSources = new Vector.<BitmapData>;

			_assetSources[0] = new BitmapData(1, 1, true, 0x00000000);
		}



		/**
		 * Destroys the AtlasSkin instance and frees it for GC.
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
			var atlasSource:BitmapData = value[0];

			_assetSize.width = atlasSource.width;
			_assetSize.height = atlasSource.height;

			_assetSources = new <BitmapData>[
				atlasSource
			];
		}



		/**
		 * Parse config.
		 * @param value Config Object
		 */
		override public function parseConfig(value:Object):void {
			super.parseConfig(value);

			if(value.spriteWidth != undefined) _assetSize.width = value.spriteWidth;
		}



		/**
		 * Revert config to the last known state.
		 */
		override public function revertConfig():void {
			super.revertConfig();
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
