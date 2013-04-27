#if nme

import ld26.Main;
import nme.Assets;
import nme.events.Event;


class ApplicationMain {
	
	static var mPreloader:NMEPreloader;

	public static function main () {
		
		var call_real = true;
		
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		
		nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		
		if (loaded < total || true) /* Always wait for event */ {
			
			call_real = false;
			mPreloader = new com.haxepunk.Preloader();
			nme.Lib.current.addChild(mPreloader);
			mPreloader.onInit();
			mPreloader.onUpdate(loaded,total);
			nme.Lib.current.addEventListener (nme.events.Event.ENTER_FRAME, onEnter);
			
		}
		
		
		#if !fdb
		haxe.Log.trace = flashTrace;
		#end
		
		if (call_real)
			begin ();
	}

	#if !fdb
	private static function flashTrace( v : Dynamic, ?pos : haxe.PosInfos ) {
		var className = pos.className.substr(pos.className.lastIndexOf('.') + 1);
		var message = className+"::"+pos.methodName+":"+pos.lineNumber+": " + v;
		
        if (flash.external.ExternalInterface.available)
			flash.external.ExternalInterface.call("console.log", message);
		else untyped flash.Boot.__trace(v, pos);
    }
	#end
	
	private static function begin () {
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields(ld26.Main))
		{
			if (methodName == "main")
			{
				hasMain = true;
				break;
			}
		}
		
		if (hasMain)
		{
			Reflect.callMethod (ld26.Main, Reflect.field (ld26.Main, "main"), []);
		}
		else
		{
			var instance = Type.createInstance(ld26.Main, []);
			if (Std.is (instance, nme.display.DisplayObject)) {
				nme.Lib.current.addChild(cast instance);
			}	
		}
		
	}

	static function onEnter (_) {
		
		var loaded = nme.Lib.current.loaderInfo.bytesLoaded;
		var total = nme.Lib.current.loaderInfo.bytesTotal;
		mPreloader.onUpdate(loaded,total);
		
		if (loaded >= total) {
			
			nme.Lib.current.removeEventListener(nme.events.Event.ENTER_FRAME, onEnter);
			mPreloader.addEventListener (Event.COMPLETE, preloader_onComplete);
			mPreloader.onLoaded();
			
		}
		
	}

	public static function getAsset (inName:String):Dynamic {
		
		
		if (inName=="art/background.png")
			 
            return Assets.getBitmapData ("art/background.png");
         
		
		if (inName=="art/orb.png")
			 
            return Assets.getBitmapData ("art/orb.png");
         
		
		if (inName=="art/tube.png")
			 
            return Assets.getBitmapData ("art/tube.png");
         
		
		if (inName=="audio/blip1.wav")
			 
            return Assets.getSound ("audio/blip1.wav");
         
		
		if (inName=="audio/blip2.wav")
			 
            return Assets.getSound ("audio/blip2.wav");
         
		
		if (inName=="audio/Witches of a Village.mp3")
			 
            return Assets.getSound ("audio/Witches of a Village.mp3");
         
		
		if (inName=="font/04B_03__.ttf")
			 
			 return Assets.getFont ("font/04B_03__.ttf");
		 
		
		if (inName=="font/aesymatt.ttf")
			 
			 return Assets.getFont ("font/aesymatt.ttf");
		 
		
		if (inName=="font/GruntReaper.ttf")
			 
			 return Assets.getFont ("font/GruntReaper.ttf");
		 
		
		if (inName=="font/SF Intellivised.ttf")
			 
			 return Assets.getFont ("font/SF Intellivised.ttf");
		 
		
		if (inName=="font/Unxgala.ttf")
			 
			 return Assets.getFont ("font/Unxgala.ttf");
		 
		
		if (inName=="font/vademecu.ttf")
			 
			 return Assets.getFont ("font/vademecu.ttf");
		 
		
		if (inName=="gfx/debug/console_debug.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_debug.png");
         
		
		if (inName=="gfx/debug/console_logo.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_logo.png");
         
		
		if (inName=="gfx/debug/console_output.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_output.png");
         
		
		if (inName=="gfx/debug/console_pause.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_pause.png");
         
		
		if (inName=="gfx/debug/console_play.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_play.png");
         
		
		if (inName=="gfx/debug/console_step.png")
			 
            return Assets.getBitmapData ("gfx/debug/console_step.png");
         
		
		if (inName=="gfx/preloader/haxepunk.png")
			 
            return Assets.getBitmapData ("gfx/preloader/haxepunk.png");
         
		
		if (inName=="font/04B_03__.ttf")
			 
			 return Assets.getFont ("font/04B_03__.ttf");
		 
		
		if (inName=="gfx/haxepunk.png")
			 
            return Assets.getBitmapData ("gfx/haxepunk.png");
         
		
		
		return null;
		
	}
	
	
	private static function preloader_onComplete (event:Event):Void {
		
		mPreloader.removeEventListener (Event.COMPLETE, preloader_onComplete);
		
		nme.Lib.current.removeChild(mPreloader);
		mPreloader = null;
		
		begin ();
		
	}
	
}

class NME_art_background_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_art_orb_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_art_tube_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_audio_blip1_wav extends nme.media.Sound { }
class NME_audio_blip2_wav extends nme.media.Sound { }
class NME_audio_witches_of_a_village_mp3 extends nme.media.Sound { }
class NME_font_04b_03___ttf extends nme.text.Font { }
class NME_font_aesymatt_ttf extends nme.text.Font { }
class NME_font_gruntreaper_ttf extends nme.text.Font { }
class NME_font_sf_intellivised_ttf extends nme.text.Font { }
class NME_font_unxgala_ttf extends nme.text.Font { }
class NME_font_vademecu_ttf extends nme.text.Font { }
class NME_gfx_debug_console_debug_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_logo_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_output_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_pause_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_play_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_debug_console_step_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_gfx_preloader_haxepunk_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_font_5 extends nme.text.Font { }
class NME_gfx_haxepunk_png extends nme.display.BitmapData { public function new () { super (0, 0); } }


#else

import ld26.Main;

class ApplicationMain {
	
	public static function main () {
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields(ld26.Main))
		{
			if (methodName == "main")
			{
				hasMain = true;
				break;
			}
		}
		
		if (hasMain)
		{
			Reflect.callMethod (ld26.Main, Reflect.field (ld26.Main, "main"), []);
		}
		else
		{
			var instance = Type.createInstance(ld26.Main, []);
			if (Std.is (instance, flash.display.DisplayObject)) {
				flash.Lib.current.addChild(cast instance);
			}
		}
		
	}

}

#end
