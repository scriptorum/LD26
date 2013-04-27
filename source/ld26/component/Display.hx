package ld26.component;

import ld26.render.View;

// Wraps a HaxePunk entity
class Display
{
	public var view:View;

	public function new(view:View)
	{
		this.view = view;
	}
}