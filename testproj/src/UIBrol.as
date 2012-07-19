package {
	import engine.DrawCircle;
	import engine.DrawRectangle;
	import engine.DrawWheel;
	import engine.TimeField;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.StaticText;
	import flash.text.TextField;
	import org.cove.ape.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	[SWF(width="650", height="350", backgroundColor="#334433")] 
	public class UIBrol extends Sprite {
		public static var timeFields:Vector.<TimeField> = new Vector.<TimeField>();
		public static var particles:Vector.<AbstractParticle> = new Vector.<AbstractParticle>;
		public static var collidables:Group = new Group(true);
		private var next:Function = function():void{trace("nothing")};		
		public static var post:Function = function():void{trace("nothing")};
		public static var p:UIPanel = new UIPanel();
		
		public function UIBrol() {
			var level:MovieClip = new MovieClip();
			level.graphics.beginFill(0x333333, 1); 
			level.graphics.drawRect(100,0,stage.stageWidth-100,stage.stageHeight);     
			level.graphics.endFill();
			stage.addChild(level);
			
			APEngine.init();
			APEngine.container = level;
			APEngine.addMasslessForce(new Vector2D(0, 3));
			APEngine.addGroup(collidables);
			
			stage.frameRate = 55;
			stage.addChild(p);
			var dr:DrawRectangle = new DrawRectangle(level);
			var dc:DrawCircle = new DrawCircle(level);
			var dw:DrawWheel = new DrawWheel(level);
			p.srec.addEventListener(MouseEvent.CLICK, 
					function():void {
						dw.reset();
						dc.reset();
						dr.run();
					});
			p.scir.addEventListener(MouseEvent.CLICK, 
					function():void {
						dw.reset();
						dc.run();
						dr.reset();
					});
					
			p.swhe.addEventListener(MouseEvent.CLICK, 
				function():void {
						dw.run();
						dc.reset();
						dr.reset();
				});

			p.ttim.addEventListener(MouseEvent.CLICK, function():void { post = engine.TypeTimeField.post; });
			p.tvar.addEventListener(MouseEvent.CLICK, function():void { post = engine.TypeVariable.post; } );					
			p.tfix.addEventListener(MouseEvent.CLICK, function():void { post = engine.TypeFixed.post; });					
			p.PlayPauseBtn.addEventListener(MouseEvent.CLICK, activate);
		}
		
		private function run(evt:Event):void {
			APEngine.step();
			APEngine.paint();
		}
		
		private function activate(arg : MouseEvent) :void {
			stage.addEventListener(Event.ENTER_FRAME, run);
			p.PlayPauseBtn.swapChildrenAt(1, 0);
			p.PlayPauseBtn.addEventListener(MouseEvent.CLICK, deactivate);
			p.PlayPauseBtn.removeEventListener(MouseEvent.CLICK, activate);
		}
		
		private function deactivate(arg : MouseEvent) : void {
			stage.removeEventListener(Event.ENTER_FRAME, run);
			p.PlayPauseBtn.swapChildrenAt(1, 0);
			p.PlayPauseBtn.addEventListener(MouseEvent.CLICK, activate);
			p.PlayPauseBtn.removeEventListener(MouseEvent.CLICK, deactivate);
		}
		
	}
}
