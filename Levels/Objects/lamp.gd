class_name Lamp extends Node3D

@export var is_flickering: bool = true
@export var flicker_noise: NoiseTexture2D

var time_passed: float = 0.0
var base_light_energy: float = 0.0

@onready var lamp: MeshInstance3D = %Lamp
@onready var omni_light: OmniLight3D = %OmniLight3D


func _ready() -> void:
	base_light_energy = omni_light.light_energy
	lamp.mesh.surface_set_material(0, lamp.mesh.surface_get_material(0).duplicate())
	if flicker_noise:
		flicker_noise.noise.seed = randi_range(0, 1000)


func _process(delta: float) -> void:
	if flicker_noise and is_flickering:
		time_passed += delta
		var flicker_noise_value: float = abs(flicker_noise.noise.get_noise_1d(time_passed))
		lamp.mesh.surface_get_material(0).emission_energy_multiplier = flicker_noise_value
		omni_light.light_energy = base_light_energy * flicker_noise_value
