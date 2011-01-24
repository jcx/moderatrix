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

package com.falanxia.moderatrix.skin.meta {
	import com.falanxia.emitor.Asset;
	import com.falanxia.moderatrix.enums.SkinType;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.moderatrix.skin.ButtonSkin;
	import com.falanxia.moderatrix.skin.Skin;
	import com.falanxia.moderatrix.skin.combos.ImageComboSkin;



	/**
	 * Image button skin.
	 *
	 * Image button skin to be used with the ImageButton widget.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class ImageButtonSkin extends Skin implements ISkin {


		public var buttonSkin:ButtonSkin;
		public var imageComboSkin:ImageComboSkin;



		/**
		 * Constructor.
		 * ID is autogenerated if it's empty
		 * @param config Config Object (optional)
		 * @param id Skin ID (optional)
		 * @param asset Asset (optional)
		 */
		public function ImageButtonSkin(config:Object = null, id:String = null, asset:Asset = null) {
			buttonSkin = new ButtonSkin(config, id + "#button");
			imageComboSkin = new ImageComboSkin(config, id + "#imageCombo");

			super(SkinType.IMAGE_BUTTON, config, id);

			if(asset != null) parseAsset(asset, _config);
		}



		/**
		 * Destroys the ImageButtonSkin instance and frees it for GC.
		 */
		override public function destroy():void {
			super.destroy();

			buttonSkin.destroy();
			imageComboSkin.destroy();

			buttonSkin = null;
			imageComboSkin = null;
		}



		/**
		 * Parse asset.
		 * @param asset Asset
		 * @param config Config
		 * @see Asset
		 */
		public function parseAsset(asset:Asset, config:Object):void {
			buttonSkin.parseAsset(asset, config.button);
			imageComboSkin.parseAsset(asset, config.imageCombo);
		}



		/**
		 * Parse config Object.
		 * @param value Config Object
		 */
		override public function parseConfig(value:Object):void {
			super.parseConfig(value);

			if(value.button != undefined) buttonSkin.parseConfig(value.button);
			if(value.imageCombo != undefined) imageComboSkin.parseConfig(value.imageCombo);
		}



		/**
		 * Revert config to the last known state.
		 */
		override public function revertConfig():void {
			super.revertConfig();

			buttonSkin.revertConfig();
			imageComboSkin.revertConfig();
		}
	}
}
