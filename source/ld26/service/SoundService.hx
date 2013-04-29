package ld26.service;

import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import nme.media.SoundChannel;
import nme.Assets;
import nme.events.Event;

class SoundService extends Input
{
	public static inline var FIRE:String = "fire.wav";
	public static inline var EATEN:String = "eaten.wav";
	public static inline var START:String = "start.wav";
	public static inline var CHARGE:String = "charge.wav";
	public static inline var SATISFIED:String = "satisfied.wav";

	private static var playing:Array<SoundChannel>;

	public static function init()
	{
		clearPlayingList();
	}

	public static function clearPlayingList()
	{
		playing = new Array<SoundChannel>();
	}

	public static function playRepeat(name:String, ?cb:Dynamic->Void): SoundChannel
	{
		return play(name, cb, 0x3FFFFFFF);
	}

	public static function play(name:String, ?cb:Dynamic->Void, ?loops = 0): SoundChannel
	{
		var sfx = Assets.getSound("audio/" + name);
		if(sfx == null)
		{
			trace("Could not play sound " + name);
			return null;
		}

		var channel = sfx.play(0, loops);

		if(cb != null)
			channel.addEventListener (Event.SOUND_COMPLETE, cb);

		playing.push(channel);
		channel.addEventListener (Event.SOUND_COMPLETE, function(evt:nme.events.Event) { 
			SoundService.playing.remove(evt.target); 
		});

		return channel;
	}

	public static function stopAll(): Void
	{
		for(channel in playing)
			channel.stop();
		clearPlayingList();
	}
}