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
	import com.falanxia.moderatrix.enums.SkinType;
	import com.falanxia.moderatrix.interfaces.ISkin;
	import com.falanxia.utilitaris.enums.Align;

	import flash.utils.Dictionary;



	/**
	 * Label skin.
	 *
	 * Label skin to be used with the Label widget.
	 *
	 * @author Vaclav Vancura @ Falanxia a.s. <vaclav@falanxia.com>
	 * @author Falanxia (<a href="http://falanxia.com">falanxia.com</a>, <a href="http://twitter.com/falanxia">@falanxia</a>)
	 * @since 1.0
	 */
	public class LabelSkin extends Skin implements ISkin {



		/**
		 * Constructor.
		 * ID is autogenerated if it's empty
		 * @param config Config Object (optional)
		 * @param id Skin ID (optional)
		 */
		public function LabelSkin(config:Object = null, id:String = null) {
			super(SkinType.LABEL, config, id);
		}



		override protected function resetSettings():Dictionary {
			var set:Dictionary = new Dictionary();

			set["hAlign"] = Align.LEFT;
			set["vAlign"] = Align.TOP;
			set["bold"] = false;
			set["blockIndent"] = 0;
			set["bullet"] = false;
			set["color"] = 0x000000;
			set["font"] = null;
			set["indent"] = 0;
			set["italic"] = false;
			set["kerning"] = false;
			set["leading"] = 0;
			set["letterSpacing"] = 0;
			set["size"] = 10;
			set["underline"] = false;
			set["url"] = null;
			set["alpha"] = 1;
			set["filters"] = new Array();
			set["sharpness"] = 0;
			set["thickness"] = 0;
			set["paddingTop"] = 0;
			set["paddingBottom"] = 0;
			set["paddingLeft"] = 0;
			set["paddingRight"] = 0;
			set["marginLeft"] = 0;
			set["marginRight"] = 0;

			return set;
		}
	}
}
