package ld26.service;

import scriptorum.Util;
import ld26.component.Animation;
import ld26.component.Image;
import ld26.component.Subdivision;

class AnimationService
{
	public static var animations:Hash<Animation>;

	public static function init()
	{
		animations = new Hash<Animation>();

		// addNewAnimation("boxMorphing", image, subdivision, "0-19", 24, true);
	}

	public static function addAnimation(name:String, animation:Animation): Animation
	{
		animations.set(name, animation);
		return animation;
	}

	public static function add(name:String, image:Image, subdivision:Subdivision, frameStr:Dynamic, speed:Float, looping:Bool = true): Animation 
	{
		return add(name, image, subdivision, frameStr, speed, looping);
	}

	public static function addNewAnimation(name:String, image:Image, subdivision:Subdivision, 
		frameStr:Dynamic, speed:Float, looping:Bool = true): Animation
	{
		var frames = parseFrames(frameStr);
		var animation = new Animation(image, subdivision, frames, speed, looping);
		return addAnimation(name, animation);
	}

	public static inline function get(name:String): Animation
	{
		return getAnimation(name);
	}

	public static inline function getAnimation(name:String): Animation
	{
		var anim = animations.get(name);
		if(anim == null)
			throw "Who told you '" + name + "' is a valid animation? Well, it's not.";
		return anim;
	}

	private static function parseFrames(frames:Dynamic): Array<Int>
	{
		if(Std.is(frames, Array))
				return cast frames;

		if(Std.is(frames, Int))
			return [cast(frames, Int)];

		// Treat as comma-separated string with hyphenated inclusive ranges
		var result = new Array<Int>();
		var tokens = Util.split(frames, ",");
		for(token in tokens)
		{
			// Single number
			if(token.indexOf("-") == -1)
				result.push(Std.parseInt(token));

			// Range of numbers min-max
			else
			{
				var parts = Util.split(token, "-");
				var min = Std.parseInt(parts[0]);
				var max = Std.parseInt(parts[1]);
				for(i in min...max+1)
					result.push(i);			
			}
		}
		return result;
	}
}
