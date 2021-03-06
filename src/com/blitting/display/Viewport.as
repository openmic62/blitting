//
//  com.blitting.display.Viewport
//
//  Created by Jason Sturges.
//
package com.blitting.display
{
	import com.blitting.core.blitting_internal;
	import com.blitting.lifecycle.IDisposable;
	import com.blitting.lifecycle.IValidatable;

	import flash.display.DisplayObject;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	use namespace blitting_internal;

	/**
	 * Extends AbstractViewport to provide base lifecycle for views.
	 *
	 * <ul>
	 * 	<li>added to stage</li>
	 * 	<li>removed from stage</li>
	 * </ul>
	 *
	 * Implements IValidation lifecycle.
	 *
	 * <ul>
	 * 	<li>invalidate</li>
	 * 	<li>validate</li>
	 * </ul>
	 */
	public class Viewport extends AbstractViewport implements IValidatable
	{
		include "../core/Version.as";


		//------------------------------
		//  model
		//------------------------------

		/**
		 * Whether properties have been invalidated,
		 * requiring validation.
		 */
		protected var invalidated:Boolean = false;


		//------------------------------
		//  lifecycle
		//------------------------------

		/**
		 * constructor
		 */
		public function Viewport()
		{
			super();

			focusRect = mouseEnabled = mouseChildren = tabEnabled = tabChildren = false;

			// add added to stage listener.
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		/**
		 * initialize (IInitializable)
		 */
		override public function initialize():void
		{
			super.initialize();

			invalidated = false;
			focusRect = mouseEnabled = mouseChildren = tabEnabled = tabChildren = false;

			// add added to stage listener.
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		/**
		 * autoOrientation
		 */
		public function autoOrientation():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}

		/**
		 * Indicate component has been invalidated. (IValidatable).
		 *
		 * Viewport abstract base class does not manage invalidation through
		 * the BlittingEngine; therefore, validation commit stage must be
		 * implemented via inheritance.
		 */
		public function invalidate():void
		{
			if (invalidated)
				return;

			invalidated = true;
		}

		/**
		 * Indicate component has been validated. (IValidatable).
		 *
		 * Viewport abstract base class does not manage invalidation through
		 * the BlittingEngine; therefore, validation commit stage must be
		 * implemented via inheritance.
		 */
		public function validate():void
		{
			invalidated = false;
		}

		/**
		 * addedToStageHandler
		 */
		protected function addedToStageHandler(event:Event):void
		{
			// remove added to stage event listener.
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			// add removed from stage listener.
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		/**
		 * removedFromStageHandler
		 */
		protected function removedFromStageHandler(event:Event):void
		{
			// remove removed from stage event listener
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);

			// add added to stage event listener
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		/**
		 * dispose (IDisposable)
		 */
		override public function dispose():void
		{
			super.dispose();

			// remove children
			while (numChildren > 0)
			{
				var displayObject:DisplayObject = removeChildAt(0);

				if (displayObject is IDisposable)
					IDisposable(displayObject).dispose();
			}

			// remove added to stage event listener
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			// remove removed from stage event listener
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

	}
}
