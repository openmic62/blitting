//
//  com.blitting.display.BitmapRenderer
//
//  Created by Jason Sturges.
//
package com.blitting.display
{
	import com.blitting.core.blitting_internal;

	import flash.display.BitmapData;

	use namespace blitting_internal;

	/**
	 *
	 * @author jsturges
	 *
	 */
	public class BitmapRenderer extends AbstractRenderer implements IBitmapRenderer
	{
		include "../core/Version.as";


		//------------------------------
		//  model
		//------------------------------

		protected var bitmapData:BitmapData;


		//------------------------------
		//  lifecycle
		//------------------------------

		public function BitmapRenderer()
		{
			super();
		}

		override public function initialize():void
		{
			super.initialize();

			bitmapData = null;
		}

		public function render(bitmapData:BitmapData):void
		{
			this.bitmapData = bitmapData;
		}

		override public function dispose():void
		{
			super.dispose();

			bitmapData = null;
		}

	}
}
