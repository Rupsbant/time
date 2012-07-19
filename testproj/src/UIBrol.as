package {
	import engine.TimeField;
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
		private var next:Function = function():void{trace("nothing")};		
		private var post:Function = function():void{trace("nothing")};
		private var p:UIPanel = new UIPanel();
		
		public function UIBrol() {
			APEngine.init();
			APEngine.container = stage;
			APEngine.addMasslessForce(new Vector2D(0, 3));
			
			stage.frameRate = 55;
			stage.addChild(p);
			stage.addEventListener(MouseEvent.CLICK, function(evt : MouseEvent) { next(evt);} );

			p.srec.addEventListener(MouseEvent.CLICK,
				function(arg:MouseEvent):void {
					next = function(bla:MouseEvent):void{
					var rectSelect:Function = function(co1:MouseEvent):void {
						trace("part 1");
						var sprite:Sprite = new Sprite();
						stage.addChild(sprite);
						var drawl:Function = function(evt:MouseEvent) {
							stage.removeChild(sprite);
							sprite.graphics.clear();
							sprite.graphics.lineStyle(5,0x00FF00);
							sprite.graphics.moveTo(co1.stageX, co1.stageY);
							sprite.graphics.lineTo(evt.stageX, evt.stageY);
							stage.addChild(sprite);
						}
						stage.addEventListener(MouseEvent.MOUSE_MOVE, drawl);
						var tempRect:RectangleParticle = new RectangleParticle(0, 0, 0, 0);
						stage.addChild(tempRect.sprite);
						next = function(co2:MouseEvent):void { 
							var drawl2:Function = function(evt:MouseEvent):void {
								stage.removeChild(tempRect.sprite);
								var breedt:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(co2.stageX, co2.stageY));
								var dx:Number = (co1.stageX - co2.stageX);
								var dy:Number = (co1.stageY - co2.stageY);
								var dx0:Number = (co1.stageX - evt.stageX);
								var dy0:Number = (co1.stageY - evt.stageY);
								var proj:Number = Math.abs(dx*dy0-dy*dx0)/breedt;
								var angl:Number = Math.atan2(dy, dx)+Math.PI;
								//x2 = x0+(x-x0)*cos(theta)+(y-y0)*sin(theta)
								//y2 = y0-(x-x0)*sin(theta)+(y-y0)*cos(theta)
								var newX : Number = co1.stageX + breedt / 2 * Math.cos( -angl) + proj / 2 * Math.sin( -angl);
								var newY : Number = co1.stageY - breedt / 2 * Math.sin( -angl) + proj / 2 * Math.cos( -angl);
								tempRect = new RectangleParticle(newX, newY, breedt, proj, angl);
								tempRect.setFill(0x00ff00);
								var g:Group = new Group();
								g.addParticle(tempRect);
								APEngine.addGroup(g);
							}
							stage.removeEventListener(MouseEvent.MOUSE_MOVE, drawl);
							stage.addEventListener(MouseEvent.MOUSE_MOVE, drawl2);
							sprite.graphics.clear();
							trace("part 2");
							next = function(co3:MouseEvent):void {
								stage.removeEventListener(MouseEvent.MOUSE_MOVE, drawl2);
								var breedt:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(co2.stageX, co2.stageY));
								var dx:Number = (co1.stageX - co2.stageX);
								var dy:Number = (co1.stageY - co2.stageY);
								var dx0:Number = (co1.stageX - co3.stageX);
								var dy0:Number = (co1.stageY - co3.stageY);
								var proj:Number = Math.abs(dx*dy0-dy*dx0)/breedt;
								var angl:Number = Math.atan2(dy, dx)+Math.PI;
								//x2 = x0+(x-x0)*cos(theta)+(y-y0)*sin(theta)
								//y2 = y0-(x-x0)*sin(theta)+(y-y0)*cos(theta)
								var newX : Number = co1.stageX + breedt / 2 * Math.cos( -angl) + proj / 2 * Math.sin( -angl);
								var newY : Number = co1.stageY - breedt / 2 * Math.sin( -angl) + proj / 2 * Math.cos( -angl);
								
								var recht:RectangleParticle = new RectangleParticle(newX, newY, breedt, proj, angl);
								post(recht);
								next = rectSelect;
							};
						}
					}
					next = rectSelect;};
					
				});
			
			p.scir.addEventListener(MouseEvent.CLICK,
				function(arg:MouseEvent):void {
					next = function(bla:MouseEvent):void {
					var sprite:Sprite = new Sprite();
					stage.addChild(sprite);
					var cirSelect:Function = function(co1:MouseEvent):void {
						var drawc:Function = function(evt:MouseEvent) {
							stage.removeChild(sprite);
							sprite.graphics.clear();
							sprite.graphics.beginFill(0x00FF00);
							var radius:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(evt.stageX, evt.stageY));
							sprite.graphics.drawCircle(0, 0, radius);
							sprite.graphics.endFill();
							sprite.x = co1.stageX;
							sprite.y = co1.stageY;
							stage.addChild(sprite);
						}
						stage.addEventListener(MouseEvent.MOUSE_MOVE, drawc);
						trace("part 1");
						next = function(co2:MouseEvent):void { 
							stage.removeEventListener(MouseEvent.MOUSE_MOVE, drawc);
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
					;
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
					var g:Group = new Group();
					g.addParticle(ap);
					APEngine.addGroup(g);
					}} );
					
			p.tfix.addEventListener(MouseEvent.CLICK, function(arg:MouseEvent):void { 
				post = function(ap:AbstractParticle):void {
					trace("maak een fixed");
					ap.fixed = true;
					UIBrol.particles.push(ap);
					for each(var tf:TimeField in UIBrol.timeFields) {
						ap.addTimeField(tf);
					}
					var g:Group = new Group();
					g.addParticle(ap);
					APEngine.addGroup(g);
					}} );
					
			p.PlayPauseBtn.addEventListener(MouseEvent.CLICK, activate);
		}
		
		private function run(evt:Event):void {
			
			APEngine.step();
			APEngine.paint();
		}
		
		private function activate(arg : MouseEvent) :void {
			stage.addEventListener(Event.ENTER_FRAME, run);
			p.PlayPauseBtn.addEventListener(MouseEvent.CLICK, deactivate);
			p.PlayPauseBtn.removeEventListener(MouseEvent.CLICK, activate);
		}
		
		private function deactivate(arg : MouseEvent) : void {
			stage.removeEventListener(Event.ENTER_FRAME, run);
			p.PlayPauseBtn.addEventListener(MouseEvent.CLICK, activate);
			p.PlayPauseBtn.removeEventListener(MouseEvent.CLICK, deactivate);
		}
		
	}
}
