require "src/ECS/ECSIncludes"


-- ====== COMPONENTS
PositionComponent   = require "src/CommOp1/ECS/Component/PositionComponent"
SpriteComponent     = require "src/CommOp1/ECS/Component/SpriteComponent"
UserInputComponent     = require "src/CommOp1/ECS/Component/UserInputComponent"
DestinationComponent     = require "src/CommOp1/ECS/Component/DestinationComponent"
SelectableComponent     = require "src/CommOp1/ECS/Component/SelectableComponent"
ActionComponent     = require "src/CommOp1/ECS/Component/ActionComponent"
FactionComponent     = require "src/CommOp1/ECS/Component/FactionComponent"
ClickBoxComponent     = require "src/CommOp1/ECS/Component/ClickBoxComponent"
SkillListComponent     = require "src/CommOp1/ECS/Component/SkillListComponent"


-- ====== SYSTEMS
SpriteRenderer   = require "src/CommOp1/ECS/System/SpriteRenderer"
SpriteRendererGUI   = require "src/CommOp1/ECS/System/SpriteRendererGUI"
CharacterController   = require "src/CommOp1/ECS/System/CharacterController"
InputConverter   = require "src/ECS/Systems/InputConverter"
DestinationDrawer   = require "src/CommOp1/ECS/System/DestinationDrawer"
SelectionSystem   = require "src/CommOp1/ECS/System/SelectionSystem"
ClickableSystem   = require "src/CommOp1/ECS/System/ClickableSystem"
SkillBarLayoutSystem   = require "src/CommOp1/ECS/System/SkillBarLayoutSystem"


-- ====== FACTORIES
Character = require "src/CommOp1/ECS/Factory/Character"
Skill = require "src/CommOp1/ECS/Factory/Skill"
SkillBar = require "src/CommOp1/ECS/Factory/SkillBar"
