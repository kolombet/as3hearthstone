package card.examples
{
    import away3d.cameras.Camera3D;
    import away3d.containers.Scene3D;
    import away3d.containers.View3D;
    import away3d.controllers.FirstPersonController;
    import away3d.filters.MotionBlurFilter3D;
    import away3d.materials.TextureMaterial;
    import away3d.utils.Cast;
    import flash.display.BitmapData;
    import flash.display.GradientType;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.BlurFilter;
    import flash.filters.GlowFilter;
    /**
     * ...
     * @author njf
     */
    public class AwaySprite3D extends Sprite 
    {
        protected var view:View3D;
        protected var camera:Camera3D;
        protected var scene:Scene3D;
        private var cameraController:FirstPersonController;
        protected var stageX:int;
        protected var stageY:int;
        //movement variables
        protected var drag:Number = 0.5;
        protected var walkIncrement:Number = 2;
        protected var strafeIncrement:Number = 2;
        protected var walkSpeed:Number = 0;
        protected var strafeSpeed:Number = 0;
        protected var walkAcceleration:Number = 0;
        protected var strafeAcceleration:Number = 0;
        //rotation variables
        private var move:Boolean = false;
        private var lastPanAngle:Number;
        private var lastTiltAngle:Number;
        private var lastMouseX:Number;
        private var lastMouseY:Number;
        private static const PARTICLE_NUM:int = 300;
        private static const PARTICLE_RADIUS:int = 14;
        private static const BLUR_RADIUS:int = 2;
        private static const K:Number = 0.0008;
        private var particles:Vector.<Particle> = new Vector.<Particle>;
        public function AwaySprite3D() 
        {
          init();
        }
        
    
        protected function init():void 
        {
            initEngine();
            initObjects();
            initListeners();
        }
        protected function initEngine():void 
        {
            view = new View3D();
            scene = view.scene;
            camera = view.camera;
            camera.lens.far = 14000;
            camera.lens.near = .05;
            camera.y = 0;
            camera.z = 600;
            //setup controller to be used on the camera
            cameraController = new FirstPersonController(camera, 180, 0, -80, 80);
            addChild(view);
        }
    
        protected function initListeners():void 
        {
            addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        }
        private function initObjects():void 
        {
            var sp:Sprite = new Sprite();
            var bmpd:BitmapData = new BitmapData((PARTICLE_RADIUS + BLUR_RADIUS)*4, (PARTICLE_RADIUS + BLUR_RADIUS)*4, true, 0x00000000);
            sp.graphics.beginGradientFill(GradientType.RADIAL, [0x00FFFF, 0x000000], [1, 1], [0, 255],null,"pad","rgb",0.2);
            sp.graphics.drawCircle(bmpd.width/2, bmpd.height/2, PARTICLE_RADIUS);
            sp.filters = [new BlurFilter(BLUR_RADIUS, BLUR_RADIUS, 3),new GlowFilter(0x00FFFF)];
            bmpd.draw(sp,null,null,null,null,true);
            for (var i:int = 0; i < PARTICLE_NUM; i++) 
            {
                var m:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(bmpd));
                m.alphaBlending = true;
                var p:Particle = new Particle(m, bmpd.width, bmpd.height);
                var d:int = 1000;
                var v:int = 30;
                p.x = r() * d;
                p.y = r() * d;
                p.z = r() * d;
                p.v.x = r() * v;
                p.v.y = r() * v;
                p.v.y = r() * v;
                scene.addChild(p);
                particles.push(p);
            
            }
            view.filters3d = [new MotionBlurFilter3D(0.1)];
            function r():Number {
                return Math.random() - 0.5;
            }
        }
    
        protected function onEnterFrameHandler(e:Event):void 
        {
            
            if (move) {
                cameraController.panAngle = 0.3*(stage.mouseX - lastMouseX) + lastPanAngle;
                cameraController.tiltAngle = 0.3*(stage.mouseY - lastMouseY) + lastTiltAngle;
                
            }
             for (var i:int = 0; i < PARTICLE_NUM; i++) {
                var p:Particle = particles[i];
                p.v.x -= p.x * K;
                p.v.y -= p.y * K;
                p.v.z -= p.z * K;
                p.x += p.v.x;
                p.y += p.v.y;
                p.z += p.v.z;
                
            }
            view.render();
        }
        /**
         * Mouse down listener for navigation
         */
        private function onMouseDown(event:MouseEvent):void
        {
            move = true;
            lastPanAngle = cameraController.panAngle;
            lastTiltAngle = cameraController.tiltAngle;
            lastMouseX = stage.mouseX;
            lastMouseY = stage.mouseY;
            stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
        }
        
            
            

             /**
         * Mouse up listener for navigation
         */
        private function onMouseUp(event:MouseEvent):void
        {
            move = false;
            stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
        }
        /**
         * Mouse stage leave listener for navigation
         */
        private function onStageMouseLeave(event:Event):void
        {
            move = false;
            stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
        }
    
    }
    

}



