package ld26.service;

import com.haxepunk.HXP;

import ash.core.Engine;
import ash.core.Entity;

import ld26.component.Animation;
import ld26.component.Control;
import ld26.component.Display;
import ld26.component.Grid;
import ld26.component.Subdivision;
import ld26.component.Size;
import ld26.component.Image;
import ld26.component.Layer;
import ld26.component.Offset;
import ld26.component.Position;
import ld26.component.Repeating;
import ld26.component.ScrollFactor;
import ld26.component.Tile;

class EntityService
{
	public static inline var CONTROL:String = "control";

	public var ash:Engine;

	public function new(ash:Engine)
	{
		this.ash = ash;
	}

	public function resolveEntity(name:String): Entity
	{
		var e = ash.getEntityByName(name);
		if(e == null)
			e = new Entity(name);
		return e;
	}

	public function add(entity:Entity): Entity
	{
		ash.addEntity(entity);
		return entity;
	}

	public function addTo(e:Entity, x:Float, y:Float): Entity
	{
		e.add(new Position(x, y));
		return add(e);
	}

	public function addFireControl(): Entity
	{
		var e = resolveEntity(CONTROL);
		e.add(new FireControl());
		return add(e);
	}

	public function addOrb(x:Float, y:Float): Entity
	{
		var subdivision = new Subdivision(2, 1, new Size(128, 128));
		var e = new Entity();
		e.add(new Layer(Layer.MIDDLE));
		e.add(new Image("art/orb.png"));
		e.add(new Tile(subdivision, 0));
		e.add(new Offset(64, 64));
		return addTo(e, x, y);
	}

	public function addTube(): Entity
	{
		var e = new Entity();
		e.add(new Layer(Layer.MIDDLE));
		e.add(new Image("art/tube.png"));
		return add(e);
	}

	public function addBackground(): Entity
	{
		var e = new Entity();
		e.add(new Layer(Layer.FAR));
		e.add(new Image("art/background.png"));
		return addTo(e, 0, 0);
	}
}
