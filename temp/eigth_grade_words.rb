eigth = ["abet", "accord", "adept", "advocate", "agile", "allot", "aloof", "amiss", "analogy", "anarchy", "antic", "apprehend", "ardent", "articulate", "assail", "assimilate", "atrocity", "attribute", "audacious", "augment", "authority", "avail", "avid", "awry", "balmy", "banter", "barter", "benign", "bizarre", "blase", "bonanza", "bountiful", "cache", "capacious", "caption", "chastise", "citadel", "cite", "clad", "clarify", "commemorate", "component", "concept", "confiscate", "connoisseur", "conscientious", "conservative", "contagious", "conventional", "convey", "crucial", "crusade", "culminate", "deceptive", "decipher", "decree", "deface", "defect", "deplore", "deploy", "desist", "desolate", "deter", "dialect", "dire", "discern", "disdain", "disgruntled", "dispatch", "disposition", "doctrine", "dub", "durable", "eccentric", "elite", "embargo", "embark", "encroach", "endeavor", "enhance", "enigma", "epoch", "era", "eventful", "evolve", "exceptional", "excerpt", "excruciating", "exemplify", "exotic", "facilitate", "fallacy", "fastidious", "feasible", "fend", "ferret", "flair", "flustered", "foreboding", "forfeit", "formidable", "fortify", "foster", "gaunt", "gingerly", "glut", "grapple", "grope", "gullible", "haggard", "haven", "heritage", "hindrance", "hover", "humane", "imperative", "inaugurate", "incense", "indifferent", "infinite", "instill", "institute", "intervene", "intricate", "inventive", "inventory", "irascible", "jurisdiction", "languish", "legendary", "liberal", "loll", "lucrative", "luminous", "memoir", "mercenary", "mien", "millennium", "minimize", "modify", "muse", "muster", "onslaught", "ornate", "ovation", "overt", "pang", "panorama", "perspective", "phenomenon", "pioneer", "pithy", "pivotal", "plausible", "plunder", "porous", "preposterous", "principal", "prodigy", "proficient", "profound", "pseudonym", "pungent", "rankle", "rational", "rebuke", "reception", "recourse", "recur", "renounce", "renown", "revenue", "rubble", "rue", "sage", "sedative", "serene", "servile", "shackle", "sleek", "spontaneous", "sporadic", "stamina", "stance", "staple", "stint", "strident", "sublime", "subside", "succumb", "surpass", "susceptible", "swelter", "tedious", "teem", "theme", "tirade", "tract", "transition", "trepidation", "turbulent", "tycoon", "ultimate", "ungainly", "vie", "vilify", "voracious", "wage", "wrangle"]

# Retrieves 100 random words and groups them by 20. Used to display in PDF

eigth.shuffle.take(100).sort.each_slice(20).to_a.each do |group|
	group.each do |word|
		puts word
	end
	puts
end

_.flatten
p _

# Retrieves the IDs of both all and HSB words for faster frontend lookup

eigth_ids = []

eigth.each do |name|
	words = Word.where(name: name)
	eigth_ids << words[0].id
end

