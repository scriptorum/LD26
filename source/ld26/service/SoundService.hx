package ld26.service;

import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import nme.media.SoundChannel;
import nme.Assets;
import nme.events.Event;

class SoundService extends Input
{
	public static inline var BLIP1:String = "sfx/blip1.wav";
	public static inline var BLIP2:String = "sfx/blip1.wav";

	public static function init()
	{
	}

	public static function playRepeat(name:String, ?cb:Dynamic->Void): SoundChannel
	{
		return play(name, cb, 0x3FFFFFFF);
	}

	public static function play(name:String, ?cb:Dynamic->Void, ?loops = 0): SoundChannel
	{
		var sfx = Assets.getSound(name);
		if(sfx == null)
		{
			trace("Could not play sound " + name);
			return null;
		}

		var channel = sfx.play(0, loops);

		if(cb != null)
			channel.addEventListener (Event.SOUND_COMPLETE, cb);

		return channel;
	}
}