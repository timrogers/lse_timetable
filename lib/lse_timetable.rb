require 'httparty'
require 'active_support/core_ext'
require "lse_timetable/version"
require "lse_timetable/exceptions"
require "lse_timetable/timetable_item"

module LseTimetable

  class << self
     attr_accessor :api_username, :api_password
  end

  def self.fetch(options = {})
    check_configuration

    unless options.key?(:username) && options.key?(:password)
      raise AuthenticationError, "You must provide a username and password."
    end

    start = options.delete(:from) { DateTime.now }
    finish = options.delete(:to) { DateTime.now.next_week.next_day(4) } 

    body =  "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" \
              "<retrieveCalendar xmlns=\"http://campusm.gw.com/campusm\">\n" \
                "<username>#{options[:username]}</username>\n" \
                "<password>#{options[:password]}</password>\n" \
                "<calType>course_timetable</calType>\n" \
                "<start>#{start.try(:iso8601)}</start>\n" \
                "<end>#{finish.try(:iso8601)}</end>\n" \
              "</retrieveCalendar>"

    response = HTTParty.post "https://campusm.lse.ac.uk:9443/lse/services/CampusMUniversityService/retrieveCalendar",
                  body: body,
                  basic_auth: {
                    username: api_username,
                    password: api_password
                  },
                  headers: {
                    "Content-Type" => "application/xml"
                  }

    if response.code == 200
      response.parsed_response["retrieveCalendarResponse"]["calendar"]["calitem"].
        map { |node| TimetableItem.new(node) }.sort_by(&:starts_at)
    elsif response.body.include?("Not authorised")
      raise AuthenticationError, "Check your username and password and try again."
    else
      raise GenericError, response.body
    end
  end

  def self.check_configuration
    unless api_username && api_password
      raise ConfigurationError, "You must set #api_username and #api_password."
    end
  end

  private_class_method :check_configuration
end
