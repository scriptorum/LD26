package ld26.service;

import ld26.service.InputService;
import com.haxepunk.HXP;
import com.haxepunk.utils.Ease;
import com.haxepunk.Tween;
import com.haxepunk.tweens.TweenEvent;
import nme.events.MouseEvent;

class CameraService
{
	private static var _camTween:Tween;

	public static function init()
	{
		InputService.onRightClick(rightClick);
	}

	public static function rightClick(evt:MouseEvent)
	{
		animCameraRel(InputService.mouseX - HXP.halfWidth, InputService.mouseY - HXP.halfHeight, .65);
	}

	public static function animCameraRel(x, y, duration)
	{
		animCameraTo(HXP.camera.x + x, HXP.camera.y + y, duration);
	}

	public static function animCameraTo(x, y, duration)
	{
		if(_camTween != null)
			HXP.tweener.removeTween(_camTween);
		_camTween = HXP.tween(HXP.camera, { x:x, y:y }, duration, 
			{ ease: Ease.expoOut, complete:cameraTweenFinish });
	}

	private static function cameraTweenFinish(evt:TweenEvent)
	{
		_camTween = null;
	}
}