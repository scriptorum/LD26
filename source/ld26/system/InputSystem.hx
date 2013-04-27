package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Node;
import ash.core.Entity;

import com.haxepunk.utils.Key;

import ld26.node.ControlNode;
import ld26.service.EntityService;
import ld26.service.InputService;

#if profiler
	import ld26.service.ProfileService;
#end

class InputSystem extends System
{
	public var engine:Engine;
	public var factory:EntityService;

	public function new(engine:Engine, factory:EntityService)
	{
		super();
		this.engine = engine;
		this.factory = factory;
	}

	override public function update(_)
	{
		var key = InputService.lastKey();
		if(key == 0)
			return;

		#if profiler
			handleProfileControl(key);
		#end
		handleFireControl(key);

		InputService.clearLastKey();
	}

#if profiler
	public function handleProfileControl(key:Int)
	{
	 	for(node in engine.getNodeList(ProfileControlNode))
	 	{
	 		switch(key)
	 		{
	 			case Key.LEFT_SQUARE_BRACKET:
	 			ProfileService.dump();
	 			ProfileService.reset();
	 		}
	 	}
	}
#end

	public function handleFireControl(key:Int)
	{
		var shiftIsDown = InputService.check(com.haxepunk.utils.Key.SHIFT);
	 	for(node in engine.getNodeList(FireControlNode))
	 	{
			switch(key)
			{
				case Key.SPACE:
				trace("Space");
			}
	 	}
	}
}