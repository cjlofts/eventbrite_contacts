require 'eventbrite_contacts/version'
require 'httparty'
require 'curb'
require 'net/http'

module EventbriteContacts
  class Client

  BASE_URL = "https://www.eventbriteapi.com/v3/"

  def initialize(auth_token)
    @auth_token = auth_token
  end

  def get_contacts(user_id, list_id)
    url = "#{BASE_URL}/users/#{user_id}/contact_lists/#{list_id}/contacts"
    page = 1
    contacts = []
    loop do
      encoded = URI.encode("#{url}?page=#{page}")
      response = HTTParty.get(encoded, :headers => { "Authorization" => "Bearer #{@auth_token}" })
      contacts << response["contacts"] unless response["contacts"].nil?
      page += 1
      break if response["error"] == "BAD_PAGE"
    end
    contacts.flatten
  end

  # def create_contact(user_id, list_id)
  #   url = "#{BASE_URL}/users/#{user_id}/contact_lists/#{list_id}/contacts"
  #   encoded = URI.encode(url)
  #   binding.pry
  # end

  end
end
