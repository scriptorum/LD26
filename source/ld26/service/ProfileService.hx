package ld26.service;

import com.haxepunk.HXP;

class Profile
{
	public var startTime:Int = -1;
	public var totalTime:Int = 0;	
	public var totalCalls:Int = 0;
	public var name:String;

	public function new(name:String)
	{
		this.name = name;
	}

	public function open(): Profile
	{
		startTime = nme.Lib.getTimer();
		return this;
	}

	public function close(): Profile
	{
		// Damn you for trying to close a closed profile; you think you're funny wise guy? 
		if(startTime == -1)
			return this;

		var endTime = nme.Lib.getTimer();
		totalTime += (endTime - startTime);
		totalCalls++;
		startTime = -1;
		return this;
	}
}

class ProfileService
{
	private static var stats:Hash<Profile>;

	public static function init()
	{
		if(stats == null)
			stats = new Hash<Profile>();
	}

	public static function create(name:String): Profile
	{
		var profile = new Profile(name);
		stats.set(name, profile);

		if(stats.get(name) == null)
			throw("Creation didn't stick!");

		return profile;
	}

	public static function get(name:String): Profile
	{
		return stats.get(name);
	}

	public static function getOrCreate(name:String): Profile
	{
		var profile = get(name);
		if(profile == null)
			profile = create(name);
		return profile;
	}

	public static function reset(): Void
	{
		for(profile in stats)
		{
			profile.startTime = -1;
			profile.totalTime = 0;
			profile.totalCalls = 0;
		}		
	}

	public static function dump()
	{
		var totalTime:Int = 0;
		for(profile in stats)
			totalTime += profile.totalTime;
		
		trace("PROFILE:");
		for(name in stats.keys())
			logProfile(name, totalTime);
	}

	public static function logProfile(name:String, totalTime:Int)
	{
		var profile = stats.get(name);
		trace(name + ": " + 
			format(profile.totalTime / 1000) + 
			" sec overall (" + format(profile.totalTime / totalTime * 100)  +  "%), " + profile.totalCalls + 
			" calls, " + 
			format(profile.totalTime / profile.totalCalls) + 
			"ms/call, " +
			format(profile.totalCalls / profile.totalTime * 1000) +
			" calls/sec");
	}

	public static function format(time:Float): String
	{
		return cast HXP.round(time, 2);
	}
}