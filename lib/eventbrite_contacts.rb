require 'eventbrite_contacts/version'
require 'httparty'

module EventbriteContacts
  class Client

  BASE_URL = "https://www.eventbriteapi.com/v3/"

  def initialize(auth_token, user_id)
    @auth_token = auth_token
    @user_id = user_id
  end

  def get_lists(options={})
    url = "#{BASE_URL}users/#{@user_id}/contact_lists/?"
    page = if options[:page].nil? then 1 else options[:page] end
    encoded = URI.encode("#{url}page=#{page}")
    make_request(encoded, "get")
  end

  def get_list(list_id)
    url = "#{BASE_URL}users/#{@user_id}/contact_lists/#{list_id}"
    encoded = URI.encode(url)
    make_request(encoded, "get")
  end

  def add_list(list_name)
    url = "#{BASE_URL}users/#{@user_id}/contact_lists/?"
    encoded = URI.encode("#{url}contact_list.name=#{list_name}")
    make_request(encoded, "post")
  end

  def get_all_contacts(list_id)
    url = "#{BASE_URL}users/#{@user_id}/contact_lists/#{list_id}/contacts"
    page = 1
    contacts = []
    loop do
      encoded = URI.encode("#{url}?page=#{page}")
      response = make_request(encoded, "get")
      contacts << response["contacts"] unless response["contacts"].nil?
      page += 1
      break if response["error"] == "BAD_PAGE"
    end
    contacts.flatten
  end

  def get_contacts(list_id, options={})
    url = "#{BASE_URL}users/#{@user_id}/contact_lists/#{list_id}/contacts?"
    page = if options[:page].nil? then 1 else options[:page] end
    encoded = URI.encode("#{url}page=#{page}")
    make_request(encoded, "get")
  end

  def add_contact(list_id, contact)
    url = "#{BASE_URL}users/#{@user_id}/contact_lists/#{list_id}/contacts/?"
    param_url = "contact.email=#{contact[:email]}&contact.first_name=#{contact[:first_name]}&contact.last_name=#{contact[:last_name]}"
    encoded = URI.encode("#{url}#{param_url}")
    make_request(encoded, "post")
  end

  def delete_contact(list_id, contact_email)
    url = "#{BASE_URL}users/#{@user_id}/contact_lists/#{list_id}/contacts/?"
    encoded = URI.encode("#{url}email=#{contact_email}")
    make_request(encoded, "delete")
  end

  private

  def make_request(url, verb)
    case verb
    when "get"
      HTTParty.get(url, :headers => { "Authorization" => "Bearer #{@auth_token}" })
    when "post"
      HTTParty.post(url, :headers => { "Authorization" => "Bearer #{@auth_token}" })
    when "delete"
      HTTParty.delete(url, :headers => { "Authorization" => "Bearer #{@auth_token}" })
    end
  end

  end
end
