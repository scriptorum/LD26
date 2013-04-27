
package ld26.system;

import ash.core.Engine;
import ash.core.System;
import ash.core.Node;

import com.haxepunk.HXP;

import ld26.render.ImageView;
import ld26.render.AnimationView;
import ld26.render.BackdropView;
import ld26.render.GridView;
import ld26.render.View;

import ld26.node.ViewNode;
import ld26.node.DisplayNode;

import ld26.component.Display;

class RenderingSystem extends System
{
	public var engine:Engine;

	public function new(engine:Engine)
	{
		super();
		this.engine = engine;
		engine.getNodeList(DisplayNode).nodeRemoved.add(displayNodeRemoved);
	}

	private function displayNodeRemoved(node:DisplayNode): Void
	{
		// trace("Removing a display node for entity " + node.entity.name);
		HXP.world.remove(node.display.view);
	}

	// TO DO respond to move events
	override public function update(_)
	{
		updateViews(BackdropNode, BackdropView);
		updateViews(GridNode, GridView);
		updateViews(ImageNode, ImageView);
		updateViews(AnimationNode, AnimationView);
	}

	private function updateViews<TNode:Node<TNode>>(nodeClass:Class<TNode>, viewClass:Class<View>)
	{
		// Loop through all nodes for this node class
	 	for(node in engine.getNodeList(nodeClass))
	 	{
	 		var entity = node.entity;

			// Create view if it does not exist
	 		if(!entity.has(Display))
	 		{
	 			var view:View = Type.createInstance(viewClass, [entity]);
				HXP.world.add(view);
				entity.add(new Display(view));
	 		}

	 		// Update the view
	 		entity.get(Display).view.nodeUpdate();
		}
	}	
}