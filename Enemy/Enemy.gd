extends KinematicBody

onready var bul = preload("res://Enemy/EnemyBullet.tscn")
onready var mk = preload("res://EnemyMarker/Marker.tscn")

var bullet
var can_fire = true
var time_delay = false
var arrow
var pointer

######################             GW TUTS

func shoot():
	if can_fire:
		bullet = bul.instance()
		add_child(bullet)
		can_fire = false
		time_delay = true
	
	if time_delay:
		if bullet.is_colliding():
			var collided_body = bullet.get_collider()
			if collided_body.is_in_group("Player"):
				var marker = mk.instance()
				marker.player = collided_body
				marker.enemy = self.name
				if ! self.name in collided_body.enemynumber:
					collided_body.enemynumber.append(self.name)
					arrow = marker.get_node("Arrow")
					pointer = marker.get_node("Pointer")
					collided_body.get_node("Markers").add_child(marker)
					rotatemarker()
				elif self.name in collided_body.enemynumber:
					rotatemarker()
					
			bullet.queue_free()
			time_delay = false
			yield(get_tree().create_timer(0.2) ,"timeout")
			can_fire = true
			
func _process(delta):
	shoot()

func rotatemarker():
	pointer.modulate.a = 1
	arrow.look_at(self.global_transform.origin ,Vector3.UP)
	pointer.rect_rotation = arrow.rotation_degrees.y * -1
