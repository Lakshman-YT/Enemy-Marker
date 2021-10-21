extends Spatial

onready var marker = $Pointer
onready var arrow = $Arrow

var player 
var enemy

######################             GW TUTS

func _process(delta):
	marker.modulate.a -= delta
	
	if marker.modulate.a <= 0:
			player.enemynumber.erase(enemy)
			queue_free()
