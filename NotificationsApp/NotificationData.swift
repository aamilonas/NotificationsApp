import Foundation

struct NotificationData {
    static let womenNames = ["Emma", "Hannah", "Isabella", "Ava"]
    static let menNames = ["Dan", "Noah", "Oliver", "James"]
    static let mostlyWomenNames = ["Sarah", "Jessica", "Ashley", "Jennifer", "Rachel"]
    static let mostlyMenNames = ["Michael", "Christopher", "Matthew", "Andrew", "Joseph"]
    static let jealousExWomenNames = ["Sara ❌❌❌❌"]
    static let jealousExMenNames = ["Mike ❌❌❌❌"]
    static let groupChatNames = ["The homies ❤️‍🔥"]

    static let friendMessagesWomen = [
        "Hey! Just checking in.", "Let’s hang soon!", "Hope you’re doing well.", "How’s your day going?",
        "You’ve been on my mind lately.", "Wanna catch up this week?", "It’s been too long!", "I saw something that reminded me of you.",
        "You always know how to cheer me up!", "Hope everything’s okay 💛", "What are you watching lately?",
        "Thinking about our last coffee run ☕️", "You always give the best advice!", "Can I vent to you later?",
        "You’re one of my favorite people.", "Let’s plan a chill night soon.", "Are you free to talk for a bit?",
        "Miss our random convos.", "Let me know when you’re free!", "You make life better. Just saying 💖",
        "You're the kind of friend everyone needs."
    ]

    static let friendMessagesMen = [
        "Yo, what’s up?",
        "Let’s chill this weekend.",
        "Hit me back when you're free.",
        "You around later?",
        "Game night soon?",
        "We overdue for a catch-up bro.",
        "You watching the game tonight?",
        "Let’s hit the gym soon.",
        "Saw something hilarious — gotta show you.",
        "Bro, let’s get tacos soon.",
        "Miss the crew, let’s link.",
        "You got time for a quick call?",
        "Remember that dumb thing we did?",
        "You down for a chill night?",
        "Need your opinion on something dumb lol.",
        "Let’s run it back this weekend.",
        "We always have the best convos.",
        "You’re one of my real ones.",
        "Need a laugh? Let’s talk.",
        "Let’s vibe soon, man.",
        "The world’s better with you in it.",
        "Need my wingman this weekend, you in?",
        "Bro, your energy’s undefeated. Let’s link.",
        "I swear things are just more fun when you’re around.",
        "Tell me you’re down for something reckless tonight.",
        "When’s our next adventure?",
        "You’re seriously the GOAT. Let’s chill soon.",
        "Not the same without you man, where you been?",
        "You’re basically my good luck charm 😂",
        "Lowkey need your chaotic energy today.",
        "Game night’s boring without you. Save us bro.",
        "We gotta catch up and talk some trash soon.",
        "You always make dumb stuff 10x funnier. Link up?",
        "Life's been too quiet... need a dose of you lol.",
        "You’re literally the main character, let’s make some memories.",
        "You ghosted the group chat, now you owe us.",
        "Miss the chaos you bring 😂",
        "Can’t let another weekend go by without a bro night.",
        "I already know tonight would hit different if you pull up.",
        "No pressure but... we’re kinda all waiting on you.",
        "Need someone to hype me up — you’re the only choice.",
        "Nobody hypes like you, bro. Let’s link.",
        "Bro, we owe ourselves a legendary night.",
        "You + me = instant good times.",
        "Pull up. Don’t make me beg.",
        "Remember: boring nights are illegal when you’re around.",
        "I'm starting to forget how wild we get — fix that?",
        "Need someone to talk trash with immediately.",
        "Whole squad's boring without you, no cap.",
        "The streets miss us together. Let’s fix that.",
        "We make history every time we link up. Just sayin'.",
        "Lowkey forgot how to have fun without you.",
        "If you're not coming, what’s even the point lol.",
        "You’re too good at disappearing. Stop it.",
        "You make even doing nothing fun. Pull up.",
        "Trying to find trouble. Need my partner in crime.",
        "There’s an empty seat at the table, and it’s yours.",
        "Squad's about to start a search party for you bro.",
        "I swear life’s way less spicy without you around.",
        "Let's get into some high quality nonsense this weekend.",
        "Brooo, let’s cause some harmless chaos like old times."
    ]


