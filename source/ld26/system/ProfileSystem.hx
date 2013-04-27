/*
 * Remove dependence on other Systems
 * Add overall frame rate logging.
 * Add percentage of app time not tracked by ProfileSystems 
 */
package ld26.system;

import ash.core.System;
import ash.ObjectMap;

import com.haxepunk.HXP;
import ld26.service.ProfileService;

class ProfileSystem extends System
{
	public var profile:Profile;
	public var opener:Bool;

	public function new(name:String, opener:Bool)
	{
		super();

		profile = ProfileService.getOrCreate(name);
		this.opener = opener;
	}

	override public function update(_)
	{	
		if(opener)
			profile.open();
		else profile.close();
	}
}