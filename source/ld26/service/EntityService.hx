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
import ld26.component.Scale;
import ld26.component.Image;
import ld26.component.Layer;
import ld26.component.Offset;
import ld26.component.Origin;
import ld26.component.Position;
import ld26.component.Rotation;
import ld26.component.Repeating;
import ld26.component.ScrollFactor;
import ld26.component.Tile;
import ld26.component.Tube;
import ld26.component.Orb;

class EntityService
{
	public static inline var CONTROL:String = "control";

	public var ash:Engine;
	public var nextId:Int = 0;

	public function new(ash:Engine)
	{
		this.ash = ash;
	}

	public function makeEntity(prefix:String): Entity
	{
		var name = prefix + nextId++;
		return new Entity(name);
	}

	// Finds or makes a named entity
	public function resolveEntity(name:String): Entity
	{
		var e = ash.getEntityByName(name);
		if(e != null)
			return e;
		return add(new Entity(name));
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

	public function addBackground(): Entity
	{
		var e = new Entity();
		e.add(new Layer(Layer.BACK));
		e.add(new Image("art/background.png"));
		return addTo(e, 0, 0);
	}

	public function addFireControl(): Entity
	{
		var e = resolveEntity(CONTROL);
		e.add(new FireControl());
		return e;
	}

	public function removeFireControl(): Entity
	{
		var e = resolveEntity(CONTROL);
		e.remove(FireControl);
		return e;
	}

	public function addCrosshair(x:Float, y:Float): Entity
	{
		var e = makeEntity("crosshair");
		e.add(new Layer(Layer.CROSSHAIR));
		e.add(new Image("art/crosshair.png"));
		e.add(new Offset(-8, -8));
		return addTo(e, x, y);
	}

	public function addOrb(x:Float, y:Float, size:Float): Entity
	{
		var subdivision = new Subdivision(2, 1, new Size(128, 128));
		var e = makeEntity("orb");
		e.add(new Layer(Layer.ORB));
		e.add(new Image("art/orb.png"));
		e.add(new Tile(subdivision, 0));
		e.add(new Offset(-64, -64));
		e.add(new Scale(1, 1));
		e.add(new Orb(size));
		return addTo(e, x, y);
	}

	public function addTube(orb:Entity): Entity
	{
		var e = resolveEntity("tube");
		e.add(new Layer(Layer.TUBE));
		e.add(new Image("art/tube.png"));
		e.add(new Offset(0, -4));
		e.add(new Rotation(0));
		e.add(new Origin(0, 4));
		e.add(new Tube(orb));
		e.add(new Position(0,0));
		return e;
	}
}