    static let flirtyMessages = [
        "Hey, can we talk?", "Miss you", "What are you up to?", "You free tonight?", "Just thinking about you",
        "How have you been?", "Can we meet up?", "Lowkey been thinking about you all day 😅", "You crossed my mind... again 😏",
        "Not gonna lie, I kinda miss your face.", "I had a dream about you 👀", "Why are you so hard to forget?",
        "We need to hang out. Like... soon.", "Be honest... did you miss me?", "I always smile when I see your name pop up.",
        "Let’s stop pretending we’re just friends 😉", "You’re trouble. The good kind.", "You still owe me a date btw 😌",
        "Tell me something cute. Or just call me.", "I’m bored. Fix that?", "You + me + tonight = ?",
        "You always know how to make me smile 😘", "Why do I keep smiling when I think of you?", "If I said I was thinking about you... would that be weird?",
        "You’re kinda my favorite distraction 🤭", "Are you always this charming, or is it just with me?", "One text from you can change my whole mood 🥰",
        "If I say I miss you, will you do something about it?", "Do you ever think about... us?", "You’re dangerous — in the best way 🔥",
        "I dare you to make the first move 😉",
        "Thinking about you again.",
            "You really have no idea what you do to me.",
            "I feel like we have unfinished business 😉",
            "You’re dangerously good at making me smile.",
            "Can’t lie... you’ve been on my mind all day.",
            "I’m just saying, we'd be unstoppable together 🔥",
            "I dare you to call me.",
            "You free later? I have an idea 💭",
            "This conversation needs to continue... in person.",
            "Flirting with you is starting to feel like a full-time job 😅",
            "I wasn’t even trying to think about you... and yet, here we are.",
            "Your name just looks better on my phone than anyone else’s.",
            "One of these days, I’m stealing you away.",
            "You’re officially my favorite distraction 🥰",
            "You’re not making it easy to focus today.",
            "Lowkey missing your energy right now.",
            "What’s something you’ve never told anyone? 👀",
            "Why do you always make me want to stay up late texting you?",
            "I'm warning you... you're becoming addictive 😏",
            "You + me + tonight = perfection 🔥",
            "Don't tempt me... unless you mean it.",
            "You know you’re trouble, right?",
            "Your vibe is kinda my favorite thing right now 😌",
            "I like us. Whatever this is.",
            "Tell me something that'll make me smile right now.",
            "Honestly, you make it way too easy to flirt.",
            "I’m in the mood for a little adventure. You in?",
            "You’re like my favorite notification 💬",
            "Bet you can’t go a whole day without texting me 😉",
            "What are you doing later... asking for a friend.",
            "You’re the plot twist I wasn’t ready for.",
            "Come steal my hoodie already 🧥",
            "If I flirt any harder, it might be illegal.",
            "You’re the highlight of my day. Every time.",
            "Do you even realize how attractive you are?",
            "I kinda like the way you think. Dangerous, but I like it.",
            "Careful... I'm starting to get attached.",
            "You + coffee + me = perfect morning ☕",
            "You might be bad for my health... but totally worth it 🔥",
            "I'd lose sleep for you. Not even mad about it.",
            "Every time my phone lights up, I hope it’s you.",
            "Just admit it... you missed me first.",
            "How are you real though? Seriously.",
            "Not trying to brag but... you'd look really good next to me.",
            "You make 'what are you up to' feel like a loaded question.",
            "Let's make some bad decisions together 😈",
            "You’re the type I could accidentally fall for.",
            "Texting you is my favorite form of procrastination.",
            "You’re like a song I can’t get out of my head 🎶",
            "Is it bad if I want to hear all your secrets?",
            "Tell me you miss me without telling me you miss me.",
            "The way you smile should honestly be illegal.",
            "You're way too good at being cute.",
            "The chemistry is crazy and we both know it 🔥",
            "We should stop pretending this is just friendly.",
            "I feel like you’re trouble... the fun kind.",
            "Don’t make me wait too long for you.",
            "Your energy is addictive, not even sorry.",
            "I feel like you're the type I get in trouble for.",
            "Warning: flirting level approaching dangerous levels 🚨",
            "You being you is already a green flag 🚦",
            "Let’s be the reason people believe in soulmates again.",
            "I like my conversations how I like my people: nonstop and exciting.",
            "You’re making it very hard to play it cool over here.",
            "You’re lowkey all I’ve been thinking about.",
            "Seriously though, how are you still single?",
            "You’re distracting... but like, in the best way possible.",
            "You might be my favorite bad decision yet.",
            "Why do you always make me smile like an idiot?",
            "If you're looking for signs, this is it ✨",
            "You're the type of distraction I don't mind at all.",
            "Would it be too forward if I said I want you right now?",
            "You're like the spark I didn’t know I needed.",
            "Everything’s better when you’re around. Just facts.",
            "Honestly? I'd rather be with you right now.",
            "You bring out the worst and best in me, congrats.",
            "Every time you text first, my day gets 100x better.",
            "If my phone buzzes and it's not you, I’m lowkey disappointed.",
            "Just putting it out there: I’m free tonight if you are.",
            "It’s crazy how one text from you can shift my whole mood.",
            "If kisses were texts, you’d be flooded by now 😘",
            "You’re kinda making it impossible to keep my cool.",
            "If flirting were a sport, we’d both be undefeated.",
            "Honestly? I’d lose track of time with you every day.",
            "You bring out my playful side, not even mad about it 😇",
            "If you knew how often you crossed my mind, you'd probably call me obsessed.",
            "You're dangerously good at making me fall harder each day.",
            "Spoiler alert: you’re stuck with me now.",
            "If you’re trying to steal my heart... you’re doing a terrible job. (Because you already have it.)",
            "You’re exactly my type — annoying, adorable, and absolutely irresistible 😏"
    ]

