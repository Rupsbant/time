package  
{
	import engine.TimeField;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.core.ButtonAsset;
	import org.cove.ape.AbstractParticle;
	import org.cove.ape.APEngine;
	import org.cove.ape.CircleParticle;
	import org.cove.ape.Group;
	import org.cove.ape.RectangleParticle;
	import org.cove.ape.Vector2D;
	public class UI
	{
		private var stage:Stage;
		
		internal var start:Sprite;
		internal var fixed:Sprite;
		internal var movable:Sprite;
		internal var timeField:Sprite;
		internal var circle:Sprite;
		internal var square:Sprite;
				
		private var white:uint = 0xffffff;
		private var red:uint = 0xFF0000;
		private var green:uint = 0x00FF00;
		private var blue:uint = 0x0000FF;
		private var black:uint = 0X000000;
		
		private var next:Function = function():void{trace("nothing")};
		private var post:Function = function():void{trace("nothing")};;
		
		public function UI(stage:Stage ) 
		{
			this.stage = stage;
			initUI();
			stage.addEventListener(MouseEvent.CLICK, function(evt : MouseEvent) { next(evt);} );
		}
			

		private function initUI() : void {
			initBackground();
			initSelect();
			initFigure();
			initStart();
		}
		
		private function initStart() : void {
			var w : Number = 40;
			var h : Number = 40;
			var sprite:Sprite = new Sprite();
			sprite.graphics.clear();
			sprite.graphics.beginFill(red, 1);
			sprite.graphics.drawRect(0, 0, w, h);
			sprite.graphics.endFill();
			sprite.x = 30;
			sprite.y = 300;
			sprite.rotation = 0;
			stage.addChild(sprite);
			sprite.addEventListener(MouseEvent.CLICK, activate);
			start = sprite;
		}
		
		private function run(evt:Event):void {
			APEngine.step();
			APEngine.paint();
		}
		
		private function activate(arg : MouseEvent) :void {
			stage.addEventListener(Event.ENTER_FRAME, run);
			start.addEventListener(MouseEvent.CLICK, deactivate);
			start.removeEventListener(MouseEvent.CLICK, activate);
		}
		
		private function deactivate(arg : MouseEvent) : void {
			stage.removeEventListener(Event.ENTER_FRAME, run);
			start.addEventListener(MouseEvent.CLICK, activate);
			start.removeEventListener(MouseEvent.CLICK, deactivate);
		}
		
		private function initFigure() : void {
			initFigureCircle();
			initFigureSquare();
		}
		
		private function initFigureSquare() : void {
			var w : Number = 40;
			var h : Number = 40;
			var sprite:Sprite = new Sprite();
			sprite.graphics.clear();
			sprite.graphics.beginFill(black, 1);
			sprite.graphics.drawRect(0, 0, w, h);
			sprite.graphics.endFill();
			sprite.x = 30;
			sprite.y = 230;
			sprite.rotation = 0;
			stage.addChild(sprite);
			sprite.addEventListener(MouseEvent.CLICK,
				function(arg:MouseEvent):void {
					next = function(bla:MouseEvent):void{
					next = function(co1:MouseEvent):void {
						trace("part 1");
						next = function(co2:MouseEvent):void { 
							trace("part 2");
							next = function(co3:MouseEvent):void {
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
								next = function():void{};
							};
						}
					}
					};
				}
				
			);
		}
		
		private function initFigureCircle() : void {
			var sprite:Sprite = new Sprite();
			sprite.graphics.clear();
			sprite.graphics.beginFill(black, 1);
			sprite.graphics.drawCircle(0, 0, 20);
			sprite.graphics.endFill();
			sprite.x = 50;
			sprite.y = 200;
			sprite.rotation = 0;
			stage.addChild(sprite);
			sprite.addEventListener(MouseEvent.CLICK,
				function(arg:MouseEvent):void {
					next = function(bla:MouseEvent):void{
					next = function(co1:MouseEvent):void {
						trace("part 1");
						next = function(co2:MouseEvent):void { 
							trace("part 2");
							var radius:Number = new Vector2D(co1.stageX, co1.stageY).distance(new Vector2D(co2.stageX, co2.stageY));
							var circ:CircleParticle = new CircleParticle(co1.stageX, co1.stageY, radius);
							post(circ);
							next = function():void{};
							};
					}}
					;
				}
				
			);
		}
		
		private function initSelect() : void {
			initSelectFixed();
			initSelectMovable();
			initSelectTimeField();
		}
		
		private function initSelectTimeField() : void {
			var sprite:Sprite = new Sprite();
			sprite.graphics.clear();
			sprite.graphics.beginFill(blue, 1);
			sprite.graphics.drawCircle(0, 0, 20);
			sprite.graphics.endFill();
			sprite.x = 50;
			sprite.y = 130;
			sprite.rotation = 0;
			stage.addChild(sprite);
			sprite.addEventListener(MouseEvent.CLICK, function(arg:MouseEvent):void { 
				post = function(ap:AbstractParticle):void {
					var tf:TimeField = new TimeField(ap.sprite, 0.125);
					ap.fixed = true;
					Hello.timeFields.push(tf);
					trace("maak een timefield "+ap+" "+ap.position);
					var g:Group = new Group();
					g.addParticle(ap);
					APEngine.addGroup(g);
					for each(var ap:AbstractParticle in Hello.particles) {
						ap.addTimeField(tf);
					}
					}
				}
			);
		}
		
		private function initSelectMovable() : void {
			var sprite:Sprite = new Sprite();
			sprite.graphics.clear();
			sprite.graphics.beginFill(green, 1);
			sprite.graphics.drawCircle(0, 0, 20);
			sprite.graphics.endFill();
			sprite.x = 50;
			sprite.y = 80;
			sprite.rotation = 0;
			stage.addChild(sprite);
			sprite.addEventListener(MouseEvent.CLICK, function(arg:MouseEvent):void { 
					post = function(ap:AbstractParticle):void {
					trace("maak een movable");
					Hello.particles.push(ap);
					for each(var tf:TimeField in Hello.timeFields) {
						ap.addTimeField(tf);
					}
					var g:Group = new Group();
					g.addParticle(ap);
					APEngine.addGroup(g);
					}} );
		}
		
		private function initSelectFixed() : void {
			var sprite:Sprite = new Sprite();
			sprite.graphics.clear();
			sprite.graphics.beginFill(red, 1);
			sprite.graphics.drawCircle(0, 0, 20);
			sprite.graphics.endFill();
			sprite.x = 50;
			sprite.y = 30;
			sprite.rotation = 0;
			stage.addChild(sprite);
			sprite.addEventListener(MouseEvent.CLICK, function(arg:MouseEvent):void { 
				post = function(ap:AbstractParticle):void {
					trace("maak een fixed");
					ap.fixed = true;
					Hello.particles.push(ap);
					for each(var tf:TimeField in Hello.timeFields) {
						ap.addTimeField(tf);
					}
					var g:Group = new Group();
					g.addParticle(ap);
					APEngine.addGroup(g);
					}} );
		}
		
		private function initBackground() : void {
			var w:Number = 100;
			var h:Number = stage.stageHeight;
			var sprite:Sprite = new Sprite();
			sprite.graphics.clear();
			//sprite.graphics.lineStyle(lineThickness, lineColor, lineAlpha);
			sprite.graphics.beginFill(white, 1);
			sprite.graphics.drawRect(0, 0, w, h);
			sprite.graphics.endFill();	
			sprite.x = 0;
			sprite.y = 0;
			sprite.rotation = 0;
			stage.addChild(sprite);
		}
		
	}

}