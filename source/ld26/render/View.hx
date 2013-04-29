package ld26.render;

import ld26.component.Layer;
import ld26.component.ScrollFactor;
import ld26.component.Origin;
import ld26.component.Scale;
import ld26.component.Rotation;
import ld26.component.Offset;
import ld26.component.Position;
import ld26.component.Invisible;

import ash.core.Entity;

class View extends com.haxepunk.Entity
{
	public var entity:Entity;

	public function new(entity:Entity)
	{
		super();

		this.entity = entity;
		begin();
		nodeUpdate();

		// trace("Created view from " + entity.name + " with position " + x + "," + y);
	}

	public function hasComponent<T>(component:Class<T>): Bool
	{
		return entity.has(component);
	}

	public function getComponent<T>(component:Class<T>): T
	{
		var instance:T = entity.get(component);
		if(instance == null)
			throw("Cannot get component " + Type.getClassName(component) + " for entity " + entity.name);
		return instance;
	}

	public function begin(): Void
	{
		// Override
	}

	// If you override this, call super
	public function nodeUpdate(): Void
	{
		if(graphic == null)
			return;

		visible = !hasComponent(Invisible);
		if(!visible)
			return;

		// For certain view subclasses
		var img:com.haxepunk.graphics.Image = Std.is(graphic, com.haxepunk.graphics.Image) ? cast graphic : null;

		// Update layer
		if(hasComponent(Layer))
		{
			var newLayer = getComponent(Layer).layer;
			if(newLayer != this.layer)
				this.layer = newLayer;
		}

		// Update scroll factor
		if(hasComponent(ScrollFactor))
		{
			if(graphic != null)
			{
				var amount = getComponent(ScrollFactor).amount;
				var graphic = cast(graphic, com.haxepunk.Graphic);
				if(amount != graphic.scrollX || amount != graphic.scrollY)
					graphic.scrollX = graphic.scrollY = amount;
			}
		}

		var scale = null;
		var scaleChanged = false;
		if(img != null)
		{
			// Update scaling
			if(hasComponent(Scale))
			{
				scale = getComponent(Scale);
				if(scale.x != img.scaleX || scale.y != img.scaleY)
				{
					img.scaleX = scale.x;
					img.scaleY = scale.y;
					scaleChanged = true;
				}
			}

			// Update origin
			if(hasComponent(Origin))
			{
				var o = getComponent(Origin);
				if(o.x != img.originX || o.y != img.originY || scaleChanged)
				{
					img.originX = cast o.x; // HaxePunk scales origin for us
					img.originY = cast o.y; // But then they shift the position too! 
					img.x = cast(scale == null ? o.x : o.x * scale.x); // So calculate the scaled origin
					img.y = cast(scale == null ? o.y : o.y * scale.y); // And move the position back
				}
			}
			else if(img.originX != 0 || img.originY != 0)
				img.originX = img.originY = 0;	

			// Update rotation
			if(hasComponent(Rotation))
			{
				if(img != null)
				{
					var rotation = getComponent(Rotation);
					if(rotation.angle != img.angle)
						img.angle = -rotation.angle; // clockwise, thank you
				}
			}
		}

		// Update position
		if(hasComponent(Position))
		{
			// Update offset
			var offsetX:Float = 0;
			var offsetY:Float = 0;
			if(hasComponent(Offset))
			{
				var o = getComponent(Offset);
				offsetX = (scale == null ? o.x : o.x * scale.x);
				offsetY = (scale == null ? o.y : o.y * scale.y);
			}

			var pos = getComponent(Position);
			var newx = pos.x + offsetX;
			var newy = pos.y + offsetY;
			if(newx != x || newy != y)
			{
				x = newx;
				y = newy;
			}
		}
	}
}