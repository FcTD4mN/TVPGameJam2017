require "src/ECS/ECSIncludes"


-- ====== COMPONENTS
PositionComponent   = require "src/CommOp1/ECS/Component/PositionComponent"
SpriteComponent     = require "src/CommOp1/ECS/Component/SpriteComponent"
UserInputComponent     = require "src/CommOp1/ECS/Component/UserInputComponent"
DestinationComponent     = require "src/CommOp1/ECS/Component/DestinationComponent"


-- ====== SYSTEMS
SpriteRenderer   = require "src/CommOp1/ECS/System/SpriteRenderer"
CharacterController   = require "src/CommOp1/ECS/System/CharacterController"
InputConverter   = require "src/ECS/Systems/InputConverter"
DestinationDrawer   = require "src/CommOp1/ECS/System/DestinationDrawer"


-- ====== FACTORIES
LambdaCharacter = require "src/CommOp1/ECS/Factory/LambdaCharacter"
