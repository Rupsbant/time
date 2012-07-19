package {
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
		private var post:Function = function():void{trace("nothing")};
		private var p:UIPanel = new UIPanel();
		
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
			level.addEventListener(MouseEvent.CLICK, function(evt : MouseEvent):void { next(evt); } );
			p.srec.addEventListener(MouseEvent.CLICK,
				function(arg:MouseEvent):void {
					
					var rectSelect:Function = function(co1:MouseEvent):void {
						trace("part 1");
						var sprite:Sprite = new Sprite();
						level.addChild(sprite);
						var drawl:Function = function(evt:MouseEvent):void {
							level.removeChild(sprite);
							sprite.graphics.clear();
							sprite.graphics.lineStyle(5,0x00FF00);
							sprite.graphics.moveTo(co1.stageX, co1.stageY);
							sprite.graphics.lineTo(evt.stageX, evt.stageY);
							level.addChild(sprite);
						}
						level.addEventListener(MouseEvent.MOUSE_MOVE, drawl);
						var tempRect:RectangleParticle = new RectangleParticle(0, 0, 0, 0);
						level.addChild(tempRect.sprite);
						var g:Group = new Group();
						g.addParticle(tempRect);
						APEngine.addGroup(g);
						next = function(co2:MouseEvent):void { 
							var drawl2:Function = function(evt:MouseEvent):void {
								level.removeChild(tempRect.sprite);
								var breedt:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(co2.stageX, co2.stageY));
								var dx:Number = (co1.stageX - co2.stageX);
								var dy:Number = (co1.stageY - co2.stageY);
								var dx0:Number = (co1.stageX - evt.stageX);
								var dy0:Number = (co1.stageY - evt.stageY);
								var proj:Number = (dx*dy0-dy*dx0)/breedt;
								var angl:Number = Math.atan2(dy, dx)+Math.PI;
								var newX : Number = co1.stageX + breedt / 2 * Math.cos( -angl) + proj / 2 * Math.sin( -angl);
								var newY : Number = co1.stageY - breedt / 2 * Math.sin( -angl) + proj / 2 * Math.cos( -angl);
								g.removeParticle(tempRect);
								tempRect = new RectangleParticle(newX, newY, breedt, proj, angl);
								tempRect.setFill(0x00ff00);
								g.addParticle(tempRect);
								
							}
							level.removeEventListener(MouseEvent.MOUSE_MOVE, drawl);
							level.addEventListener(MouseEvent.MOUSE_MOVE, drawl2);
							sprite.graphics.clear();
							trace("part 2");
							next = function(co3:MouseEvent):void {
								g.removeParticle(tempRect);
								level.removeEventListener(MouseEvent.MOUSE_MOVE, drawl2);
								var breedt:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(co2.stageX, co2.stageY));
								var dx:Number = (co1.stageX - co2.stageX);
								var dy:Number = (co1.stageY - co2.stageY);
								var dx0:Number = (co1.stageX - co3.stageX);
								var dy0:Number = (co1.stageY - co3.stageY);
								var proj:Number = (dx*dy0-dy*dx0)/breedt;
								var angl:Number = Math.atan2(dy, dx)+Math.PI;
								var newX : Number = co1.stageX + breedt / 2 * Math.cos( -angl) + proj / 2 * Math.sin( -angl);
								var newY : Number = co1.stageY - breedt / 2 * Math.sin( -angl) + proj / 2 * Math.cos( -angl);
								
								var recht:RectangleParticle = new RectangleParticle(newX, newY, breedt, proj, angl);
								post(recht);
								next = rectSelect;
							};
						}
					}
					next = rectSelect; } );
					
					
				
			
			p.scir.addEventListener(MouseEvent.CLICK,
				function(arg:MouseEvent):void {
					
					var sprite:Sprite = new Sprite();
					level.addChild(sprite);
					var cirSelect:Function = function(co1:MouseEvent):void {
						var drawc:Function = function(evt:MouseEvent):void {
							level.removeChild(sprite);
							sprite.graphics.clear();
							sprite.graphics.beginFill(0x00FF00);
							var radius:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(evt.stageX, evt.stageY));
							sprite.graphics.drawCircle(0, 0, radius);
							sprite.graphics.endFill();
							sprite.x = co1.stageX;
							sprite.y = co1.stageY;
							level.addChild(sprite);
						}
						level.addEventListener(MouseEvent.MOUSE_MOVE, drawc);
						trace("part 1");
						next = function(co2:MouseEvent):void { 
							level.removeEventListener(MouseEvent.MOUSE_MOVE, drawc);
							sprite.graphics.clear();
							trace("part 2");
							var radius:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(co2.stageX, co2.stageY));
							var circ:CircleParticle = new CircleParticle(co1.stageX, co1.stageY, radius);
							post(circ);
							next = cirSelect;
							};
					};
					next = cirSelect;
					}
			);
			
			p.swhe.addEventListener(MouseEvent.CLICK,
				function(arg:MouseEvent):void {
					
					var sprite:Sprite = new Sprite();
					level.addChild(sprite);
					var cirSelect:Function = function(co1:MouseEvent):void {
						var drawc:Function = function(evt:MouseEvent):void {
							level.removeChild(sprite);
							sprite.graphics.clear();
							sprite.graphics.beginFill(0x00FF00);
							var radius:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(evt.stageX, evt.stageY));
							sprite.graphics.drawCircle(0, 0, radius);
							sprite.graphics.endFill();
							sprite.x = co1.stageX;
							sprite.y = co1.stageY;
							level.addChild(sprite);
						}
						level.addEventListener(MouseEvent.MOUSE_MOVE, drawc);
						trace("part 1");
						next = function(co2:MouseEvent):void { 
							level.removeEventListener(MouseEvent.MOUSE_MOVE, drawc);
							sprite.graphics.clear();
							trace("part 2");
							var radius:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(co2.stageX, co2.stageY));
							var circ:WheelParticle = new WheelParticle(co1.stageX, co1.stageY, radius);
							post(circ);
							next = cirSelect;
							};
					};
					next = cirSelect;
					}
			);
			
			p.ttim.addEventListener(MouseEvent.CLICK, function(arg:MouseEvent):void { 
				post = function(ap:AbstractParticle):void {
					var tf:TimeField = new TimeField(ap.sprite, p.TimeFieldFactorSld.value/100.0);
					ap.fixed = true;
					timeFields.push(tf);
					trace("maak een timefield "+ap+" "+ap.position);
					var g:Group = new Group();
					g.addParticle(ap);
					APEngine.addGroup(g);
					for each(var ap:AbstractParticle in UIBrol.particles) {
						ap.addTimeField(tf);
					}
					}
				}
			);
			
			p.tvar.addEventListener(MouseEvent.CLICK, function(arg:MouseEvent):void { 
					post = function(ap:AbstractParticle):void {
					trace("maak een movable");
					UIBrol.particles.push(ap);
					for each(var tf:TimeField in UIBrol.timeFields) {
						ap.addTimeField(tf);
					}
					collidables.addParticle(ap);
					}} );
					
			p.tfix.addEventListener(MouseEvent.CLICK, function(arg:MouseEvent):void { 
				post = function(ap:AbstractParticle):void {
					trace("maak een fixed");
					ap.fixed = true;
					UIBrol.particles.push(ap);
					for each(var tf:TimeField in UIBrol.timeFields) {
						ap.addTimeField(tf);
					}
					collidables.addParticle(ap);
					}} );
					
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
