package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;

import com.haxepunk.HXP;

import ld26.service.EntityService;
import ld26.service.SoundService;
import ld26.component.Control;

class RestartSystem extends System
{
	public var factory:EntityService;
	public var engine:Engine;

	public function new(engine:Engine, factory:EntityService)
	{
		super();
		this.engine = engine;
		this.factory = factory;
	}

	override public function update(time:Float)
	{
		var restart = engine.getEntityByName("restart");
		if(restart == null)
			return;

		engine.removeAllEntities();
		initEntities();

		#if profiler
			var e = new Entity();
			e.add(new ProfileControl());
			engine.addEntity(e);
		#end

		SoundService.play(SoundService.START);
	}

	private function initEntities()
	{
		factory.addBackground();
		factory.addFireControl();
		var orb = factory.addOrb(HXP.halfWidth, HXP.halfHeight, 200);
		factory.addTube(orb);

		// factory.addCrosshair(HXP.halfWidth, HXP.halfHeight);
		// factory.addCrosshair(0,0);

		factory.addFirework(180, 180, 60);
		factory.addFirework(350, 480, 40);
		factory.addFirework(64, 500, 20);
	}
}