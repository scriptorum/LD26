package ld26.component;

class TextStyle 
{
	public var color:Int;
	public var size:Int;
	public var font:String;

	public function new(color:Int, size:Int, font:String)
	{
		this.color = color;
		this.size = size;
		this.font = font;
	}
}

class Text
{
	public var message:String;
	public var style:TextStyle;

	public function new(message:String, style:TextStyle = null)
	{
		this.message = message;
		this.style = style;
	}
}