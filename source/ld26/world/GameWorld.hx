/*
*/

package ld26.world;

import com.haxepunk.HXP;
import com.haxepunk.World;

import ash.core.Engine;
import ash.core.Entity;
import ash.core.System;

import ld26.service.SoundService;
import ld26.service.InputService;
import ld26.service.EntityService;
import ld26.service.AnimationService;
import ld26.system.InputSystem;
import ld26.system.MovementSystem;
import ld26.system.RenderingSystem;
import ld26.component.Control;


#if profiler
	import ld26.system.ProfileSystem;
	import ld26.service.ProfileService;
#end

class GameWorld extends World
{
	private var ash:Engine;
	private var nextSystemPriority:Int = 0;
	private var factory:EntityService;

	public function new()
	{
		super();
	}

	override public function begin()
	{
		ash = new Engine();
		factory = new EntityService(ash);

		#if profiler
			ProfileService.init();
		#end

		AnimationService.init();

		initSystems();
		initEntities();

		#if profiler
			var e = new Entity();
			e.add(new ProfileControl());
			ash.addEntity(e);
		#end
	}

	private function initSystems()
	{
		addSystem(new InputSystem(ash, factory)); // Collect player/inventory input
		addSystem(new MovementSystem(ash, factory)); // Real-time entity movement
		addSystem(new RenderingSystem(ash)); // Display entities are created/destroyed/updated
	}	

    public function addSystem(system:System):Void
    {
    	#if profiler
    		var name = Type.getClassName(Type.getClass(system));
    		ash.addSystem(new ProfileSystem(name, true), nextSystemPriority++);
    	#end

        ash.addSystem(system, nextSystemPriority++);

    	#if profiler
    		ash.addSystem(new ProfileSystem(name, false), nextSystemPriority++);
    	#end
    }

	private function initEntities()
	{
		factory.addBackground();
		factory.addFireControl();
		factory.addOrb(HXP.halfWidth, HXP.halfHeight);
		factory.addTube();
	}

	override public function update()
	{
		if(InputService.pressed(InputService.DEBUG))
		{
			#if flash
				haxe.Log.clear();
			#end
		}

		ash.update(HXP.elapsed); // Update Ash (entity system)
		super.update(); // Update HaxePunk (game library)
	}
}