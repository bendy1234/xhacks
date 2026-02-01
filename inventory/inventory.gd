extends Resource

class_name Inv

@export var items: Array[InvItem]

func insert(item: InvItem):
	for i in range(items.size()):
		if items[i] == null:
			items[i] = item
			break
