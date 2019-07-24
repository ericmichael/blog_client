require "httparty"
require 'json'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def getAllPosts()
    url = 'https://still-citadel-59542.herokuapp.com/posts'
    #fetch the JSON string at the URL via GET request
    response = HTTParty.get(url)
    #convert JSON string into ruby array or hash
    data = JSON.parse(response)
    #return an array of Ruby Hashes parsed from the response string
    return data
end

def createPost(title, body)
    #hash of parameters to send
    parameters = {
        body: { #parameters to send go here
            "title" => title,
            "body" => body
        }
    }
    url = 'https://still-citadel-59542.herokuapp.com/posts'
    #fetch the JSON string at the URL via POST request, send parameters
    response = HTTParty.post(url, parameters)
    #convert JSON string into ruby array or hash
    data = JSON.parse(response)
    #return parsed data
    return data
end

def updatePost(id, title, body)
    #your code here

end

def deletePost(id)
    #your code here
end

loop do
    puts "Welcome to CoolBlog!"
    puts "1) View Posts"
    puts "2) Create Post"
    puts "3) Update Post"
    puts "4) Delete Post"
    puts "5) Quit"
    print "Choice: "
    choice = gets.to_i

    if(choice == 1)
        posts = getAllPosts()
        posts.each do |post_hash|
            puts "------------------"
            id = post_hash['id']
            title = post_hash['title']
            body = post_hash['body']
            puts "Post: #{id}"
            puts "Title: #{title}"
            puts "Body: #{body}"
            puts "------------------"
        end
    elsif choice == 2
        print "Enter title: "
        title = gets.chomp
        print "Enter body: "
        body = gets.chomp
        createPost(title, body)
    elsif choice == 3
        print "Enter ID of post to update: "
        id = gets.chomp
        print "Enter new title: "
        title = gets.chomp
        print "Enter new body: "
        body = gets.chomp
        updatePost(id, title, body)
    elsif choice == 4
        print "Enter ID of post to delete: "
        id = gets.chomp
        deletePost(id)
    end

break if choice == 5

end