    static let groupChatMessages = [
        "Alex: Yo who's down tonight?",
        "Chris: I'm 100% in",
        "Sam: Let’s do it",
        "Jordan: I got work early but maybe",
        "Taylor: Bring snacks this time",
        "Alex: I'm bringing vibes only",
        "Chris: I’ll drive if someone buys me food",
        "Sam: Bet, same place as last time?",
        "Jordan: Group selfie mandatory",
        "Taylor: We NEED to make it a movie",
        "Alex: Calling it now — best night of the year",
        "Chris: Let’s run it back",
        "Sam: Already hyped",
        "Jordan: Remember last time? Legendary",
        "Taylor: Group chat gonna be wild later",
        "Alex: I’ll bring the speaker",
        "Chris: Pack your chargers too",
        "Sam: Yo can we get matching shirts this time??",
        "Jordan: New inside jokes loading...",
        "Taylor: Squad goals activated",
        // New additions:
        "Alex: Someone better bring snacks this time",
        "Chris: Calling dibs on shotgun",
        "Sam: We staying out all night or what?",
        "Jordan: No drama allowed this time",
        "Taylor: I’m preordering pizza right now",
        "Alex: We need a playlist — who’s got it?",
        "Chris: Last one there buys the first round",
        "Sam: Just got a new outfit for tonight",
        "Jordan: Group hug mandatory",
        "Taylor: Shotgun the aux cord",
        "Alex: I'm literally so ready",
        "Chris: We better take like 100 pictures",
        "Sam: If you bail you're dead to me",
        "Jordan: This is about to be legendary",
        "Taylor: Already telling everyone it’s gonna be wild",
        "Alex: Group stretch before we go lol",
        "Chris: I’m not driving if we go late",
        "Sam: Bring extra chargers this time",
        "Jordan: It’s not a real night unless someone cries laughing"
    ]


    static let jealousExMessages = [
        "I still dream about us every night... please talk to me.",
        "You’re the only one I’ll ever want. Please give me another chance.",
        "No one compares to you. Please... I’ll do anything.",
        "I'm lost without you. Please say something.",
        "I still keep everything you ever gave me.",
        "We were perfect... I know we can be again.",
        "I can’t imagine my life without you in it.",
        "You’re my everything. Please don’t shut me out.",
        "I’m still waiting for you. I always will.",
        "Please just meet me. One more time. Just us.",
        "I know I messed up. I’d give anything to fix it.",
        "You’re the only one who truly knows me.",
        "I can't stop thinking about you. It's killing me.",
        "If you called me right now, I'd drop everything.",
        "I don't care how long it takes... I'll wait for you.",
        "Please don't forget about what we had. It was real.",
        "I miss you more than words can say.",
        "I'll never stop loving you. Ever.",
        "If you ever need anything... anything at all... I'm here.",
        "No one else matters. Only you.",
        
        // 🔥 New Maximum Desperation messages 🔥
        "I drove by your place today... I just needed to feel close to you.",
        "I can't eat, I can't sleep. All I do is think about you.",
        "Everyone says I should move on, but I know we're meant to be.",
        "Every love song reminds me of you. I cry almost every night.",
        "I don't want anyone else. I’ll wait forever if I have to.",
        "Please don't block me... you're the only one I want to hear from.",
        "Every time my phone buzzes I pray it's you.",
        "I'd walk a thousand miles just to see you smile again.",
        "You don’t know how empty everything feels without you.",
        "Please, just say you miss me too. Even if it’s a lie."
    ]


