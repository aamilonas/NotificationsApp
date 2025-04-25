import Foundation

struct NotificationData {
    static let womenNames = ["Emma", "Hannah", "Isabella", "Ava"]
    static let menNames = ["Dan", "Noah", "Oliver", "James"]
    static let mostlyWomenNames = ["Sarah", "Jessica", "Ashley", "Jennifer", "Rachel"]
    static let mostlyMenNames = ["Michael", "Christopher", "Matthew", "Andrew", "Joseph"]
    static let jealousExWomenNames = ["Your Ex 💔", "Ex GF", "That Girl"]
    static let jealousExMenNames = ["Your Ex 💔", "Ex BF", "That Guy"]

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
        "Yo, what’s up?", "Let’s chill this weekend", "Hit me back when free", "You around later?", "Game night soon?",
        "We overdue for a catch-up bro.", "You watching the game?", "Let’s hit the gym soon.", "I saw something hilarious — gotta show you.",
        "Bro, let’s get tacos soon 🌮", "Miss the crew, let’s link.", "You got time for a quick call?", "Remember that dumb thing we did?",
        "You down for a chill night?", "Need your opinion on something dumb lol", "Let’s run it back this weekend 🔁",
        "We always have the best convos.", "You’re one of my real ones.", "Need a laugh? Let’s talk 😂", "Let’s vibe soon man.",
        "The world’s better with you in it."
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
        "I dare you to make the first move 😉"
    ]

    static let flirtyEmojisWomen = ["🥰", "💕"]
    static let flirtyEmojisMen = ["😏", "🔥" , "❤️"]
    static let friendEmojisWomen = ["😊", "🌟", "🥰", "💕"]
    static let friendEmojisMen = ["👊", "😎"]

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
        default: return []
        }
    }

    static func getMessage(for category: String, emojiLevel: String) -> String {
        let messages: [String]
        let emojis: [String]

        switch category {
        case "Women (Friends)":
            messages = friendMessagesWomen
            emojis = emojiLevel == "Med" ? friendEmojisWomen : (emojiLevel == "High" ? flirtyEmojisWomen : [])
        case "Men (Friends)":
            messages = friendMessagesMen
            emojis = emojiLevel == "Med" ? friendEmojisMen : (emojiLevel == "High" ? flirtyEmojisMen : [])
        case "Women", "Jealous Ex (Woman)":
            messages = flirtyMessages
            emojis = emojiLevel == "Med" ? friendEmojisWomen : (emojiLevel == "High" ? flirtyEmojisWomen : [])
        case "Men", "Jealous Ex (Man)":
            messages = flirtyMessages
            emojis = emojiLevel == "Med" ? friendEmojisMen : (emojiLevel == "High" ? flirtyEmojisMen : [])
        default:
            messages = flirtyMessages
            emojis = []
        }

        var message = messages.randomElement() ?? "Hello"
        if !emojis.isEmpty {
            message += " " + emojis.shuffled().prefix(2).joined(separator: " ")
        }
        return message
    }
    
    static func getDefaultNames(for category: String) -> [String] {
        switch category {
        case "Women", "Women (Friends)":
            return ["Emma", "Olivia", "Sophia", "Isabella", "Ava"]
        case "Men", "Men (Friends)":
            return ["Liam", "Noah", "Oliver", "Elijah", "James"]
        case "Mostly Women":
            return ["Sarah", "Jessica", "Ashley", "Jennifer", "Rachel"]
        case "Mostly Men":
            return ["Michael", "Christopher", "Matthew", "Andrew", "Joseph"]
        case "Jealous Ex (Woman)":
            return ["Your Ex 💔", "Ex GF", "That Girl"]
        case "Jealous Ex (Man)":
            return ["Your Ex 💔", "Ex BF", "That Guy"]
        default:
            return []
        }
    }

}
