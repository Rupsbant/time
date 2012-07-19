package engine 
{
	import org.cove.ape.APEngine;
	import org.cove.ape.Group;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Ingmar
	 */
	public class DrawAbstract 
	{
		protected var level:MovieClip;
		protected var next:Function = step1;
		protected var g:Group;
		
		public function DrawAbstract(mc:MovieClip) 
		{	
			level = mc;		
			g = new Group();
			APEngine.addGroup(g);
		}
		
		public function run():void {
			next = step1;
			level.addEventListener(MouseEvent.CLICK, step );
		}
		public function step(evt:MouseEvent):void { next = next(evt); }
		public function reset():void {
			level.removeEventListener(MouseEvent.CLICK, step);
		}
		
		public function step1(evt:MouseEvent):Function {
			return step1;
		}
		
	}

}