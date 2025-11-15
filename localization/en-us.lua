return {
    descriptions = {
        Back={},
        Blind={
            bl_nic_monarch = {
                name = "The Monarch",
                text = {
                    "Fuck Your Kings",
                }
            }
        },
        Edition={},
        Enhanced={},
        Joker = {
            j_nic_technoblade = {
                name = "Technoblade",
                text = {
                    "Prevents Death {C:attention}#2#{C:inactive} [#1#]{} times if chips",
                    "scored are at least {C:attention}#3#%{} of required chips ",
                    "{C:inactive,s:0.8}Increases % by 25% every death",
                    "{s:1.1,C:red,E:2}self destructs when [0]",
                }
            },
            j_nic_machinedramon = {
                name = {
                    "Machinedramon",
                    "{C:black,X:white,s:0.6}MEGA{s:0.6}/{C:black,X:white,s:0.6}VIRUS{s:0.6}/{C:black,X:white,s:0.6}MACHINE"
                },
                text = {
                    {"At end of round, all non {C:attention}Enhanced cards{}",
                    "held in hand turn into {C:attention}Steel{} cards"},
                    {"Played {C:attention}Steel{} cards get destroyed",
                    "and gains {C:mult}+15{} Mult and {X:mult,C:white}X0.5{} Mult",
                    "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult and {X:mult,C:white} X#2# {C:inactive} Mult)"},
                }
            },
            j_nic_button = {
                name = "Button",
                text = {
                    "When {C:attention}Clicked{} or {C:attention}Space is",
                    "{C:attention}Pressed{}, Gains {X:mult,C:white}X0.05{} Mult and",
                    "has a {C:green}#1# in #2#{} chance",
                    "that this card is destroyed",
                    "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult}",
                    " {C:green,s:0.8}Probability{C:inactive,s:0.8} increases by 1-5 every click ",
                }
            },
            j_nic_slycooper = {
                name = "Sly Cooper",
                text = {
                    {"When {C:attention}Blind{} is defeated, Buy",
                    "{C:attention}One Item{} for {C:green}Free{} in the {C:attention}Shop{},",
                    "{C:green}#1# in #2#{} chance you get",
                    "{C:red}Caught{} and {C:attention}Pay Double{}",
                    "{C:inactive}(Currently: #3#)"},
                }
            },
            j_nic_stalagmite = { -- Rare
                name = "Stalagmite",
                text = {
                    {"Played {C:attention}Stone{} card turns {C:dark_edition}Negative",
                    "while {C:dark_edition}Negative {C:attention}Stone{} card gets",
                    "destroyed and increases {C:chips}Chips{} by {C:chips}#2#"},
                    {"{C:chips}+#1#{} Chips for each",
                    "{C:attention}Stone{} card held in hand",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"},
                }
            },
            j_nic_dalgonacookie = {
                name = "Dalgona Cookie",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "it becomes {C:attention}1{} of the 4",
                    "{C:attention}Opened Dalgona Cookies",
                }
            },
            j_nic_dalgonacircle = {
                name = "Dalgona Circle",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}High Card{}, {C:attention}Pair{}, or {C:attention}Two Pair",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    " {C:inactive,s:0.8}This Joker breaks if failed {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} time ",
                }
            },
            j_nic_dalgonatriangle = {
                name = "Dalgona Triangle",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}3oak{}, {C:attention}Straight{}, or {C:attention}Flush",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    " {C:inactive,s:0.8}This Joker breaks if failed {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} time ",
                }
            },
            j_nic_dalgonastar = {
                name = "Dalgona Star",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}Full House{}, {C:attention}4oak{}, or {C:attention}Straight Flush",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
                    " {C:inactive,s:0.8}This Joker breaks if failed {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} time ",
                }
            },
            j_nic_dalgonaumbrella = {
                name = "Dalgona Umbrella",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult",
                    "if the round had a played",
                    "{C:attention}5oak{}, {C:attention}Flush House{}, or {C:attention}Flush Five",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
                    " {C:inactive,s:0.8}This Joker breaks if failed {C:attention,s:0.8}#4#{C:inactive,s:0.8} [#3#]{C:attention,s:0.8} time ",
                }
            },
            j_nic_humantorch = {
                name = "Human Torch",
                text = {
                    {"All played {C:attention}Four of a Kind{} with exactly",
                    "{C:attention}4{} cards, Upgrades {C:attention}Four of a Kind{} by {C:attention}#1#",
                    "{C:attention}levels{} and destroy a {C:attention}random played card"},
                    {"If {C:attention}last played hand{} of round",
                    "has the same conditions above,",
                    "increase the {C:attention}level{} by {C:attention}#2#"},
                }
            },
            j_nic_invisiblewoman = {
                name = "Invisible Woman",
                text = {
                    "If {C:attention}first played{} is a {C:attention}Four of a Kind{} with", 
                    "exactly {C:attention}4{} cards, turns all cards into glass",
                    "{C:inactive,s:0.8}Glass cards have a higher chance to break",
                }
            },
            j_nic_thething = {
                name = "The Thing",
                text = {
                    {"When round begins, adds {C:attention}#1# Stone{}",
                    "cards with a random {C:attention}seal{} to your deck"},
                    {"If {C:attention}first played{} is a {C:attention}Four of a Kind{}",
                    "with exactly {C:attention}4{} cards, increase the",
                    "amount of {C:attention}Stone{} cards by {C:attention}#2#"},
                }
            },
            j_nic_misterfantastic = {
                name = "Mister Fantastic",
                text = {
                    {"All {C:attention}played hands{} with exactly {C:attention}4",
                    "cards are considered {C:attention}Four of a Kind",
                    "and the {C:attention}cards{} will count in scoring"},
                    {"Every {C:blue}Fantastic{} Joker {C:attention}played hands",
                    "condition can be {C:attention}played whenever"},
                }
            },
            j_nic_incognito = {
                name = "Incognito",
                text = {
                    {"This Joker gains {X:mult,C:white} X#3# {} Mult when a",
                    "non {C:spades}Spade{} card is destroyed"},
                    {"Each non {C:spades}Spade{} cards held in hand",
                    "have a {C:green}#1# in #2#{} chance to be destroyed",
                    "{C:spades}Spade{} cards held in hand gives {X:mult,C:white} X#4#{} Mult"},
                }
            },
            j_nic_crazytaxi = {
                name = "Crazy Taxi",
                text = {
                    {"When {C:attention}end of round{} is within {C:attention}time,",
                    "Earns {C:money}$#1#{} and increases {C:money}cash{} by {C:money}3{}",
                    "If {C:red}failed{}, This Joker gets destroyed",
                    "{s:0.8}Time resets every round"},
                    {"Each played {C:attention}#2#{} adds {C:attention}+5 Seconds",
                    "{s:0.8}Rank changes every round"},
                }
            },
            j_nic_strawberrycake = {
                name = "Strawberry Cake",
                text = {
                    {"{C:attention}First hand{} of round turns all",
                    "{C:attention}played cards{} into {C:hearts}Hearts"},
                    {"Each {C:attention}card{} in played {C:attention}Flush",
                    "after {C:attention}first hand{} permanently",
                    "gains {C:mult}+#1#{} Mult when scored"},
                }
            },
            j_nic_ratiotechnique = {
                name = "Ratio Technique",
                text = {
                    "Card located at the {C:attention}7:3{} ratio",
                    "mark {C:attention}in hand{} gets destroyed",
                    "when the {C:attention}first hand played",
                    "{C:inactive,s:0.8}| - | - | - | - | - | - | - o - | - | - |",
                    "{C:inactive}(Currently #1##2#)",
                }
            },
            j_nic_invertedspearofheaven = {
                name = "Inverted Spear of Heaven",
                text = {
                    {"When {C:attention}Blind{} is selected, destroy Adjacent",
                    "Jokers and gain {X:mult,C:white}X0.5{} Mult for each",
                    "{C:inactive,s:0.8}This also includes Enternals",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"},
                    {"If Both Jokers get destroyed in",
                    "{C:attention}Boss Blind{}, disable {C:attention}Boss Blind{} effects"},
                }
            },
            j_nic_cyan = {
                name = "Cyan",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "{X:attention,C:white}X#1#{} Blind Requirement and",
                    "create {C:attention}1 {C:spectral}Black Hole",
                    "{C:inactive}(Must have room",
                    "{C:inactive}or it won't activate)",
                }
            },
            j_nic_astromancer = {
                name = "Astromancer",
                text = {
                    "Create a {C:planet}Planet{} card",
                    "when {C:attention}Blind{} is selected",
                    "{C:inactive}(Must have room)",
                }
            },
            j_nic_cartonomer = {
                name = "Cartonomer",
                text = {
                    "All {C:tarot}Tarot{} cards and",
                    "{C:tarot}Arcana Packs{} in",
                    "the shop are {C:attention}free",
                },
            },
            j_nic_tierlist = {
                name = "Tierlist",
                text = {
                    "Add rank of first played",
                    "{C:attention}number{} card to Mult",
                    "Minus rank of last played",
                    "{C:attention}number{} card to Mult",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                }
            },
            j_nic_scenario = {
                name = "Scenario",
                text = {
                    "Earn {C:money}$5{} when you beat",
                    "a {C:attention}Blind{} with at least",
                    "one {V:1}#1#{} Joker",
                    "{C:inactive,s:0.8}This Joker doesn't count and",
                    "{C:inactive,s:0.8}Rarity changes when successful",

                }
            },
            j_nic_mending = {
                name = "Mending",
                text = {
                    "Any {C:attention}playing card",
                    "{C:red}destroyed{} gets copied",
                    "into the discard pile",
                }
            },
            j_nic_calligramjoker = {
                name = "Calligram Joker",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "{C:attention}J, O, K, E, R{} in",
                    "adjacent Joker's name",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                }
            },
            j_nic_cloverpit = {
                name = "Clover Pit",
                text = {
                    "When {C:attention}Clicked{} or {C:attention}Space is",
                    "{C:attention}Pressed{}, spend {C:money}$#1#{} and get",
                    "between {C:mult}#2#{} to {C:mult}#3#{} Mult",
                    "{C:inactive}(Currently {C:mult}#4##5#{C:inactive} Mult)",
                    "{C:inactive,s:0.8}Value doubles after {C:attention,s:0.8}Boss Blind",
                    "{C:inactive,s:0.8}and current Mult resets",
                }
            },
            j_nic_cuphead = {
                name = "Cuphead",
                text = {
                    {" Each played {C:hearts}Heart{} cards ",
                    "increases {C:attention}Super Meter",
                    "{C:inactive}Super Meter: {V:1}#1# {V:2}#2# {V:3}#3# {V:4}#4# {V:5}#5#"},
                    {"Played hand that doesn't",
                    "contain {C:hearts}Heart{} cards",
                    "uses the {C:attention}Super Meter"},
                    {"{C:hearts}Extra Parry{} increase",
                    "Mult by {C:mult}+#8#{} Mult",
                    "{C:inactive}Each EX does {C:mult}+#6#{C:inactive} Mult",
                    "{C:inactive}SUPER EX does {C:mult}+#7#{C:inactive} Mult"},
                }
            },
            j_nic_jokrle = {
                name = "Jokrle",
                text = {
                    {"This Joker gains {C:mult}+#32#{} Mult per",
                    "remaining guess when solved",
                    "{C:inactive}(Currently {C:mult}+#31#{C:inactive} Mult)"},
                    {"{V:1}[#1#]{} {V:2}[#2#]{} {V:3}[#3#]{} {V:4}[#4#]{} {V:5}[#5#]",
                    "{V:6}[#6#]{} {V:7}[#7#]{} {V:8}[#8#]{} {V:9}[#9#]{} {V:10}[#10#]",
                    "{V:11}[#11#]{} {V:12}[#12#]{} {V:13}[#13#]{} {V:14}[#14#]{} {V:15}[#15#]",
                    "{V:16}[#16#]{} {V:17}[#17#]{} {V:18}[#18#]{} {V:19}[#19#]{} {V:20}[#20#]",
                    "{V:21}[#21#]{} {V:22}[#22#]{} {V:23}[#23#]{} {V:24}[#24#]{} {V:25}[#25#]",
                    "{V:26}[#26#]{} {V:27}[#27#]{} {V:28}[#28#]{} {V:29}[#29#]{} {V:30}[#30#]",
                    "{C:inactive,s:0.8}Answer: {V:31,s:0.8}#33#"},
                }
            },
            j_nic_invert = {
                name = "Invert",
                text = {
                    "Each {C:spades}Spade{} cards held in hand",
                    "have a {C:green}#1# in #2#{} chance to be {C:dark_edition}Negative",
                }
            },
            
            -- Teto

            j_nic_kasanejokto = {
                name = "Kasane Jokto",
                text = {
                    "{C:attention}Retrigger{} played {C:attention}4s{}",
                    "an additional {C:attention}two{} times",
                    "{C:inactive,s:0.8,E:1}Inspired By: Neato Jokers",
                }
            },
            j_nic_ambassadorteto = {
                name = "Ambassador Teto",
                text = {
                    "All cards held in hand",
                    "change {C:attention}suits{} in this order",
                    "{C:clubs}Clubs{} > {C:diamonds}Diamonds{} >",
                    "{C:spades}Spades{} > {C:hearts}Hearts{}",
                    "{C:inactive}(Stops at {C:hearts}Hearts{C:inactive})",
                    "{C:inactive,s:0.8,E:1} Song By: dada",
                }
            },
            j_nic_pear = {
                name = "Pear",
                text = {
                    "Level up the next {C:attention}#3#{C:inactive} [#2#]{} played",
                    "{C:attention}Pair{} by {C:attention}#1#{} and then {C:red,E:2}self destructs",
                }
            }, 
            j_nic_pearto = {
                name = "Pearto",
                text = {
                    "Level up played {C:attention}Pair{} by {C:attention}#3#",
                    "{C:green}#1# in #2#{} chance this card",
                    "is destroyed at end of round",
                }
            },
            j_nic_doctorkidori = {
                name = "Doctor Kidori",
                text = {
                    "All cards are",
                    "considered {C:attention}4{}",
                    "{C:inactive,s:0.8,E:1}Song By: {C:inactive,f:5,s:0.8,E:1}原口沙輔",
                    "{C:inactive,s:0.8,E:1} Hako, Sasuke Haraguchi",
                }
            },
            j_nic_birdbrainteto = { 
                name = "Birdbrain Teto",
                text = {
                    "This Joker gains {C:mult}+#2#{} Mult",
                    "per {C:attention}consecutive Pair",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{C:inactive,s:0.8,E:1}Song By: Jamie Paige",

                }
            }, 
            j_nic_tenebrerossosangueteto = { 
                name = "Tenebre Rosso Sangue Teto",
                text = {
                    "This Joker gains {C:money}$#1#{} for",
                    "each {C:hearts}Heart{} card destroyed",
                    "{C:inactive,s:0.8,E:1}Song By: Sandwich",
                }
            },
            j_nic_spokenforteto = { 
                name = "Spoken For Teto",
                text = {
                    "Each {C:inc_teto}Teto{} themed {C:attention}card",
                    "gives {X:red,C:white} X#1# {} Mult ",
                    "{C:inactive,s:0.8,E:1}Song By: FLAVOR FOLEY",
                }
            },
            j_nic_tetowordoftheday = { 
                name = "Teto Word Of The Day",
                text = {
                    "After {C:attention}#2# Boss Blind{} rounds,",
                    "sell this card to {C:attention}Create",
                    "a random {C:inc_teto}Teto{} Joker",
                    "{C:inactive,s:0.8}(Must have room)",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)",
                }
            },
            j_nic_mesmerizerteto = { 
                name = "Mesmerizer Teto",
                text = {
                    "Retrigger leftmost {C:inc_teto}Teto",
                    "Joker {C:attention}#1#{} additional times",
                    "{C:inactive,s:0.8,E:1}Song By: 32ki",
                }
            },
            j_nic_spamteto = {
                name = "[Spamteto]",
                text = {
                    "Earn {X:money,C:white}[ +$#1#% ]{} of current",
                    "cash at end of round",
                    "{C:inactive}(Cash out {C:money}$#2#{C:inactive})",
                    "{C:inactive,s:0.8} [Press F1 For] HELP",
                }
            },
            j_nic_tetoris = {
                name = "Tetoris",
                text = {
                    "Create a {C:tarot}Sun Tarot{} card",
                    "for every {C:attention}#2#{C:inactive} [#1#] {C:attention}hands{}",
                    "that contains {C:hearts}Hearts",
                    "{C:inactive}(Must have room)",
                    "{C:inactive,s:0.8,E:1}Song By: Hiiragi Magnetit",
                }
            },
            j_nic_minimumrageteto = {
                name = "Minimum Rage Teto",
                text = {
                    "Recent bought {C:attention}card cost",
                    "adds into current {C:mult}Mult{},",
                    "resets when any {C:attention}card{} is {C:attention}sold",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{C:inactive,s:0.8,E:1}Song By: MonochroMenace",
                }
            },
            j_nic_tetoterritory = {
                name = "Teto Territory",
                text = {
                    "When {C:attention}Boss Blind{} is selected,",
                    "a random non {C:inc_teto}Teto{} Joker", 
                    "turns into a {C:inc_teto}Teto{} Joker",
                    "{C:inactive,s:0.8} Food Jokers turn into Pears",
                    "{C:inactive,s:0.8,E:1}Song By: Oxi",
                }
            },
            j_nic_contradictionsteto = {
                name = "Contradictions Teto",
                text = {
                    "All {C:attention}Enhanced {C:hearts}Heart{} cards ",
                    "in your {C:attention}full deck{} changes",
                    "{C:attention}Enhancment{} after scoring",
                    "{C:inactive,s:0.8,E:1}Song By: darkbluecat",
                }
            },

            -- Scrapped

            j_nic_overflow = {
                name = "Overflow",
                text = {
                    "Leftover {C:chips}chips{} from the {C:attention}score", 
                    "{C:attention}requirement{} are {C:attention}halved{} and used as",
                    "current {C:chips}chips{} for the {C:attention}first hand",
                    "{C:inactive}(Leftover chips last round: {C:attention}#1#{C:inactive})",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                }
            },
            j_nic_reroll = {
                name = "Infinite Reroll",
                text = {
                    "+1 Extra {C:attention}Shop{} Slot",
                    "{C:green}Infinite Reroll",
                }
            },
            j_nic_thetruefibonaccisequence = {
                name = "The True Fibonacci Sequence",
                text = {
                    "When {C:attention}Scored{}, Increases {X:chips,C:white}XChips",
                    "by the {C:attention}Fibonacci Sequence",
                    "{C:inactive} 1, 2, 3, 5, 8, 13, 21, 34, 55... etc",
                    "{C:inactive}(Currently {X:chips,C:white} X#1# {C:inactive} Chips)",
                }
            },
        },
        Other={
            nic_tetosticker = {
                name = "Teto",
                text = {
                    "This Joker is",
                    "considered a {C:inc_teto}Teto",
                }
            },
            nic_moonphases = {
                name = "Moon Phases",
                text = {
                    "When in pack, {C:spectral}Moon{} goes into", 
                    "{C:attention}Consumeables slot{} when {C:attention}used",
                    "{C:inactive}(Must have room)",
                }
            },
            nic_spades_no_debuff = {
                name = " Passive Ability ",
                text = {
                    "{C:spades}Spades{} can't", 
                    "be debuffed",
                }
            }
        },
        Planet={},
        Spectral={
            c_nic_newmoon = {
                name = "New Moon",
                text = {
                    "Changes {C:spectral}Phases{} after every {C:attention}Play",
                    "Can only {C:attention}use{} in {C:attention}Shop",
                }
            },
            c_nic_waxingcrescent = {
                name = "Waxing Crescent",
                text = {
                    "Changes {C:spectral}Phases{} after every {C:attention}Play",
                    "Can only {C:attention}use{} in {C:attention}Shop",
                }
            },
            c_nic_firstquarter = {
                name = "First Quarter",
                text = {
                    "Changes {C:spectral}Phases{} after every {C:attention}Play",
                    "Can only {C:attention}use{} in {C:attention}Shop",
                }
            },
            c_nic_waxinggibbous = {
                name = "Waxing Gibbous",
                text = {
                    "Changes {C:spectral}Phases{} after every {C:attention}Play",
                    "Can only {C:attention}use{} in {C:attention}Shop",
                }
            },
            c_nic_fullmoon = {
                name = "Full Moon",
                text = {
                    "Changes {C:spectral}Phases{} after every {C:attention}Play",
                    "Can only {C:attention}use{} in {C:attention}Shop",
                }
            },
            c_nic_waninggibbous = {
                name = "Waning Gibbous",
                text = {
                    "Changes {C:spectral}Phases{} after every {C:attention}Play",
                    "Can only {C:attention}use{} in {C:attention}Shop",
                }
            },
            c_nic_thirdquarter = {
                name = "Third Quarter",
                text = {
                    "Changes {C:spectral}Phases{} after every {C:attention}Play",
                    "Can only {C:attention}use{} in {C:attention}Shop",
                }
            },
            c_nic_waningscrescent = {
                name = "Waning Crescent",
                text = {
                    "Changes {C:spectral}Phases{} after every {C:attention}Play",
                    "Can only {C:attention}use{} in {C:attention}Shop",
                }
            },
        },
        Stake={},
        Tag={},
        Tarot={
            c_nic_tetotarot = {
                name = "Tetarot",
                text = {
                    "Gives selected Joker",
                    "a {C:inc_teto}Teto{} Sticker",
                    "{C:inactive,s:0.8} Food Jokers turn into Pears",
                }
            },
        },
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={
            c_nic_incognito = "OOPS? ALL SWOONS!",
            c_nic_machinedramon = "THE FUTURE WILL BE PAVED WITH METAL!",
        },
        collabs={},
        dictionary={
            k_nic_incognito = "Incognito",
            k_nic_teto = "Teto",
            k_nic_scrapped = "Scrapped",
            ph_nic_technoblade = "TECHNOBLADE NEVER DIES!",
        },
        high_scores={},
        labels={
            nic_tetosticker = "Teto",
        },
        poker_hand_descriptions={},
        poker_hands={},
        quips={
            -- Win

            nic_tetowordofthedaywin1 = {
                "Teto Word Of The Day",
                "      Winner :D"
            },
            nic_peartowin1 = {"Pear"},

            -- Loss

            nic_tetowordofthedaylose1 = {
                "Teto Word Of The Day",
                "      Loser :P"
            },
        },
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={
            nic_active = "Active!",
            nic_inactive = "Inactive!",
            nic_tetoactive = "Mesmerized!",
            nic_tetoinactive = "No Luck! No Hope!",
        },
        v_text={
            ch_c_nic_incognito1 = {
                "You have {C:clubs}Clubs{}, {C:hearts}Hearts{}, {C:diamonds}Diamonds{}"
            },
            ch_c_nic_incognito2 = {
                "But you don't have any {C:spades}Spades{}"
            },
            ch_c_nic_incognito3 = {
                "Let's see how {C:spades}Incognito{} you are"
            },
            ch_c_nic_machinedramon1 = {
                "MACHINEDRAMON"
            },
        },
    },
}