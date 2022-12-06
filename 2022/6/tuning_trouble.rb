signal = File.read("signal.txt")

def find_uniq_signal(signal, length)
    [*0..signal.length].each do |idx|
        packet = signal.slice(idx, length)
    
        if packet.chars.uniq.length == packet.length
            return idx + length
        end 
    end
end

def find_start_of_packet_idx(signal)
    find_uniq_signal(signal, 4)
end

def find_start_of_message_idx(signal)
    find_uniq_signal(signal, 14)
end

puts "(Part 1) Start of packet marker #{find_start_of_packet_idx(signal)}"
puts "(Part 2) Start of message marker #{find_start_of_message_idx(signal)}"

