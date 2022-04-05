# frozen_string_literal: true

stream_services = [
  {
    name:     'Netflix',
    base_url: 'https://www.netflix.com/br/',
  },
  {
    name:     'Prime Video',
    base_url: 'https://www.primevideo.com'  
  },
  {
    name:     'HBO Max',
    base_url: 'https://www.hbomax.com/br/pt'
  }
]

stream_services.each do | service | 
  StreamService.create!(service)
end

puts "Done #{DateTime.current}"
