second = ["accident", "agree", "arrive", "astronomy", "atlas", "attention", "award", "aware", "balance", "banner", "bare", "base", "beach", "besides", "blast", "board", "bounce", "brain", "branch", "brave", "bright", "cage", "calf", "calm", "career", "center", "cheer", "chew", "claw", "clear", "cliff", "club", "collect", "connect", "core", "corner", "couple", "crowd", "curious", "damp", "dangerous", "dash", "dawn", "deep", "demolish", "design", "discard", "dive", "dome", "doubt", "dozen", "earth", "enemy", "evening", "exactly", "excess", "factory", "fair", "famous", "feast", "field", "finally", "flap", "float", "flood", "fold", "fresh", "frighten", "fuel", "gap", "gaze", "gift", "gravity", "greedy", "harm", "herd", "idea", "insect", "instrument", "invent", "island", "leader", "leap", "lizard", "local", "lonely", "luxury", "march", "mention", "motor", "nervous", "net", "nibble", "notice", "ocean", "pack", "pale", "parade", "past", "peak", "planet", "present", "proof", "reflect", "rumor", "safe", "scholar", "seal", "search", "settle", "share", "shelter", "shiver", "shy", "skill", "slight", "smooth", "soil", "stack", "steady", "strand", "stream", "support", "team", "telescope", "tiny", "tower", "travel", "tremble", "universe", "village", "warn", "weak", "wealthy", "whisper", "wise", "wonder", "worry", "yard", "zigzag"]

second_ids = []

second.each do |name|
	words = Word.where(name: name)
	second_ids << words[0].id
end

second_ids = [4413, 8252, 9037, 4415, 4416, 8259, 4420, 4425, 8265, 4427, 8281, 2422, 4431, 4433, 4435, 4451, 739, 8293, 4464, 2108, 4472, 4483, 9039, 3035, 4489, 8300, 4492, 4499, 8323, 8331, 4502, 4503, 8376, 8383, 4514, 8394, 8408, 8417, 4525, 8423, 4527, 4529, 8430, 8435, 9043, 4541, 4555, 9047, 8456, 4559, 8460, 1572, 8462, 8466, 8469, 4563, 9053, 4568, 8472, 9054, 8473, 8494, 4585, 4596, 4612, 4622, 9061, 4634, 4635, 4640, 9074, 4647, 3403, 4652, 4655, 4659, 4665, 4670, 4672, 4681, 9076, 4683, 8497, 4685, 8505, 8510, 4687, 8514, 4693, 4696, 4701, 8528, 899, 4711, 4722, 4724, 8540, 8547, 4746, 4752, 4760, 9078, 4763, 8552, 4775, 9096, 8559, 8562, 4777, 4786, 4809, 9103, 9110, 8577, 8583, 8585, 4819, 4831, 8590, 4836, 4846, 8598, 4855, 4877, 4880, 9114, 9115, 4883, 4892, 8608, 4894, 8611, 4905, 4909, 9119, 8615, 8622, 4910, 9122, 4918]

second_hsb_2 = ["agree", "astronomy", "attention", "award", "aware", "balance", "bare", "base", "beach", "bounce", "brain", "brave", "bright", "cage", "calm", "career", "center", "cheer", "chew", "claw", "clear", "club", "collect", "connect", "core", "corner", "couple", "crowd", "curious", "damp", "dash", "dawn", "deep", "design", "dome", "dozen", "earth", "enemy", "evening", "exactly", "excess", "fair", "famous", "field", "finally", "flap", "fold", "gap", "gravity", "greedy", "harm", "herd", "idea", "insect", "instrument", "leader", "leap", "lizard", "local", "lonely", "luxury", "march", "mention", "nervous", "net", "nibble", "ocean", "pack", "pale", "parade", "past", "peak", "proof", "reflect", "rumor", "scholar", "seal", "search", "settle", "share", "shy", "skill", "slight", "smooth", "soil", "stack", "steady", "strand", "stream", "support", "team", "travel", "tremble", "universe", "village", "warn", "weak", "wise", "wonder", "worry"]

second_hsb_2_ids = []

second_hsb_2.each do |name|
	words = Word.where(name: name)
	second_hsb_2_ids << words[0].id
end

second_hsb_2_ids = [8252, 4415, 8259, 4420, 4425, 8265, 8281, 2422, 4431, 739, 8293, 2108, 4472, 4483, 3035, 4489, 8300, 4492, 4499, 8323, 8331, 4503, 8376, 8383, 4514, 8394, 8408, 8417, 4525, 8423, 4529, 8430, 8435, 4541, 8456, 8460, 1572, 8462, 8466, 8469, 4563, 4568, 8472, 8473, 8494, 4585, 4622, 4640, 3403, 4652, 4655, 4659, 4665, 4670, 4672, 4683, 8497, 4685, 8505, 8510, 4687, 8514, 4693, 4701, 8528, 899, 4722, 4724, 8540, 8547, 4746, 4752, 4763, 8552, 4775, 8559, 8562, 4777, 4786, 4809, 8577, 8583, 8585, 4819, 4831, 8590, 4836, 4846, 8598, 4855, 4877, 4883, 4892, 8608, 4894, 8611, 4905, 8615, 8622, 4910]