eigth_ids = [10016, 3183, 5319, 5532, 5536, 5538, 5541, 5543, 5321, 5546, 10016, 3183, 5319, 5532, 5536, 5538, 5541, 5543, 5321, 5546, 10017, 5324, 5327, 5330, 10020, 5548, 10023, 5337, 2377, 10025, 5341, 10027, 5348, 5552, 10031, 10033, 5556, 10035, 5350, 10016, 3183, 5319, 5532, 5536, 5538, 5541, 5543, 5321, 5546, 10017, 5324, 5327, 5330, 10020, 5548, 10023, 5337, 2377, 10025, 5341, 10027, 5348, 5552, 10031, 10033, 5556, 10035, 5350, 10038, 10041, 5558, 10043, 5351, 5352, 5356, 10047, 10048, 5357, 5359, 5361, 5560, 5563, 5364, 5366, 5367, 10056, 5369, 10063, 5371, 5564, 10070, 5567, 5378, 10074, 5380, 10076, 5383, 5572, 5388, 5390, 10077, 1618, 5391, 5392, 10082, 5394, 10083, 5574, 5399, 3010, 5403, 10084, 3865, 5407, 5409, 5412, 5415, 10087, 10090, 10092, 5417, 10094, 5583, 5223, 5420, 5423, 10097, 10098, 5585, 5587, 5425, 5426, 5590, 10100, 5591, 10102, 5596, 5428, 10105, 5431, 5433, 5438, 5443, 5444, 10110, 5446, 10113, 5451, 5453, 5456, 10117, 10121, 5458, 5597, 5463, 10124, 5467, 1113, 5600, 10127, 10132, 5471, 5474, 5605, 5475, 10135, 5606, 5481, 10137, 10139, 10146, 5608, 5609, 10148, 5484, 10150, 5488, 10151, 5610, 5491, 10154, 5494, 10158, 10159, 5497, 10160, 5499, 5613, 5615, 10163, 1236, 10168, 10169, 10171, 10176, 10179, 962, 10180, 10183, 10185, 10191, 10192, 10194, 10195, 10200, 10202, 10207, 5617, 5620, 5500, 10209, 5624, 5625, 5501, 5506, 10211, 5508, 5510, 4392, 10213, 1079, 730, 5631, 5514, 5633, 4355, 1245, 5638, 10215, 10217, 5528, 5642, 10221, 10223, 10225, 10231, 10232, 10236, 10243, 10244, 10246, 10247, 10250, 10252, 10253, 10254, 5530, 10256]

eigth_hsb_2 = ["advocate", "agile", "allot", "aloof", "analogy", "anarchy", "apprehend", "atrocity", "augment", "avid", "awry", "banter", "barter", "bizarre", "bonanza", "cache", "capacious", "chastise", "cite", "clad", "clarify", "commemorate", "component", "concept", "confiscate", "connoisseur", "crucial", "culminate", "decipher", "decree", "deface", "deploy", "desolate", "dialect", "dire", "disposition", "eccentric", "embargo", "enigma", "eventful", "evolve", "excerpt", "exotic", "facilitate", "fastidious", "feasible", "ferret", "foreboding", "foster", "gingerly", "grapple", "grope", "gullible", "haggard", "heritage", "humane", "imperative", "infinite", "intervene", "intricate", "inventive", "irascible", "jurisdiction", "loll", "memoir", "millennium", "muster", "onslaught", "ornate", "ovation", "overt", "pang", "perspective", "plausible", "porous", "preposterous", "principal", "pseudonym", "rational", "reception", "recourse", "recur", "renown", "sleek", "staple", "strident", "sublime", "subside", "succumb", "swelter", "tract", "transition", "trepidation", "turbulent", "tycoon", "ultimate", "ungainly", "vie", "vilify", "voracious"]

eigth_hsb_2_ids = []

eigth_hsb_2.each do |name|
	words = Word.where(name: name)
	eigth_hsb_2_ids << words[0].id
end

eigth_hsb_2_ids = [5532, 5536, 5538, 5541, 5321, 5546, 5324, 10023, 10025, 5348, 5552, 10033, 5556, 5350, 10041, 10043, 5351, 5356, 10048, 5357, 5359, 5361, 5560, 5563, 5364, 5366, 5564, 5567, 10074, 5380, 10076, 5388, 10077, 5391, 5392, 5399, 3865, 5409, 10092, 5583, 5223, 5423, 5585, 5587, 5426, 5590, 5591, 5428, 5438, 5444, 5446, 10113, 5451, 5453, 10117, 5597, 5463, 5600, 5471, 5474, 5605, 10135, 5606, 10146, 10148, 5488, 10154, 5494, 10158, 10159, 5497, 10160, 5613, 10169, 10176, 10179, 962, 10191, 10195, 10202, 10207, 5617, 5500, 4392, 5514, 4355, 1245, 5638, 10215, 5642, 10232, 10236, 10243, 10244, 10246, 10247, 10250, 10252, 10253, 10254]
