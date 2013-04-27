package ld26.render;

import ld26.component.Layer;
import ld26.component.ScrollFactor;
import ld26.component.Offset;
import ld26.component.Scale;
import ld26.component.Position;

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

		// Update scaling
		var scale = null;		
		if(hasComponent(Scale))
		{
			scale = getComponent(Scale);
			if(Std.is(graphic, com.haxepunk.graphics.Image))
			{
				var img:com.haxepunk.graphics.Image = cast graphic;
				if(scale.x != img.scaleX || scale.y != img.scaleY)
				{
					img.scaleX = scale.x;
					img.scaleY = scale.y;
				}
			}
		}

		// Update offset
		if(hasComponent(Offset))
		{
			var o = getComponent(Offset);
			var newOriginX:Int = cast(scale == null ? o.x : o.x * scale.x);
			var newOriginY:Int = cast(scale == null ? o.y : o.y * scale.y);
			if(newOriginX != originX || newOriginY != originY)
			{
				originX = newOriginX;
				originY = newOriginY;
			}
		}
		else if(originX != 0 || originY != 0)
			originX = originY = 0;	

		// Update position
		var pos = getComponent(Position);
		if(pos.x != x || pos.y != y)
		{
			x = pos.x - originX;
			y = pos.y - originY;
		}
	}
}