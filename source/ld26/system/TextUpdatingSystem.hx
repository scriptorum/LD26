package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;
import ash.core.Node;

import ld26.service.EntityService;
import ld26.component.Text;
import ld26.component.Parent;
import ld26.component.Firework;

class ChildTextNode extends Node<ChildTextNode>
{
	public var text:Text;
	public var parent:Parent;
}

class TextUpdatingSystem extends System
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
	 	for(node in engine.getNodeList(ChildTextNode))
	 	{
	 		if(node.parent.entity.has(Firework))
	 		{
	 			var amount = node.parent.entity.get(Firework).amount;
	 			node.text.message = Std.string(Math.floor(amount));
	 		}
	 	}
	}
}