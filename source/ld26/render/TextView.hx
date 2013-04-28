package ld26.render;

import ld26.component.Text;// Note that you must set a totally new TextStyle object for a style change to be recognized
import ld26.render.FancyText;

class TextView extends View
{
	private var text:Text;
	private var display:FancyText;

	override public function begin()
	{
		nodeUpdate();
	}

	private function setText()
	{
		var textCompo = getComponent(Text);
		var style = textCompo.style;
		if(style == null)
			style = new TextStyle(0xFFFFFF, 14, "font/04B_03__.ttf");

		graphic = display = new FancyText(textCompo.message, style.color, style.size, 0, 0, 1, style.font);
	}

	override public function nodeUpdate()
	{
		super.nodeUpdate();

		// Image with Tile
		if(hasComponent(Text))
		{
			var textComp:Text = getComponent(Text);
			if(Text != null || text.message != textComp.message || text.style != textComp.style)
				setText();
		}
	}
}