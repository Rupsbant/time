package {
	
	import org.cove.ape.*;
	
	public class Surfaces extends Group {
		
		public function Surfaces(colA:uint, colB:uint, colC:uint, colD:uint, colE:uint) {
			
			var floor:RectangleParticle = new RectangleParticle(340,327,550,50,0,true);
			floor.setStyle(0, colD, 1, colD);
			addParticle(floor);
			
			var ceil:RectangleParticle = new RectangleParticle(325,-33,649,80,0,true);
			ceil.setStyle(0, colD, 1, colD);
			addParticle(ceil);

			var rampRight:RectangleParticle = new RectangleParticle(375,220,390,20,0.405,true);
			rampRight.setStyle(0, colD, 1, colD);
			addParticle(rampRight);
			
			var rampLeft:RectangleParticle = new RectangleParticle(90,200,102,20,-.7,true);
			rampLeft.setStyle(0, colD, 1, colD);
			addParticle(rampLeft);
			
			var rampLeft2:RectangleParticle = new RectangleParticle(96,129,102,20,-.7,true);
			rampLeft2.setStyle(0, colD, 1, colD);
			addParticle(rampLeft2);
			
			var rampCircle:CircleParticle = new CircleParticle(175,190,60,true);
			rampCircle.setStyle(1, colD, 1, colB);
			addParticle(rampCircle);
			
			var floorBump:CircleParticle = new CircleParticle(600,660,400,true);
			floorBump.setStyle(1, colD, 1, colB);
			addParticle(floorBump);
			
			var bouncePad:RectangleParticle = new RectangleParticle(35,370,40,60,0,true);
			bouncePad.setStyle(0, colD, 1, 0x996633);
			bouncePad.elasticity = 4;
			addParticle(bouncePad);
			
			var leftWall:RectangleParticle = new RectangleParticle(1,99,30,500,0,true);
			leftWall.setStyle(0, colD, 1, colD);
			addParticle(leftWall);
			
			var leftWallChannelInner:RectangleParticle = new RectangleParticle(54,300,20,150,0,true);
			leftWallChannelInner.setStyle(0, colD, 1, colD);
			addParticle(leftWallChannelInner);
			
			var leftWallChannel:RectangleParticle = new RectangleParticle(54,122,20,94,0,true);
			leftWallChannel.setStyle(0, colD, 1, colD);
			addParticle(leftWallChannel);
			
			var leftWallChannelAng:RectangleParticle = new RectangleParticle(75,65,60,25,- 0.7,true);
			leftWallChannelAng.setStyle(0, colD, 1, colD);
			addParticle(leftWallChannelAng);
			
			var topLeftAng:RectangleParticle = new RectangleParticle(23,11,65,40,-0.7,true);
			topLeftAng.setStyle(0, colD, 1, colD);
			addParticle(topLeftAng);
			
			var rightWall:RectangleParticle = new RectangleParticle(654,230,50,500,0,true);
			rightWall.setStyle(0, colD, 1, colD);
			addParticle(rightWall);
	
			var bridgeStart:RectangleParticle = new RectangleParticle(127,49,75,25,0,true);
			bridgeStart.setStyle(0, colD, 1, colD);
			addParticle(bridgeStart);
			
			var bridgeEnd:RectangleParticle = new RectangleParticle(483,55,100,15,0,true);
			bridgeEnd.setStyle(0, colD, 1, colD);
			addParticle(bridgeEnd);
		}
	}
}