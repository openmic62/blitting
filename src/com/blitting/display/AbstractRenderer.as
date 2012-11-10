//
//  com.blitting.display.AbstractRenderer
//
//  Created by Jason Sturges.
//
package com.blitting.display
{
	import com.blitting.lifecycle.IDisposable;

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class AbstractRenderer extends EventDispatcher implements IDisposable
	{

		//------------------------------
		//  model
		//------------------------------

		/**
		 * Viewport bounds.
		 */
		public var bounds:Rectangle;

		/**
		 * Registration point.
		 */
		public var registration:Point;


		//------------------------------
		//  lifecycle
		//------------------------------

		public function AbstractRenderer(target:IEventDispatcher=null)
		{
			super(target);

			bounds = new Rectangle();
			registration = new Point(0, 0);
		}

		public function dispose():void
		{
			bounds = null;
			registration = null;
		}

	}
}
