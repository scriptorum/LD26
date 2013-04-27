package ld26.render;

import ld26.component.Layer;
import ld26.component.ScrollFactor;
import ld26.component.Offset;
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

		// Update offset
		if(hasComponent(Offset))
		{
			var o = getComponent(Offset);
			if(o.x != originX || o.y != originY)
			{
				originX = cast o.x;
				originY = cast o.y;
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