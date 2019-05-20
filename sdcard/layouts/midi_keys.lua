require "keybow"

-- Experimental MIDI layout --

arp = false
arp_start = 0
last_note = 0
current_time = 0

arp_speed = 200

sequence = {0x4f, 0x53, 0x56}
next_sequence = false

function tick(time)
   current_time = time
   if arp then
       t = time - arp_start
       note_index = ((t / arp_speed) % 3) + 1
       note_index = math.floor(note_index)
       note = sequence[note_index] - 12
       if not (note == last_note) then
           keybow.send_midi_note(0, last_note, 0x7f, false)
           keybow.send_midi_note(0, note, 0x7f, true)
            if not (next_sequence == false) then
             sequence = next_sequence
             next_sequence = false
            end
       end
       last_note = note
          else
       if last_note > 0 then
           keybow.send_midi_note(0, last_note, 0x7f, false)
       end
   end
end

function setup()
    for x=0, 0x7f do
    keybow.send_midi_note(0, x, 0x7f, false)
    end
end

-- Key mappings --

function chord(a, b, c, pressed)
    keybow.send_midi_note(0, a, 0x7f, pressed)
    keybow.send_midi_note(0, b, 0x7f, pressed)
    keybow.send_midi_note(0, c, 0x7f, pressed)
end

function handle_key_00(pressed)
    --keybow.set_key("0", pressed)
    chord(0x50, 0x52, 0x55, pressed)
end

function handle_key_01(pressed)
    chord(0x49, 0x51, 0x53, pressed)
end

function handle_key_02(pressed)
    chord(0x48, 0x50, 0x52, pressed)
end

function handle_key_03(pressed)
    chord(0x4f, 0x53, 0x56, pressed)
end

function handle_key_04(pressed)
    chord(0x51, 0x54, 0x59, pressed)
end

function handle_key_05(pressed)
    chord(0x53, 0x56, 0x59, pressed)
end

function handle_key_06(pressed)
    --keybow.set_key("4", pressed)
   if pressed then
   arp_start = current_time
   arp = not arp
   end
end

function handle_key_07(pressed)
    arp_speed = arp_speed - 1
    if arp_speed < 1 then
        arp_speed = 1
    end
end

function handle_key_08(pressed)
    arp_speed = arp_speed + 1
end

function handle_key_09(pressed)
--    keybow.set_key("7", pressed)
    next_sequence = {0x4f, 0x53, 0x56}
end

function handle_key_10(pressed)
--    keybow.set_key("8", pressed)
    next_sequence = {0x4f, 0x51, 0x59}
end

function handle_key_11(pressed)
    --keybow.set_key("9", pressed)
    next_sequence = {0x4f, 0x51, 0x56}
end
