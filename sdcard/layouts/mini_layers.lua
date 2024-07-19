require "keybow"
require "layers/mini_programmer"
require "layers/mini_linux"


-- define layers --

num_layers = 2
layers = {
    [1] = layer_programmer,
    [2] = layer_linux
}

last_layer = 1
current_layer = 1

-- check for layer change --

current_time = 0
last_pressed = current_time

function tick(time)
   current_time = time
end

function layer_changer(delay)
    if (current_time - last_pressed <= delay) then
        if (current_layer + 1 > num_layers) then
            current_layer = 1
        else
            current_layer = current_layer + 1
        end
        layers[current_layer].setup()
    end
    last_pressed = current_time
end

-- Keybow MINI --

function setup()
    keybow.use_mini()
    keybow.auto_lights(false)
    keybow.clear_lights()
    keybow.set_pixel(2, 255, 0, 0)
    layers[current_layer].setup()
end

-- Key mappings --

function handle_minikey_00(pressed)
    layers[current_layer].handle_minikey_00(pressed)
end

function handle_minikey_01(pressed)
    layers[current_layer].handle_minikey_01(pressed)
end

function handle_minikey_02(pressed)
    if pressed then
        layer_changer(200)
    end
    layers[current_layer].handle_minikey_02(pressed)
end
