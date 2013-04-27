package ld26.render;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;
import ld26.component.Animation;

class AnimationView extends View
{
	private var animation:Animation = null;

	override public function begin()
	{
		nodeUpdate();
	}

	private function setAnim()
	{
		animation = getComponent(Animation);
		if(animation == null)
		{
			graphic = null;
			return;
		}

		var cbFunc:CallbackFunction = (animation.looping ? null : animationFinished);
		var spritemap = new Spritemap(HXP.getBitmap(animation.image.path),
			Std.int(animation.subdivision.plot.width), 
			Std.int(animation.subdivision.plot.height), 
			cbFunc);
		spritemap.add("main", animation.frames, animation.speed, animation.looping);
		spritemap.play("main");
		graphic = spritemap;
	}

	private function animationFinished(): Void
	{
		entity.remove(Animation);
	}

	override public function nodeUpdate()
	{
		super.nodeUpdate();
		
		// Change/update animation
		var curAnim = getComponent(Animation);
		if(curAnim != animation)
			setAnim();
	}
}