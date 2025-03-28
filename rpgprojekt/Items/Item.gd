extends Resource

class_name Item

@export var name: String
@export var texture: Texture2D
@export_enum("Weapon", "Armor", "Revitalizer", "Story Item") var type:String
@export var stack_amnt: int
@export var item_path: String
