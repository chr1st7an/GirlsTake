//
//  BioBubbleLists.swift
//  GirlsTake
//
//  Created by Christian Rodriguez on 3/16/23.
//

import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

let fitness = ["Running", "Swimming", "Hot Girl walks",
               "Pilates", "Cross fit", "HIIT",
               "Barre class", "Soccer", "Dancing",
               "Ballet", "Weight lifting", "Hip Hop",
               "Basketball", "Yoga", "Jazz",
               "Cycling", "Hiking", "Skateboarding",
               "Football", "Baseball", "Jogging",
               "Marathons", "Tennis", "Martial arts",
               "Stretching", "Gymnastics", "Karate",
               "Rock climbing", "Bowling", "Sailing",
               "Pickleball", "Badminton", "Boxing",
               "Snowboarding", "Skiing", "Roller",
               "blading", "Surfing", "Hockey",
               "Ping pong", "Rugby", "Volleyball",
               "Golf", "Mini Golf", "Boating"].chunked(into: 3)

let socialLife = ["Club", "Dinner out", "Live music",
                  "Dive bar", "Rooftop bar", "Jazz bar",
                  "Speakeasy", "Happy hour", "Picnic",
                  "Karaoke", "Coffee date", "Lounge",
                  "TV show binge", "Trivia", "Takeout",
                  "Board games", "Gaming", "Dinner Party",
                  "Cocktail party", "Beer", "Mixology",
                  "Brunch", "Movies", "Wine night",
                  "Eating out", "Stand up comedy", " EDM  ",
                  "Theater", "Concerts",  "Festivals", "Smoking",
                  " Museum ", "Gallery", "Book club",
                  "Camping", "Arcade",  "Hookah lounge"].chunked(into: 3)

let art = ["Sculpting", "Songwriting", "Guitar",
           "Drums", "Singing", "Fashion design",
           "Journaling", "Scrap booking", "Photography",
           "Video production", "Dancing", "Painting",
           "Sketching", "Watercoloring", "Crocheting",
           "Knitting", "Needle point", "Writing",
           "Crafting", "Jewelry making", "Makeup",
           "Reading", "Architecture", "Music"].chunked(into: 3)

let values = ["Christianity", "Atheism", "Judaism",
              "Hinduism", "Buddhism", "Islam",
              "Sikhism", "Environmentalism", "BLM","Self care",
              "LGBTQ+", "Feminism", "My dog",
              "My cat", "My pet", "Nature",
              "Cooking", "My friends", "My family",
              "Baking","Alone time", "Socializing",
              "Social media", "Religion", "Traveling",
              "Education", "Social work", "Volunteering",
              "Vegan", "Vegetarian", "Astrology",
              "Beaches","Meditation", "Exploring new places"].chunked(into: 3)

let descriptors = ["Warm", "Friendly", "Honest",
                   "Trustworthy", "Loyal", "Open-minded",
                   "Loving", "Forgiving", "Funny",
                   "Outgoing", "Introverted", "Extroverted",
                   "Honest", "Kind", "Gentle", "Strong",
                   "Resilient", "Caring", "Assertive",
                   "Hard-working", "Reliable", "Practical",
                   "Responsible", "Mature", "Creative","Consistent",
                   "Appreciative", "Capable", "Quick",
                   "Sensitive", "Perceptive", "Patient",
                   "Thoughtful", "Motivated", "Stubborn"
                   , "Spontaneous", "Athletic", "Smart"].chunked(into: 3)


