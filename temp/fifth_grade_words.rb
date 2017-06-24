fifth = ["abolish", "absurd", "abuse", "access", "accomplish", "achievement", "aggressive", "alternate", "altitude", "antagonist", "antonym", "anxious", "apparent", "approximate", "aroma", "assume", "astound", "available", "avalanche", "banquet", "beverage", "bland", "blizzard", "budge", "bungle", "cautiously", "challenge", "character", "combine", "companion", "compassion", "compensate", "comply", "compose", "concept", "confident", "convert", "course", "courteous", "crave", "debate", "decline", "dedicate", "deprive", "detect", "dictate", "document", "duplicate", "edible", "endanger", "escalate", "evade", "exasperate", "excavate", "exert", "exhibit", "exult", "feeble", "frigid", "gigantic", "gorge", "guardian", "hazy", "hearty", "homonym", "identical", "illuminate", "immense", "impressive", "independent", "industrious", "intense", "intercept", "jubilation", "kin", "luxurious", "major", "miniature", "minor", "mischief", "monarch", "moral", "myth", "narrator", "navigate", "negative", "nonchalant", "numerous", "oasis", "obsolete", "occasion", "overthrow", "pardon", "pasture", "pedestrian", "perish", "petrify", "portable", "prefix", "preserve", "protagonist", "provide", "purchase", "realistic", "reassure", "reign", "reliable", "require", "resemble", "retain", "retire", "revert", "route", "saunter", "seldom", "senseless", "sever", "slither", "sluggish", "soar", "solitary", "solo", "sparse", "spurt", "strategy", "suffix", "suffocate", "summit", "suspend", "synonym", "talon", "taunt", "thrifty", "translate", "tropical", "visible", "visual", "vivid", "wilderness", "withdraw"]

fifth_ids = [
	9265, 6096, 9266, 5057, 6099, 9273, 6101, 9274, 6104, 1060, 9284, 6107, 3912,
	6109, 6114, 267, 6125, 9285, 9288, 6126, 6130, 874, 9291, 6134, 9293, 9296,
	6136, 6145, 9298, 6155, 9308, 6159, 6165, 9310, 5563, 6166, 9316, 9328, 6169,
	9341, 6171, 6177, 6188, 9343, 9346, 6192, 6197, 6203, 6211, 6213, 6215, 6216,
	6220, 9347, 6223, 3224, 9351, 9353, 9357, 6226, 6227, 9360, 6231, 9361, 6233,
	9366, 6234, 6237, 9371, 6238, 4360, 1755, 6244, 6247, 9373, 9376, 991, 6250,
	992, 6265, 6267, 2426, 9378, 6269, 6270, 6273, 9379, 6285, 6286, 680, 9380,
	9386, 9390, 9395, 6288, 9399, 6290, 2895, 6293, 9400, 9409, 882, 9411, 6302,
	6305, 9416, 9421, 9424, 6307, 9428, 6308, 6319, 6321, 6326, 9432, 6329, 9433,
	6333, 9435, 9438, 9444, 9451, 9458, 9459, 6334, 6336, 6338, 6345, 9462, 8011,
	9468, 6349, 6351, 6353, 9469, 9473, 6363, 2053, 6369, 9476
]

fifth.each do |name|
	words = Word.where(name: name)
	fifth_ids << words[0].id
end

fifth_hsb_2 = ["absurd", "abuse", "access", "accomplish", "achievement", "altitude", "antagonist", "antonym", "anxious", "apparent", "approximate", "aroma", "astound", "available", "avalanche", "bland", "blizzard", "budge", "cautiously", "character", "companion", "compassion", "compensate", "comply", "compose", "concept", "confident", "convert", "courteous", "debate", "decline", "dedicate", "duplicate", "edible", "endanger", "escalate", "exasperate", "feeble", "frigid", "gigantic", "gorge", "guardian", "hazy", "hearty", "homonym", "identical", "illuminate", "immense", "impressive", "independent", "industrious", "intercept", "luxurious", "major", "miniature", "mischief", "moral", "myth", "narrator", "navigate", "nonchalant", "obsolete", "occasion", "overthrow", "pardon", "pasture", "perish", "petrify", "portable", "prefix", "preserve", "protagonist", "provide", "purchase", "realistic", "reassure", "reliable", "require", "retain", "retire", "revert", "route", "saunter", "seldom", "senseless", "sever", "spurt", "strategy", "suffix", "summit", "suspend", "synonym", "taunt", "thrifty", "tropical", "visible", "visual", "vivid", "wilderness", "withdraw"]

fifth_hsb_2_ids = []

fifth_hsb_2.each do |name|
	words = Word.where(name: name)
	fifth_hsb_2_ids << words[0].id
end

fifth_hsb_2_ids = [6096, 9266, 5057, 6099, 9273, 6104, 1060, 9284, 6107, 3912, 6109, 6114, 6125, 9285, 9288, 874, 9291, 6134, 9296, 6145, 6155, 9308, 6159, 6165, 9310, 5563, 6166, 9316, 6169, 6171, 6177, 6188, 6203, 6211, 6213, 6215, 6220, 9353, 9357, 6226, 6227, 9360, 6231, 9361, 6233, 9366, 6234, 6237, 9371, 6238, 4360, 6244, 9376, 991, 6250, 6265, 2426, 9378, 6269, 6270, 9379, 680, 9380, 9386, 9390, 9395, 9399, 6290, 2895, 6293, 9400, 9409, 882, 9411, 6302, 6305, 9421, 9424, 9428, 6308, 6319, 6321, 6326, 9432, 6329, 9433, 9459, 6334, 6336, 6345, 9462, 8011, 6349, 6351, 9469, 9473, 6363, 2053, 6369, 9476]
