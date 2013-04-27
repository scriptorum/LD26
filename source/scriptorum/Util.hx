package scriptorum;

/*
 * Some general purpose Haxe functions.
 * Notably includes integer versions of some standard float Math funcs.
 * TODO Split into separate Util classes by usage or first parameter (for mixins)
 */
class Util
{
	public static function shuffle<T>(arr:Array<T>): Void
	{
        var i:Int = arr.length, j:Int, t:T;
        while (--i > 0)
        {
                t = arr[i];
                arr[i] = arr[j = rnd(0, i-1)];
                arr[j] = t;
        }
	}

	public static function anyOneOf<T>(arr:Array<T>): T
	{
		if(arr == null || arr.length == 0)
			return null;
		return arr[rnd(0, arr.length - 1)];
	}

	public static function rnd(min:Int,max:Int):Int
	{
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}	

	public static function fsign(v:Float): Int
	{
		if(v < 0.0)
			return -1;
		if(v > 0.0)
			return 1;
		return 0;
	}

	public static function sign(i:Int): Int
	{		
		if(i == 0)
			return 0;
		return i < 0 ? -1 : 1;
	}

	public static function min(a:Int, b:Int): Int
	{
		return (a < b ? a : b);
	}

	public static function max(a:Int, b:Int): Int
	{
		return (a > b ? a : b);
	}

	public static function abs(num:Int): Int
	{
		return (num < 0 ? -num : num);
	}

	public static function diff(a:Int, b:Int): Int
	{
		return (a > b ? a - b : b - a);
	}

    public static function assert( cond : Bool, ?pos : haxe.PosInfos )
    {
      if(!cond)
          haxe.Log.trace("Assert in " + pos.className + "::" + pos.methodName, pos);
    }

    // Same as String.split but empty strings result in an empty array
    public static function split(str:String, delim:String): Array<String>
    {
    	var arr = new Array<String>();
    	if(str == null || str.length == 0)
    		return arr;
    	return str.split(delim);
    }

    // Like Array.filter but returns an array of indeces to the array (keys), rather than the array values.
    // Also, the comparison func receives an array index, not an array value.
    public static function indexFilter<T>(arr:Array<T>, func:Int->Bool): Array<Int>
    {
    	var result = new Array<Int>();
    	for(i in 0...arr.length)
    	{
    		if(func(i))
    			result.push(i);
    	}
    	return result;
    }

    public static function find<T>(arr:Array<T>, obj:T): Int
    {
    	for(i in 0...arr.length)
    		if(arr[i] == obj)
    			return i;
    	return -1;
    }

    public static function contains<T>(arr:Array<T>, obj:T): Bool
    {
    	return (find(arr, obj) != -1);
    }
}