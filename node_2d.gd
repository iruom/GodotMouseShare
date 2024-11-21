extends Node2D
var center = Vector2(100,100)
var peer = ENetMultiplayerPeer.new()
var pos = Vector2(0,0)
var is_host
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 画面中央にカーソルを移動
	#var screen_size = get_viewport().get_visible_rect().size
	#var center = screen_size / 2
	print("マウスカーソルを画面中央に移動しました: ", center)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Input.warp_mouse(center)
	#center = center - Vector2(1,1)
	if is_host:
		pos = get_global_mouse_position()

		mouseshare.rpc(pos)
	pass


func _on_server_pressed() -> void:
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	is_host = true
func _add_player(id=1):
	pass


func _on_client_pressed() -> void:
	peer.create_client("localhost",135)
	multiplayer.multiplayer_peer = peer
	is_host = false

@rpc("call_local")
func mouseshare(pos):
	Input.warp_mouse(pos)
