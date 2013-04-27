package ld26.service;

import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import nme.events.MouseEvent;

class InputService
{
	public static inline var DEBUG:String = "debug";

	public static function init()
	{
		Input.define(DEBUG, [Key.TAB]);
	}

	public static function onRightClick(cb:Dynamic->Void)
	{
		HXP.stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, cb);
	}

	public static function onRightClickRemove(cb:Dynamic->Void)
	{
		HXP.stage.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, cb);
	}

	// Convenience methods
	public static var mouseX(getMouseX, null):Int;
	private static function getMouseX():Int { return Input.mouseX; }
	public static var mouseY(getMouseY, null):Int;
	private static function getMouseY():Int { return Input.mouseY; }
	public static var clicked(getClicked, null):Bool;
	private static function getClicked():Bool { return Input.mouseReleased; }

	public static function check(input:Dynamic):Bool { return Input.check(input); }
	public static function pressed(input:Dynamic):Bool { return Input.pressed(input); }
	public static function released(input:Dynamic):Bool { return Input.released(input); }
	public static function lastKey(): Int { return Input.lastKey; }

	public static function clearLastKey(): Void { Input.lastKey = 0; }
}