    // Emojis
    static let flirtyEmojisWomen = ["🥰", "💕", "💖", "😍", "💘", "😘", "💓", "🌷", "✨"]
    static let flirtyEmojisMen = ["😏", "🔥", "❤️", "😎", "💪", "😉", "👀", "💥", "🤤", "🏹"]
    static let friendEmojisWomen = ["😊", "🌟", "🥰", "💕", "🎀", "🌈", "🍀", "💫", "🎉", "📚"]
    static let friendEmojisMen = ["👊", "😎", "🤙", "🏀", "🍻", "🎮", "⚡️", "🎉", "🏆", "💬"]
    static let jealousExEmojis = ["💔", "😭", "😢", "🥺", "😔", "😞", "😩", "💭", "📩", "📞"]

    static func getNames(for category: String) -> [String] {
        let key: String
        switch category {
        case "Women": key = "WomenNames"
        case "Men": key = "MenNames"
        case "Women (Friends)": key = "WomenFriendNames"
        case "Men (Friends)": key = "MenFriendNames"
        case "Jealous Ex (Woman)": key = "JealousExWomen"
        case "Jealous Ex (Man)": key = "JealousExMen"
        default: return []
        }

        if let saved = UserDefaults.standard.stringArray(forKey: key), !saved.isEmpty {
            return saved
        }

        switch category {
        case "Women", "Women (Friends)": return womenNames
        case "Men", "Men (Friends)": return menNames
        case "Jealous Ex (Woman)": return jealousExWomenNames
        case "Jealous Ex (Man)": return jealousExMenNames
        default:
            return []
        }
    }

    static func getMessage(for category: String, emojiLevel: String) -> String {
        let messages: [String]
        let emojis: [String]

        switch category {
        case "Women (Friends)":
            messages = friendMessagesWomen
            emojis = emojiLevel == "Med" ? friendEmojisWomen : (emojiLevel == "High" ? friendEmojisWomen : [])
        case "Men (Friends)", "Group Chat":
            messages = friendMessagesMen
            emojis = emojiLevel == "Med" ? friendEmojisMen : (emojiLevel == "High" ? friendEmojisMen : [])
        case "Women":
            messages = flirtyMessages
            emojis = emojiLevel == "Med" ? flirtyEmojisWomen : (emojiLevel == "High" ? flirtyEmojisWomen : [])
        case "Men":
            messages = flirtyMessages
            emojis = emojiLevel == "Med" ? flirtyEmojisMen : (emojiLevel == "High" ? flirtyEmojisMen : [])
        case "Jealous Ex (Man)", "Jealous Ex (Woman)":
            messages = jealousExMessages
            emojis = emojiLevel == "Med" ? jealousExEmojis : (emojiLevel == "High" ? jealousExEmojis : [])
        default:
            messages = flirtyMessages
            emojis = []
        }

        var message = messages.randomElement() ?? "Hello"
        if !emojis.isEmpty {
            if emojiLevel == "Med" {
                message += " " + emojis.shuffled().prefix(2).joined(separator: " ")
            } else if emojiLevel == "High" {
                message += " " + Array(repeating: emojis.randomElement() ?? "", count: 4).joined(separator: " ")
            }
        }
        return message
    }

    static func getDefaultNames(for category: String) -> [String] {
        switch category {
        case "Women", "Women (Friends)":
            return ["Emma", "Hannah", "Isabella", "Ava"]
        case "Men", "Men (Friends)":
            return ["Dan", "Noah", "Oliver", "James"]
        case "Mostly Women":
            return ["Sarah", "Jessica", "Ashley", "Jennifer", "Rachel"]
        case "Mostly Men":
            return ["Michael", "Christopher", "Matthew", "Andrew", "Joseph"]
        case "Jealous Ex (Woman)":
            return ["Sara ❌❌❌❌"]
        case "Jealous Ex (Man)":
            return ["Mike ❌❌❌❌"]
        case "Group Chat":
            return ["The homies ❤️‍🔥"]
        default:
            return []
        }
    }
}
