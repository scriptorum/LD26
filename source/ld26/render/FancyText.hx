package ld26.render;

import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Graphiclist;

class FancyText extends Graphiclist
{
	private var texts:Array<Text>;
	private var font:String;

	public function new(str:String, color:Int, size:Int, x:Float, y:Float, scrollFactor:Float = 1, 
		font:String = "font/aesymatt.ttf")
	{
		super();
		this.x = x;
		this.y = y;
		this.font = font;
		texts = new Array<Text>();
		texts.push(makeText(str, 0x000000, size, 2, 2, scrollFactor));
		texts.push(makeText(str, color, size, 0, 0, scrollFactor));

		for(t in texts)
			add(t);
	}

	public function setString(str:String): Void
	{
		for(t in texts)
			t.text = str;
	}

	public function setAlpha(alpha:Float): Void
	{
		for(t in texts)
			t.alpha = alpha;
	}

	public function getWidth(): Float
	{
		return texts[0].width + 2;	
	}

	private function makeText(str:String, color:Int, size:Int, x:Float, y:Float, scrollFactor:Float): Text
	{
		var options = { color:color, font:font, size:size, resizable:false };
		var t = new Text(str, x, y, 0, 0, options);
		t.scrollX = t.scrollY = scrollFactor;
		add(t);
		return t;
	}
}