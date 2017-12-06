ECSWorld          = require "src/ECS/ECSWorld"


Entity            = require "src/ECS/Entity/Entity"


Component                   = require "src/ECS/Components/Component"
AnimationsComponent         = require "src/ECS/Components/AnimationsComponent"
Box2DComponent              = require "src/ECS/Components/Box2DComponent"
CheckPointComponent         = require "src/ECS/Components/CheckPointComponent"
CheckPointSetterComponent   = require "src/ECS/Components/CheckPointSetterComponent"
DirectionComponent          = require "src/ECS/Components/DirectionComponent"
KillableComponent           = require "src/ECS/Components/KillableComponent"
MotionComponent             = require "src/ECS/Components/MotionComponent"
RopeOriginComponent         = require "src/ECS/Components/RopeOriginComponent"
SpriteComponent             = require "src/ECS/Components/SpriteComponent"
TeleporterComponent         = require "src/ECS/Components/TeleporterComponent"
UserInputComponent          = require "src/ECS/Components/UserInputComponent"



AnimationRenderer   = require "src/ECS/Systems/AnimationRenderer"
HeroController      = require "src/ECS/Systems/HeroController"
InputConverter      = require "src/ECS/Systems/InputConverter"
RectangleDrawer     = require "src/ECS/Systems/RectangleDrawer"
SpikeDrawer         = require "src/ECS/Systems/SpikeDrawer"
SpriteRenderer      = require "src/ECS/Systems/SpriteRenderer"
WallDrawer          = require "src/ECS/Systems/WallDrawer"
MotionAI            = require "src/ECS/Systems/MotionAI"
HangingBallRenderer = require "src/ECS/Systems/HangingBallRenderer"


SystemTest    = require "src/ECS/Systems/SystemTest"
SystemTest2    = require "src/ECS/Systems/SystemTest2"