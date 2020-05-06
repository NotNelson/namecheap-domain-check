require 'nokogiri'
require 'colorize'
require 'rest-client'
require 'json'

# NAMECHEAP
# General API calls restriction: 20/min, 700/hour and 8000/day across the whole key.
API_USER = ''
API_KEY = ''
USERNAME = ''
COMMAND = 'namecheap.domains.check'
CLIENT_IP = ''
NC_SERVICE_URL = 'https://api.namecheap.com/xml.response'

# DATAMUSE
WORD_LIMIT = '20'
DM_SERVICE_URL = 'https://api.datamuse.com/words'

def check_availability(domains)
  answer = RestClient.get(NC_SERVICE_URL,
                          {params: {
                              ApiUser: API_USER,
                              ApiKey: API_KEY,
                              UserName: USERNAME,
                              Command: COMMAND,
                              ClientIp: CLIENT_IP,
                              DomainList: domains} })
  xml = Nokogiri::XML(answer)
  xml.xpath("//xmlns:DomainCheckResult").each do |node|
    domain_name = node.attr('Domain')
    if node.attr('Available') == 'true'
      if node.attr('IsPremiumName') == 'true'
        puts domain_name + ' (Premium)'.colorize(:yellow)
      else
        puts domain_name + ' (Available)'.colorize(:green)
      end
    else
      puts domain_name + ' (Taken)'.colorize(:red)
    end
  end
end

def generate_names(word, concept, extension)
  list = []
  word_list = JSON.parse(RestClient.get(DM_SERVICE_URL,
                                        {params: {
                                            ml: concept,
                                            max: WORD_LIMIT}}))
  word_list.each do |wd|
    list << word + wd["word"].gsub(' ', '') + '.' + extension
  end

  check_availability(list.join(','))
end